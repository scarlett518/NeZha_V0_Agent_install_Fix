# NeZha_V0_Agent_install_Fix

**EN**|[简体中文](Readme.Chinese_Simplified.md)|[繁體中文](Readme.Chinese_Traditional.md)  

## 〢 Introduction

This is a modified V0 version of the Nezha panel Agent installation script, aimed at fixing the issue where Windows/MacOS Agent installation fails after the discontinuation of maintenance for the V0 Nezha panel.

This repository is primarily for personal use. If you'd like to contribute, make suggestions, or report bugs, feel free to submit issues, forks, or pull requests!

> [!IMPORTANT]
> The Agent installation script in this repository is only suitable for the V0 version of the Nezha panel. If you are using the V1 version and want your Windows/MacOS servers to work with it, use the installation instructions provided directly in the V1 Nezha panel backend.

## 〢 Disclaimer

This repository’s Agent installation script does not contain any backdoors or encryption. All code is open for inspection.  
The installation packages downloaded through the installation commands in this repository are sourced exclusively from the official Nezha panel repository or its official mirrors.  
If you have concerns about using this script, you can review the code yourself or have it verified by AI. If you still have doubts, do not use the script.

## 〢 Changes in the Installation Script

- The Agent installation version is locked to v0.20.5 (the last version supporting the V0 Nezha panel).  
- Retains IP geolocation logic to allow users in mainland China to download the Agent from the official Gitee mirror.  
- Fixes the issue where running the original script while the Agent is already running could result in "Access is denied." This script checks if the Agent is running before installation and stops it if necessary.  
- Resolves issues where leftover local Agent files could cause "File exists and cannot be created" errors. The script checks for residual files and removes them before installation.  
- Includes more detailed prompts to facilitate troubleshooting.  

> [!NOTE]
> Updates for the MacOS Agent installation script follow the same changelog. However, as I do not have access to a MacOS device, I cannot test or guarantee perfect execution. Please test and verify it yourself. Contributions, suggestions, and bug reports are welcome via issues, forks, or PRs!  

## 〢 Instructions for Windows

Copy the Windows Agent installation command from the Nezha panel backend. Assuming the following is the copied command:
```
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Ssl3 -bor [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12;set-ExecutionPolicy RemoteSigned;Invoke-WebRequest https://raw.githubusercontent.com/nezhahq/scripts/main/extras/install.ps1 -OutFile C:\install.ps1;powershell.exe C:\install.ps1 1.1.1.1.nip.io:5555 [Key]
```

Replace the original script URL:
```
https://raw.githubusercontent.com/nezhahq/scripts/main/extras/install.ps1
```

With the modified script URL from this repository:
```
https://raw.githubusercontent.com/DuolaD/NeZha_V0_Agent_install_Fix/main/install.ps1
```

Then, reconstruct the command:
```
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Ssl3 -bor [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12;set-ExecutionPolicy RemoteSigned;Invoke-WebRequest https://raw.githubusercontent.com/DuolaD/NeZha_V0_Agent_install_Fix/main/install.ps1 -OutFile C:\install.ps1;powershell.exe C:\install.ps1 1.1.1.1.nip.io:5555 [Key]
```

Copy the reconstructed command into a Windows PowerShell terminal with administrator privileges to install the Agent.  
If prompted for execution policy change confirmation, input `[Y]` or `[A]` to proceed.  

## 〢 Instructions for MacOS

Copy the MacOS Agent installation command from the Nezha panel backend. Assuming the following is the copied command:
```
curl -L https://raw.githubusercontent.com/nezhahq/scripts/main/extras/install.command -o nezha.command && chmod +x nezha.command && sudo ./nezha.command install_agent 1.1.1.1.nip.io 5555 [Key]
```

Replace the original script URL:
```
https://raw.githubusercontent.com/nezhahq/scripts/main/extras/install.command
```

With the modified script URL from this repository:
```
https://raw.githubusercontent.com/DuolaD/NeZha_V0_Agent_install_Fix/main/install.command
```

Then, reconstruct the command:
```
curl -L https://raw.githubusercontent.com/DuolaD/NeZha_V0_Agent_install_Fix/main/install.command -o nezha.command && chmod +x nezha.command && sudo ./nezha.command install_agent 1.1.1.1.nip.io 5555 [Key]
```

Copy the reconstructed command into the terminal and run it to install the Agent.  

## 〢 Additional Useful Commands

- Install the V0 version of the Nezha panel (version v0.20.13). Copy and paste the following commands directly into the SSH terminal:

> [!IMPORTANT]
> If you have already installed the V1 Nezha panel, first use the uninstall function in its installation script to remove it, to avoid bugs.

For servers located outside mainland China:
```
curl -L https://raw.githubusercontent.com/nezhahq/scripts/refs/heads/main/install.sh -o nezha.sh && chmod +x nezha.sh && sudo ./nezha.sh
```

For servers located in mainland China:
```
curl -L https://gitee.com/naibahq/scripts/raw/v0/install.sh -o nezha.sh && chmod +x nezha.sh && sudo CN=true ./nezha.sh
```

To open the script menu afterward:
```
./nezha.sh
```

> [!IMPORTANT]
> After running the script, do not select option 13 to update the script, as it will update to the latest V1 installation script. If this happens, you can reinstall the V0 script using the commands above.  
