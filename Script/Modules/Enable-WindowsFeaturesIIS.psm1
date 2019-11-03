function Enable-IISWebServer(){
    Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServerRole
    Enable-WindowsOptionalFeature -Online -FeatureName IIS-WebServer
}
function Enable-IISCommonHTTP(){
    Enable-WindowsOptionalFeature -Online -FeatureName IIS-StaticContent
    Enable-WindowsOptionalFeature -Online -FeatureName IIS-HttpErrors
    Enable-WindowsOptionalFeature -Online -FeatureName IIS-DefaultDocument
}

function Enable-IISAppDevelopment(){
    Add-WindowsFeature Web-Asp-Net
    Add-WindowsFeature Web-Net-Ext
    Add-WindowsFeature Web-ISAPI-Ext
    Add-WindowsFeature Web-ISAPI-Filter
}

function Enable-IISHealthAndDiagnostics(){
    Add-WindowsFeature Web-Http-Logging
    Add-WindowsFeature Web-Request-Monitor
}

function Enable-IISPerformance(){
    Add-WindowsFeature Web-Stat-Compression
    Add-WindowsFeature Web-Dyn-Compression
}

function Enable-IISManagementTools(){
    Add-WindowsFeature Web-Mgmt-Tools
    Add-WindowsFeature Web-Mgmt-Console
}

Export-ModuleMember -function Enable-IISCommonHTTP
Export-ModuleMember -function Enable-IISAppDevelopment
Export-ModuleMember -function Enable-IISHealthAndDiagnostics
Export-ModuleMember -function Enable-IISPerformance
Export-ModuleMember -function Enable-IISManagementTools