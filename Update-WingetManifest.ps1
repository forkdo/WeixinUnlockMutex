#!/usr/bin/env pwsh
#Requires -Version 7.0

<#
.SYNOPSIS
    Updates WinGet manifests with the latest release information

.DESCRIPTION
    This script automatically updates the WinGet manifest files with the latest
    release version, download URL, and SHA256 hash from GitHub releases.

.PARAMETER Version
    The version to update to (e.g., "1.0.0"). If not specified, will use git tag.

.PARAMETER MSIPath
    Path to the local MSI file to calculate SHA256 hash. If not specified,
    will download from GitHub releases.

.EXAMPLE
    .\Update-WingetManifest.ps1 -Version "1.0.0"
    
.EXAMPLE
    .\Update-WingetManifest.ps1 -Version "1.0.0" -MSIPath ".\WeChatPC-v1.0.0.msi"
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $false)]
    [string]$Version,
    
    [Parameter(Mandatory = $false)]
    [string]$MSIPath
)

# Constants
$RepoOwner = "forkdo"
$RepoName = "WeixinUnlockMutex"
$PackageId = "forkdo.WeixinUnlockMutex"
$WingetDir = "winget"

function Get-LatestVersion {
    if ($Version) {
        return $Version.TrimStart('v')
    }
    
    # Try to get version from git tag
    try {
        $gitTag = git describe --tags --abbrev=0 2>$null
        if ($gitTag) {
            return $gitTag.TrimStart('v')
        }
    }
    catch {
        Write-Warning "Could not get version from git tag"
    }
    
    throw "Version must be specified or available as git tag"
}

function Get-FileSHA256 {
    param([string]$FilePath)
    
    if (Test-Path $FilePath) {
        $hash = Get-FileHash -Path $FilePath -Algorithm SHA256
        return $hash.Hash
    }
    
    throw "File not found: $FilePath"
}

function Download-MSIAndGetHash {
    param([string]$Version)
    
    $msiUrl = "https://github.com/$RepoOwner/$RepoName/releases/download/v$Version/WeChatPC-v$Version.msi"
    $tempFile = [System.IO.Path]::GetTempFileName() + ".msi"
    
    try {
        Write-Host "Downloading MSI from: $msiUrl"
        Invoke-WebRequest -Uri $msiUrl -OutFile $tempFile -ErrorAction Stop
        
        $hash = Get-FileSHA256 -FilePath $tempFile
        Write-Host "SHA256: $hash"
        return $hash
    }
    finally {
        if (Test-Path $tempFile) {
            Remove-Item $tempFile -Force
        }
    }
}

function Update-ManifestFile {
    param(
        [string]$FilePath,
        [string]$Version,
        [string]$SHA256Hash
    )
    
    if (-not (Test-Path $FilePath)) {
        Write-Warning "Manifest file not found: $FilePath"
        return
    }
    
    $content = Get-Content $FilePath -Raw
    
    # Update version
    $content = $content -replace 'PackageVersion: [\d\.]+', "PackageVersion: $Version"
    
    # Update installer URL
    $msiUrl = "https://github.com/$RepoOwner/$RepoName/releases/download/v$Version/WeChatPC-v$Version.msi"
    $content = $content -replace 'InstallerUrl: https://github\.com/[^/]+/[^/]+/releases/[^\s]+', "InstallerUrl: $msiUrl"
    
    # Update SHA256
    if ($SHA256Hash) {
        $content = $content -replace 'InstallerSha256: [A-F0-9]+', "InstallerSha256: $SHA256Hash"
    }
    
    # Update release date
    $today = Get-Date -Format "yyyy-MM-dd"
    $content = $content -replace 'ReleaseDate: \d{4}-\d{2}-\d{2}', "ReleaseDate: $today"
    
    Set-Content -Path $FilePath -Value $content -NoNewline
    Write-Host "Updated: $FilePath"
}

# Main execution
try {
    $versionNumber = Get-LatestVersion
    Write-Host "Updating WinGet manifests for version: $versionNumber"
    
    # Get SHA256 hash
    $sha256Hash = $null
    if ($MSIPath) {
        $sha256Hash = Get-FileSHA256 -FilePath $MSIPath
    } else {
        try {
            $sha256Hash = Download-MSIAndGetHash -Version $versionNumber
        }
        catch {
            Write-Warning "Could not download MSI to calculate hash: $($_.Exception.Message)"
            Write-Host "You may need to update the SHA256 hash manually in the installer manifest"
        }
    }
    
    # Update all manifest files
    $manifestFiles = @(
        "$WingetDir\$PackageId.yaml",
        "$WingetDir\$PackageId.installer.yaml",
        "$WingetDir\$PackageId.locale.en-US.yaml",
        "$WingetDir\$PackageId.locale.zh-CN.yaml"
    )
    
    foreach ($file in $manifestFiles) {
        Update-ManifestFile -FilePath $file -Version $versionNumber -SHA256Hash $sha256Hash
    }
    
    Write-Host "`nWinGet manifests updated successfully!" -ForegroundColor Green
    Write-Host "Version: $versionNumber" -ForegroundColor Cyan
    if ($sha256Hash) {
        Write-Host "SHA256: $sha256Hash" -ForegroundColor Cyan
    }
    
    Write-Host "`nNext steps:" -ForegroundColor Yellow
    Write-Host "1. Review the updated manifest files"
    Write-Host "2. Test installation: winget install --manifest $WingetDir"
    Write-Host "3. Submit to winget-pkgs repository via PR"
}
catch {
    Write-Error "Failed to update WinGet manifests: $($_.Exception.Message)"
    exit 1
}