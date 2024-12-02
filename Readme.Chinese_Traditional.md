# NeZha_V0_Agent_install_Fix

[EN](Readme.md)|[简体中文](Readme.Chinese_Simplified.md)|**繁體中文**  

## 〢 介紹
一個修改過的V0版本的哪吒面板的Agent安裝腳本，皆在修復V0版本的哪吒面板停止維護後無法順利安裝Windows/MacOS端Agent的問題。

本倉庫更多的用途還是在於自用。如果你想做出貢獻/提議/Bug反饋，歡迎提交issues/Forks/PR!  

> [!IMPORTANT]
> 此倉庫的Agent安裝腳本僅適用於V0版本的哪吒面板。如果你當前是V1的哪吒面板，並希望自己的Windows/MacOS服務器可以託管於V1版本的哪吒面板，則直接使用V1哪吒面板後臺提供的安裝指令安裝即可。

## 〢 免責聲明/疊甲
此倉庫的Agent安裝腳本並沒有添加任何後門，也沒有進行任何加密。安裝腳本所有代碼均可查看。  
此倉庫的Agent安裝腳本以及Readme.md文件中所示的安裝指令中，所下載的所有安裝包的獲取來源均爲哪吒面板官方源倉庫/官方鏡像源倉庫。  
如果你不放心使用此安裝腳本，可以自行查看安裝腳本代碼，或者將代碼交由AI進行檢查。如果你仍然心存顧慮，則不要使用此安裝腳本。  

## 〢 安裝腳本更改內容
- 鎖定Agent安裝的版本號爲v0.20.5 (最後支持V0版本哪吒面板的Agent)。  
- 保留了IP歸屬地判斷邏輯，使得中國大陸地區用戶可以使用哪吒面板官方Gitee鏡像源下載Agent。  
- 修復了哪吒面板Agent仍在運行的情況下使用原腳本可能會出現"Access is denied" (訪問被拒絕)的問題。此安裝腳本會在安裝前判斷Agent是否仍在運行，如果運行中則終止當前Agent。  
- 修復了哪吒面板Agent在本地有殘留的情況下使用原腳本可能會出現"文件已存在，無法創建"的問題。此安裝腳本會在安裝前判斷Agent是否在本地含有殘留文件，如果有殘留文件則先刪除殘留。  
- 加入了更多的提示信息，以方便在發生問題時更容易定位問題所在點。  

> [!NOTE]
> MacOS的Agent安裝腳本的更新日誌同上。但由於本人手中並沒有運行MacOS的設備，故本人暫無辦法測試/驗證並保證可以完美運行。實際運行情況需要自行測試。如果你想做出貢獻/提議/Bug反饋，歡迎提交issues/Forks/PR!    

## 〢 Windows端如何使用？

從哪吒面板後臺複製你的Windows Agent安裝指令。假設以下爲你複製的安裝指令：
```
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Ssl3 -bor [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12;set-ExecutionPolicy RemoteSigned;Invoke-WebRequest https://raw.githubusercontent.com/nezhahq/scripts/main/extras/install.ps1 -OutFile C:\install.ps1;powershell.exe C:\install.ps1 1.1.1.1.nip.io:5555 [Key]
```

那麼只需要將你原安裝指令指向的安裝腳本獲取網址：
```
https://raw.githubusercontent.com/nezhahq/scripts/main/extras/install.ps1
```

改爲本倉庫修改過後的安裝腳本獲取網址：
```
https://raw.githubusercontent.com/DuolaD/NeZha_V0_Agent_install_Fix/main/install.ps1
```

然後重新拼接安裝指令：
```
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Ssl3 -bor [Net.SecurityProtocolType]::Tls -bor [Net.SecurityProtocolType]::Tls11 -bor [Net.SecurityProtocolType]::Tls12;set-ExecutionPolicy RemoteSigned;Invoke-WebRequest https://raw.githubusercontent.com/DuolaD/NeZha_V0_Agent_install_Fix/main/install.ps1 -OutFile C:\install.ps1;powershell.exe C:\install.ps1 1.1.1.1.nip.io:5555 [Key]
```

確認拼接無誤後，使用拼接後的安裝指令複製至使用管理員權限的Windows PowerShell終端即可安裝Agent。  
安裝過程中如有提示「執行策略變更」的確認提示，輸入`[Y]`或`[A]`確認即可。  

## 〢 MacOS端如何使用？

從哪吒面板後臺複製你的MacOS Agent安裝指令。假設以下爲你複製的安裝指令：
```
curl -L https://raw.githubusercontent.com/nezhahq/scripts/main/extras/install.command -o nezha.command && chmod +x nezha.command && sudo ./nezha.command install_agent 1.1.1.1.nip.io 5555 [Key]
```

那麼只需要將你原安裝指令指向的安裝腳本獲取網址：
```
https://raw.githubusercontent.com/nezhahq/scripts/main/extras/install.command
```

改爲本倉庫修改過後的安裝腳本獲取網址：
```
https://raw.githubusercontent.com/DuolaD/NeZha_V0_Agent_install_Fix/main/install.command
```

然後重新拼接安裝指令：
```
curl -L https://raw.githubusercontent.com/DuolaD/NeZha_V0_Agent_install_Fix/main/install.command -o nezha.command && chmod +x nezha.command && sudo ./nezha.command install_agent 1.1.1.1.nip.io 5555 [Key]
```

確認拼接無誤後，使用拼接後的安裝指令複製至終端運行即可安裝Agent。  

## 〢 其它實用指令
- 安裝V0版本的哪吒面板（版本號爲V0哪吒面板的最後一個版本 V0.20.13）（直接複製粘貼至SSH終端即可運行）：

> [!IMPORTANT]
> 如果你已經安裝了V1版本的哪吒面板，請先使用V1哪吒面板的安裝腳本中的卸載功能卸載面板端，以免產生不必要的Bug。

如果你的服務器在中國大陸以外的地區，則複製以下安裝指令並粘貼至SSH終端運行以安裝V0版本的哪吒面板：

```
curl -L https://raw.githubusercontent.com/nezhahq/scripts/refs/heads/main/install.sh -o nezha.sh && chmod +x nezha.sh && sudo ./nezha.sh
```

如果你的服務器在中國大陸地區，則複製以下安裝指令並粘貼至SSH終端運行以安裝V0版本的哪吒面板：

```
curl -L https://gitee.com/naibahq/scripts/raw/v0/install.sh -o nezha.sh && chmod +x nezha.sh && sudo CN=true ./nezha.sh
```

如果你要在這之後打開腳本菜單，則複製以下指令並粘貼至SSH終端運行：

```
./nezha.sh
```

> [!IMPORTANT]
> 安裝腳本後請不要輸入13更新腳本，否則腳本將會更新至最新的V1哪吒面板的安裝腳本。如果你不小心更新至V1哪吒面板的安裝腳本，則可以使用上述安裝指令重新安裝V0版本哪吒面板的安裝腳本。
