[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
AppId={{12345678-1234-1234-1234-123456789012}
AppName=WeChatPC Unlock Mutex
AppVersion=1.0.0
AppVerName=WeChatPC Unlock Mutex 1.0.0
AppPublisher=WeixinUnlockMutex Contributors
AppPublisherURL=https://github.com/WeixinUnlockMutex/WeixinUnlockMutex
AppSupportURL=https://github.com/WeixinUnlockMutex/WeixinUnlockMutex/issues
AppUpdatesURL=https://github.com/WeixinUnlockMutex/WeixinUnlockMutex/releases
DefaultDirName={autopf}\WeChatPC Unlock Mutex
DefaultGroupName=WeChatPC Unlock Mutex
AllowNoIcons=yes
LicenseFile=
OutputDir=.
OutputBaseFilename=WeChatPC-Setup
SetupIconFile=
Compression=lzma
SolidCompression=yes
WizardStyle=modern
PrivilegesRequired=admin
ArchitecturesInstallIn64BitMode=x64

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "Release\WeChatPC.exe"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\WeChatPC Unlock Mutex"; Filename: "{app}\WeChatPC.exe"
Name: "{group}\{cm:UninstallProgram,WeChatPC Unlock Mutex}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\WeChatPC Unlock Mutex"; Filename: "{app}\WeChatPC.exe"; Tasks: desktopicon

[Run]
Filename: "{app}\WeChatPC.exe"; Description: "{cm:LaunchProgram,WeChatPC Unlock Mutex}"; Flags: nowait postinstall skipifsilent