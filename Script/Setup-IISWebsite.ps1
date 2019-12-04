$ScriptInvocationPath = Split-Path $MyInvocation.MyCommand.Path

Import-Module -Name "$ScriptInvocationPath/Modules/Read-XMLFile.psm1"
Import-Module -Name "$ScriptInvocationPath/Modules/Enable-WindowsFeaturesIIS.psm1"
Import-Module -Name "$ScriptInvocationPath/Modules/Step.psm1"
Import-Module -Name "$ScriptInvocationPath/Modules/Define-Constants.psm1"
Import-Module -Name "$ScriptInvocationPath/Modules/New-PhysicalDirectory.psm1"
Import-Module -Name "$ScriptInvocationPath/Modules/New-IISWebsite.psm1"
Import-Module -Name "$ScriptInvocationPath/Modules/Install-Certificate.psm1"
Import-Module -Name "$ScriptInvocationPath/Modules/New-HTTPSBinding.psm1"
Import-Module -Name "$ScriptInvocationPath/Modules/New-HostFileEntry.psm1"
Import-Module -Name "$ScriptInvocationPath/Modules/New-AppPool.psm1"
Import-Module -Name "$ScriptInvocationPath/Modules/Register-AppPoolWithWebsite.psm1"

#Read Config File
$WebsiteConfig = (Read-XMLFile (Get-Variable -Name ConfigFilePath -Scope Global).Value).config
#$WebsiteConfig.site_name
#$WebsiteConfig.host_name
$WebsiteConfig.use_app_poool_identity 
#$WebsiteConfig.app_pool_identity_username
#$WebsiteConfig.app_pool_identity_pass
#$WebsiteConfig.cert_subject
#endregion

#region Define Steps
Set-ExecutionPolicy Bypass -Scope Process

$list = New-Object Collections.Generic.List[PSObject]
#$list.Add((Step -StepName 'Turn on Windows features - IISCommonHTTP' -StepDescription "This step turns on the windows feature - IIS Common HTTP" -Validate $true -StepScript { Enable-IISCommonHTTP }))

$list.Add((Step -StepName 'Create Physical Directory' -StepDescription "This step creates a physical folder for the website." -Validate $true -StepScript { (New-PhysicalDirectory -Path $WebsiteConfig.physical_file_path) }))
$list.Add((Step -StepName 'Create IIS Website & Http Binding' -StepDescription "This step creates an IIS website and its corresponding HTTP Binding." -Validate $true -StepScript { (New-IISWebsite -SiteName $WebsiteConfig.site_name -PhysicalPath $WebsiteConfig.physical_file_path -HostName $WebsiteConfig.host_name) }))
$list.Add((Step -StepName 'Install the required certificate for HTTPS Binding' -StepDescription "This step tries to locate the specified certificate and installs it." -Validate $true -StepScript { (Install-Certificate -CertificateSubject $WebsiteConfig.cert_subject -CertificateDirectory (Get-Variable -Name CertificateDirectory -Scope Global).Value) }))
$list.Add((Step -StepName 'Create an entry in the host file' -StepDescription "This step creates an entry in the host file located in C:\Windows\System32\Drivers\etc\hosts." -Validate $true -StepScript { New-HostFileEntry -HttpsIPAddress (Get-Variable -Name HttpsIPAddress -Scope Global).Value -HostName $WebsiteConfig.host_name -HostFileLocation (Get-Variable -Name HostFileLocation -Scope Global).Value }))
$list.Add((Step -StepName 'Create IIS Website & Http Binding' -StepDescription "This step creates an IIS website and its corresponding HTTP Binding." -Validate $true -StepScript { (New-IISWebsite -SiteName $WebsiteConfig.site_name -PhysicalPath $WebsiteConfig.physical_file_path -HostName $WebsiteConfig.host_name) }))
$list.Add((Step -StepName 'Create an HTTPS Binding for the website and associate SSL Certificate' -StepDescription "This step creates an HTTPS binding for the website and associates the SSL Certififcate with it." -Validate $true -StepScript { New-HTTPSBinding -SiteName $WebsiteConfig.site_name -HttpsIPAddress (Get-Variable -Name HttpsIPAddress -Scope Global).Value -HttpsPort (Get-Variable -Name HttpsPort -Scope Global).Value -HostName $WebsiteConfig.host_name -CertSubject $WebsiteConfig.cert_subject }))
$list.Add((Step -StepName 'Create an Application Pool for the website' -StepDescription "This step creates an Application Pool for the website." -Validate $true -StepScript { New-AppPool -AppPoolName $WebsiteConfig.site_name -UseAppPoolIdentity $WebsiteConfig.use_app_poool_identity -AppPoolIdentityUser $WebsiteConfig.app_pool_identity_username -AppPoolIdentityPass $WebsiteConfig.app_pool_identity_pass }))
$list.Add((Step -StepName 'Associate an Application Pool with a website' -StepDescription "This step associates an Application Pool with a website." -Validate $true -StepScript { Register-AppPoolWithWebsite -SiteName $WebsiteConfig.site_name -AppPoolName $WebsiteConfig.site_name }))
#endregion

#region Run Steps

foreach($s in $list){
    $s | Invoke-Step
}   

#endregion