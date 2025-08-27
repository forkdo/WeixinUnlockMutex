# WeChatPC Unlock Mutex - CI/CD Documentation

This project includes automated building with GitHub Actions for streamlined development and deployment.

## 🚀 GitHub Actions CI/CD

### Automated MSI Building and Release

The project now includes a GitHub Actions workflow that automatically:

1. **Builds the C++ application** using MSBuild
2. **Creates MSI installers** using WiX Toolset
3. **Uploads releases** to GitHub automatically

### Workflow Trigger

The CI/CD pipeline is triggered by:
- **Git tags** starting with `v` (e.g., `v1.0.0`, `v2.1.3`)
- **Manual workflow dispatch** from GitHub Actions tab

### Creating a Release

To create a new release:

```bash
# Create and push a new tag
git tag v1.0.0
git push origin v1.0.0
```

The workflow will automatically:
- Build the Release|x86 configuration
- Generate an MSI installer
- Update Winget package manifests
- Create a GitHub release with MSI, EXE, and Winget manifest files
- Include auto-generated release notes

### Files Created by CI

- `.github/workflows/build-release.yml` - Main CI/CD workflow
- `WeChatPC.wxs` - WiX Toolset configuration for MSI generation
- `winget/` - Winget package manifest files
- `Update-WingetManifest.ps1` - Script to update Winget manifests

## 📦 Winget Package Support

### Overview

The project supports Windows Package Manager (Winget) for easy installation and updates. The CI/CD pipeline automatically generates and updates Winget manifest files.

### Installation via Winget

```cmd
# Install the package
winget install forkdo.WeixinUnlockMutex

# Upgrade to latest version
winget upgrade forkdo.WeixinUnlockMutex
```

### Manifest Files

The following Winget manifest files are automatically maintained:
- `winget/forkdo.WeixinUnlockMutex.yaml` - Version manifest
- `winget/forkdo.WeixinUnlockMutex.installer.yaml` - Installer details
- `winget/forkdo.WeixinUnlockMutex.locale.en-US.yaml` - English metadata
- `winget/forkdo.WeixinUnlockMutex.locale.zh-CN.yaml` - Chinese metadata

### Submitting to Official Repository

To make the package available in the official Winget repository:
1. Copy manifest files to [microsoft/winget-pkgs](https://github.com/microsoft/winget-pkgs)
2. Submit a Pull Request
3. Wait for automated validation and approval

For detailed information, see [WINGET.md](WINGET.md).

## 🔧 Development

### Project Structure

```
WeixinUnlockMutex/
├── .github/
│   └── workflows/
│       └── build-release.yml      # CI/CD workflow
├── WeChatPC/                      # C++ source code
│   ├── main.cpp
│   ├── WeChatPC.cpp
│   ├── WeChatPC.h
│   └── Common.h
├── WeChatPC.wxs                   # WiX MSI configuration
├── WeChatPC.iss                   # Inno Setup configuration
├── WeChatPC.sln                   # Visual Studio solution
└── README.md                      # Project documentation
```

### Building Locally

#### C++ Version
```bash
# Using Visual Studio
msbuild WeChatPC.sln /p:Configuration=Release /p:Platform=x86

# Using Developer Command Prompt
devenv WeChatPC.sln /build "Release|x86"
```

#### MSI Generation
```bash
# Install WiX Toolset v3.11 first
candle.exe WeChatPC.wxs -out obj\
light.exe obj\WeChatPC.wixobj -out WeChatPC.msi -ext WixUIExtension
```

### Contributing

When contributing to this project:

1. **Test the C++ implementation** thoroughly
2. **Update documentation** for any new features or changes
3. **Ensure CI/CD compatibility** - test workflow changes in forks
4. **Follow security best practices** - validate all inputs and operations
5. **Maintain x86 (32-bit) compatibility** as required for WeChat interaction

### Version History

- **v1.0.0** - Original C++ implementation
- **v1.1.0** - Added GitHub Actions CI/CD automation

## 📄 License

This project is provided for educational and research purposes. See `License.rtf` for full terms.

## ⚠️ Disclaimer

This tool is for educational purposes only. Users are responsible for complying with all applicable laws and WeChat's terms of service. Use at your own risk.