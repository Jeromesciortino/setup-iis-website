$ScriptInvocationPath = Split-Path $MyInvocation.MyCommand.Path

Import-Module -Name "$ScriptInvocationPath/Modules/Read-XMLFile.psm1"
Import-Module -Name "$ScriptInvocationPath/Modules/Step.psm1"
Import-Module -Name "$ScriptInvocationPath/Modules/Define-Constants.psm1"
Import-Module -Name "$ScriptInvocationPath/Modules/New-PhysicalDirectory.psm1"
Import-Module -Name "$ScriptInvocationPath/Modules/New-IISWebsite.psm1"
Import-Module -Name "$ScriptInvocationPath/Modules/Install-Certificate.psm1"

#Read Config File
$WebsiteConfig = (Read-XMLFile (Get-Variable -Name ConfigFilePath -Scope Global).Value).config
#$WebsiteConfig.site_name
#$WebsiteConfig.host_name
#$WebsiteConfig.use_app_poool_identity 
#$WebsiteConfig.app_pool_identity_username
#$WebsiteConfig.app_pool_identity_pass
#$WebsiteConfig.cert_subject
#endregion

(Install-Certificate -CertificateSubject $WebsiteConfig.cert_subject -CertificateDirectory (Get-Variable -Name CertificateDirectory -Scope Global).Value)

#region Define Steps

$list = New-Object Collections.Generic.List[PSObject]
#$list.Add((Step -StepName 'Create Physical Directory' -StepDescription "This step creates a physical folder for the website." -Validate $true -StepScript { (New-PhysicalDirectory -Path $WebsiteConfig.physical_file_path) }))
#$list.Add((Step -StepName 'Create IIS Website & Http Binding' -StepDescription "This step creates an IIS website and its corresponding HTTP Binding." -Validate $true -StepScript { (New-IISWebsite -SiteName $WebsiteConfig.site_name -PhysicalPath $WebsiteConfig.physical_file_path -HostName $WebsiteConfig.host_name) }))
#$list.Add((Step -StepName 'Install the required certificate for HTTPS Binding' -StepDescription "This step tries to locate the specified certificate and installs it." -Validate $true -StepScript { (Install-Certificate -CertificateSubject $WebsiteConfig.cert_subject -CertificateDirectory (Get-Variable -Name CertificateDirectory -Scope Global).Value) }))

#endregion

#region Run Steps

foreach($s in $list){
    $s | Invoke-Step
}   

#endregion