$ScriptInvocationPath = Split-Path $MyInvocation.MyCommand.Path

Set-Variable -Name ConfigFilePath -Value "$ScriptInvocationPath/../../Config/config.xml" -Option Constant -Scope Global -Force