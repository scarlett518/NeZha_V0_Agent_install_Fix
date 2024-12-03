# NeZha_V0_Agent_install_Fix

[EN](Readme.md)|**简体中文**|[繁體中文](Readme.Chinese_Traditional.md)  

## 〢 介绍
一个修改过的V0版本的哪吒面板的Agent安装脚本，皆在修复V0版本的哪吒面板停止维护后无法顺利安装Windows/MacOS端Agent的问题。

本仓库更多的用途还是在于自用。如果你想做出贡献/提议/Bug反馈，欢迎提交issues/Forks/PR!  

> [!IMPORTANT]
> 此仓库的Agent安装脚本仅适用于V0版本的哪吒面板。如果你当前是V1的哪吒面板，并希望自己的Windows/MacOS服务器可以托管于V1版本的哪吒面板，则直接使用V1哪吒面板后台提供的安装指令安装即可。

## 〢 免责声明/叠甲
此仓库的Agent安装脚本并没有添加任何后门，也没有进行任何加密。安装脚本所有代码均可查看。  
此仓库的Agent安装脚本以及Readme.md文件中所示的安装指令中，所下载的所有安装包的获取来源均为哪吒面板官方源仓库/官方镜像源仓库。  
如果你不放心使用此安装脚本，可以自行查看安装脚本代码，或者将代码交由AI进行检查。如果你仍然心存顾虑，则不要使用此安装脚本。  

## 〢 安装脚本更改内容
- 锁定Agent安装的版本号为v0.20.5 (最后支持V0版本哪吒面板的Agent)。  
- 保留了IP归属地判断逻辑，使得中国大陆地区用户可以使用哪吒面板官方Gitee镜像源下载Agent。  
- 修复了哪吒面板Agent仍在运行的情况下使用原脚本可能会出现"Access is denied" (访问被拒绝)的问题。此安装脚本会在安装前判断Agent是否仍在运行，如果运行中则终止当前Agent。  
- 修复了哪吒面板Agent在本地有残留的情况下使用原脚本可能会出现"文件已存在，无法创建"的问题。此安装脚本会在安装前判断Agent是否在本地含有残留文件，如果有残留文件则先删除残留。  
- 加入了更多的提示信息，以方便在发生问题时更容易定位问题所在点。  

> [!NOTE]
> MacOS的Agent安装脚本的更新日志同上。但由于本人手中并没有运行MacOS的设备，故本人暂无办法测试/验证并保证可以完美运行。实际运行情况需要自行测试。如果你想做出贡献/提议/Bug反馈，欢迎提交issues/Forks/PR!    

## 〢 Windows端如何使用？

从哪吒面板后台复制你的Windows Agent安装指令。假设以下为你复制的安装指令：
```
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Ssl3 -bor [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12;set-ExecutionPolicy RemoteSigned;Invoke-WebRequest https://raw.githubusercontent.com/nezhahq/scripts/main/extras/install.ps1 -OutFile C:\install.ps1;powershell.exe C:\install.ps1 1.1.1.1.nip.io:5555 [Key]
```

那么只需要将你原安装指令指向的安装脚本获取网址：
```
https://raw.githubusercontent.com/nezhahq/scripts/main/extras/install.ps1
```

改为本仓库修改过后的安装脚本获取网址：
```
https://raw.githubusercontent.com/DuolaD/NeZha_V0_Agent_install_Fix/main/install.ps1
```

然后重新拼接安装指令：
```
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Ssl3 -bor [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12;set-ExecutionPolicy RemoteSigned;Invoke-WebRequest https://raw.githubusercontent.com/DuolaD/NeZha_V0_Agent_install_Fix/main/install.ps1 -OutFile C:\install.ps1;powershell.exe C:\install.ps1 1.1.1.1.nip.io:5555 [Key]
```

确认拼接无误后，使用拼接后的安装指令复制至使用管理员权限的Windows PowerShell终端即可安装Agent。  
安装过程中如有提示「执行策略变更」的确认提示，输入`[Y]`或`[A]`确认即可。  

## 〢 MacOS端如何使用？

从哪吒面板后台复制你的MacOS Agent安装指令。假设以下为你复制的安装指令：
```
curl -L https://raw.githubusercontent.com/nezhahq/scripts/main/extras/install.command -o nezha.command && chmod +x nezha.command && sudo ./nezha.command install_agent 1.1.1.1.nip.io 5555 [Key]
```

那么只需要将你原安装指令指向的安装脚本获取网址：
```
https://raw.githubusercontent.com/nezhahq/scripts/main/extras/install.command
```

改为本仓库修改过后的安装脚本获取网址：
```
https://raw.githubusercontent.com/DuolaD/NeZha_V0_Agent_install_Fix/main/install.command
```

然后重新拼接安装指令：
```
curl -L https://raw.githubusercontent.com/DuolaD/NeZha_V0_Agent_install_Fix/main/install.command -o nezha.command && chmod +x nezha.command && sudo ./nezha.command install_agent 1.1.1.1.nip.io 5555 [Key]
```

确认拼接无误后，使用拼接后的安装指令复制至终端运行即可安装Agent。  

## 〢 其它实用指令
- 安装V0版本的哪吒面板（版本号为V0哪吒面板的最后一个版本 V0.20.13）（直接复制粘贴至SSH终端即可运行）：

> [!IMPORTANT]
> 如果你已经安装了V1版本的哪吒面板，请先使用V1哪吒面板的安装脚本中的卸载功能卸载面板端，以免产生不必要的Bug。

如果你的服务器在中国大陆以外的地区，则复制以下安装指令并粘贴至SSH终端运行以安装V0版本的哪吒面板：

```
curl -L https://raw.githubusercontent.com/nezhahq/scripts/refs/heads/v0/install.sh -o nezha.sh && chmod +x nezha.sh && sudo ./nezha.sh
```

如果你的服务器在中国大陆地区，则复制以下安装指令并粘贴至SSH终端运行以安装V0版本的哪吒面板：

```
curl -L https://gitee.com/naibahq/scripts/raw/v0/install.sh -o nezha.sh && chmod +x nezha.sh && sudo CN=true ./nezha.sh
```

如果你要在这之后打开脚本菜单，则复制以下指令并粘贴至SSH终端运行：

```
./nezha.sh
```

> [!IMPORTANT]
> 安装脚本后请不要输入13更新脚本，否则脚本将会更新至最新的V1哪吒面板的安装脚本。如果你不小心更新至V1哪吒面板的安装脚本，则可以使用上述安装指令重新安装V0版本哪吒面板的安装脚本。

- 在Linux服务器安装适用于V0版本哪吒面板的Agent：

从哪吒面板后台复制你的Linux Agent安装指令。假设以下为你复制的安装指令：
```
curl -L https://raw.githubusercontent.com/nezhahq/scripts/main/install.sh -o nezha.sh && chmod +x nezha.sh && ./nezha.sh install_agent 1.1.1.1.nip.io 5555 [key]
```

那么只需要将你原安装指令指向的安装脚本获取网址：
```
https://raw.githubusercontent.com/nezhahq/scripts/main/install.sh
```

改为哪吒官方仓库v0分支的安装脚本获取网址：
```
https://raw.githubusercontent.com/nezhahq/scripts/v0/install.sh
```

然后重新拼接安装指令：
curl -L https://raw.githubusercontent.com/nezhahq/scripts/v0/install.sh -o nezha.sh && chmod +x nezha.sh && ./nezha.sh install_agent 1.1.1.1.nip.io 5555 [key]
```

确认拼接无误后，使用拼接后的安装指令复制至SSH终端运行即可。

> [!IMPORTANT]
> 安装脚本后请不要输入13更新脚本，否则脚本将会更新至最新的V1哪吒面板的安装脚本。如果你不小心更新至V1哪吒面板的安装脚本，则可以使用上述安装指令重新安装V0版本哪吒面板的安装脚本。