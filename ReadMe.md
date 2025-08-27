# WeChatPC 微信多开工具

`WeChatPC` 是一款专为微信PC版设计的多开工具，通过系统底层句柄操作技术，绕过微信的单实例限制，实现多个微信账号同时登录。

## ✨ 主要特征

- 🚀 **无限多开**：支持同时运行任意数量的微信实例
- 🎯 **一键启动**：运行 `WeChatPC.exe` 即可快速解锁
- 🔧 **技术先进**：使用Windows底层API进行句柄操作
- 🛡️ **安全可靠**：无需第三方工具，纯净绿色
- 📦 **便携免安装**：单文件执行，无需安装过程

## 📋 使用说明

### 方法一：使用 Winget 安装（推荐）
```cmd
# 使用 Windows Package Manager 安装
winget install forkdo.WeixinUnlockMutex
```

### 方法二：手动下载安装
1. 从 [Releases](https://github.com/forkdo/WeixinUnlockMutex/releases) 页面下载最新的 `WeChatPC.exe` 或 MSI 安装包
2. 运行 `WeChatPC.exe` 或安装 MSI 包
3. 启动多个微信实例
## 📱 微信版本支持

- ✅ **微信 4.0.6.21**：完全支持
- 🔄 **其他版本**：需要自行测试，可能需要调整互斥锁名称
- 📝 **重要变更**：微信4.0版本将互斥锁名称从 `WeChat` 变更为 `Weixin`

### 🔍 手动验证方法
使用火绒安全工具可以手动查看和关闭Mutex句柄来实现多开：


![Mutex句柄示例](./images/9e665f02-856c-4f7b-b829-d9b6ca4dcdf9.png)

## 🚀 新特性与优化

### 🎆 自动化构建 (GitHub Actions CI/CD)
- ✅ 自动编译可执行文件
- ✅ 自动发布到 GitHub Releases
- ✅ 支持版本标签触发构建
- ✅ 跨平台兼容性测试

> 📄 **详细文档**：[CI-CD-README.md](CI-CD-README.md)

## 📦 下载与安装

### 推荐方式：使用 Winget
```cmd
winget install forkdo.WeixinUnlockMutex
```

### 替代方式：从 GitHub Releases 下载
📥 [**下载最新版本**](https://github.com/forkdo/WeixinUnlockMutex/releases/latest)

### 历史版本下载
📁 [查看所有版本](https://github.com/forkdo/WeixinUnlockMutex/releases)

## 🔨 源代码编译

### 环境要求
- Visual Studio 2010 或更高版本
- Windows SDK
- Git

### 编译步骤
```bash
# 1. 克隆仓库
git clone https://github.com/forkdo/WeixinUnlockMutex.git
cd WeixinUnlockMutex

# 2. 使用 Visual Studio 打开 WeChatPC.sln
# 3. 选择 x86 平台进行编译
```

> ⚠️ **重要提醒**：必须选择 **x86 (32位)** 平台进行编译！

## 🔍 技术原理

### 核心概念
微信使用 **互斥体(Mutex)** 作为限制机制，正常情况下仅允许开启一个客户端。通过关闭特定的Mutex句柄，即可绕过此限制。

### 可视化演示
使用火绒安全工具查看目标进程句柄列表，可发现红色标记框中的2个句柄。关闭这些句柄后，即可继续开启微信。


![Mutex句柄示意图](./images/Snipaste_2020-04-26_10-45-12.jpg)

### 🎮 扩展应用
类似原理可用于其他使用Mutex限制多开的网络游戏：
- 🌉 天龙八部 (TLBB)
- ⚔️ 笑傲江湖OL
- 🔄 其他类似机制的游戏

## 🔧 技术实现流程

### 核心步骤
1. **进程枚举** 🔍
   - 使用 `ZwQuerySystemInformation` 函数枚举系统进程信息
   - 查找 `WeChat.exe` 进程，获取其进程 ID

2. **句柄枚举** 🔎
   - 使用 `ZwQuerySystemInformation` 枚举全局句柄列表
   - 通过比较句柄拥有者进程 ID，获取 `WeChat.exe` 目标句柄

3. **句柄操作** 🔧
   - 使用 `DuplicateHandle` 跨进程复制句柄
   - 第一次复制：仅查询比较「类型」和「名称」
   - 第二次复制：关闭找到的目标句柄

![Mutex操作流程](./images/Snipaste_2020-04-26_10-45-44.jpg)

### 📚 技术参考
- [Windows内部未记录函数参考](https://www.geoffchappell.com/index.htm)
- [ZwQuerySystemInformation 文档](https://docs.microsoft.com/en-us/windows/win32/api/winternl/nf-winternl-ntquerysysteminformation)
- [DuplicateHandle API 参考](https://docs.microsoft.com/en-us/windows/win32/api/handleapi/nf-handleapi-duplicatehandle)

## ⚠️ 法律声明和使用须知

### 📋 重要声明
- 🎓 **仅供教育和技术研究使用**
- 🚫 **禁止用于任何商业用途**
- 🚨 **禁止用于非法用途**
- ⚖️ **使用者承担所有法律风险和后果**

### 🛡️ 风险提示
- 可能违反微信的用户协议
- 存在被微信安全机制检测或封禁的风险
- 可能在新版本操作系统上失效（由于API变更或安全限制）

## 🙏 致谢

特别感谢 [cheungxiongwei](https://github.com/cheungxiongwei/WeChatPC) 的开源贡献，为本项目提供了基础和灵感。

## 💬 支持与反馈

- 🐛 **问题反馈**：[GitHub Issues](https://github.com/forkdo/WeixinUnlockMutex/issues)
- 💬 **讨论交流**：[GitHub Discussions](https://github.com/forkdo/WeixinUnlockMutex/discussions)
- 🔄 **贡献代码**：欢迎提交 Pull Request

---

<div align="center">
  <sub>为技术研究和教育目的而开发 • Built for Educational and Research Purposes</sub>
</div>
