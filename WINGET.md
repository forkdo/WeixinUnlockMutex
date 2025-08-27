# WeChatPC Unlock Mutex - Winget Package

This document provides information about the Winget package for WeChatPC Unlock Mutex.

## 📦 Installation

### Using Windows Package Manager (Winget)

```cmd
# Install the latest version
winget install forkdo.WeixinUnlockMutex

# Install a specific version
winget install forkdo.WeixinUnlockMutex --version 1.0.0

# Upgrade to the latest version
winget upgrade forkdo.WeixinUnlockMutex

# Uninstall
winget uninstall forkdo.WeixinUnlockMutex
```

### Package Information

- **Package ID**: `forkdo.WeixinUnlockMutex`
- **Publisher**: forkdo
- **Architecture**: x86 (32-bit)
- **Installer Type**: MSI
- **Installation Scope**: Machine-wide

## 🔍 Package Details

### What's Included

The Winget package installs:
- WeChatPC.exe - Main executable
- Start menu shortcuts
- Uninstaller registration
- Desktop shortcut (optional)

### System Requirements

- Windows 10 or later
- x86 (32-bit) or x64 (64-bit) Windows
- Administrator privileges (for MSI installation)

## 🛠️ For Maintainers

### Updating the Package

1. **Automatic Updates**: The GitHub Actions workflow automatically updates manifest files when a new release is tagged
2. **Manual Updates**: Use the `Update-WingetManifest.ps1` script

```powershell
# Update manifests for a specific version
.\Update-WingetManifest.ps1 -Version "1.0.0"

# Update using local MSI file
.\Update-WingetManifest.ps1 -Version "1.0.0" -MSIPath ".\WeChatPC-v1.0.0.msi"
```

### Submitting to Official Repository

To make the package available in the official winget repository:

1. Fork the [microsoft/winget-pkgs](https://github.com/microsoft/winget-pkgs) repository
2. Copy the manifest files to the appropriate directory:
   ```
   manifests/f/forkdo/WeixinUnlockMutex/[version]/
   ```
3. Submit a Pull Request with the new manifests
4. Wait for automated validation and approval

### Manifest Files

The package includes these manifest files:
- `forkdo.WeixinUnlockMutex.yaml` - Main version manifest
- `forkdo.WeixinUnlockMutex.installer.yaml` - Installer details
- `forkdo.WeixinUnlockMutex.locale.en-US.yaml` - English metadata
- `forkdo.WeixinUnlockMutex.locale.zh-CN.yaml` - Chinese metadata

## 🚀 CI/CD Integration

The project's GitHub Actions workflow automatically:
1. Builds the MSI installer
2. Calculates SHA256 hash
3. Updates Winget manifest files
4. Includes manifests in release artifacts

## 📝 Testing

Before submitting to the official repository, test the package locally:

```cmd
# Test installation from local manifests
winget install --manifest winget\

# Verify installation
winget list forkdo.WeixinUnlockMutex

# Test uninstallation
winget uninstall forkdo.WeixinUnlockMutex
```

## 🐛 Troubleshooting

### Common Issues

1. **Installation Failed**: Ensure you have administrator privileges
2. **Package Not Found**: Check if the package is submitted to the official repository
3. **Hash Mismatch**: Verify the SHA256 hash in the installer manifest

### Getting Help

- [Winget Documentation](https://docs.microsoft.com/en-us/windows/package-manager/)
- [Project Issues](https://github.com/forkdo/WeixinUnlockMutex/issues)
- [Winget Community](https://github.com/microsoft/winget-cli)

## 📄 License

This package follows the same license as the main project (MIT License).

---

For more information about the main project, see the [main README](README.md).