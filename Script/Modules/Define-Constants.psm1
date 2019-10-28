$ScriptInvocationPath = Split-Path $MyInvocation.MyCommand.Path

Set-Variable -Name ConfigFilePath -Value "$ScriptInvocationPath/../../Config/config.xml" -Option Constant -Scope Global -Force
Set-Variable -Name CertificateDirectory -Value "$ScriptInvocationPath/../../Certificates/" -Option Constant -Scope Global -Force
Set-Variable -Name HttpsIPAddress -Value "127.0.0.1" -Option Constant -Scope Global -Force
Set-Variable -Name HttpsPort -Value "443" -Option Constant -Scope Global -Force
Set-Variable -Name HostFileLocation -Value "C:\Windows\System32\Drivers\etc\hosts" -Option Constant -Scope Global -Force