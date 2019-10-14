$ScriptInvocationPath = Split-Path $MyInvocation.MyCommand.Path

Import-Module -Name "$ScriptInvocationPath/Modules/Read-XMLFile.psm1"
Import-Module -Name "$ScriptInvocationPath/Modules/Step.psm1"
Import-Module -Name "$ScriptInvocationPath/Modules/Define-Constants.psm1"
Import-Module -Name "$ScriptInvocationPath/Modules/Create-PhysicalDirectory.psm1"

#Read Config File
$WebsiteConfig = (Read-XMLFile (Get-Variable -Name ConfigFilePath -Scope Global).Value).config
$WebsiteConfig.site_name
$WebsiteConfig.host_name
$WebsiteConfig.use_app_poool_identity 
$WebsiteConfig.app_pool_identity_username
$WebsiteConfig.app_pool_identity_pass
$WebsiteConfig.cert_subject 
#endregion

#region Define Steps

$list = New-Object Collections.Generic.List[PSObject]

$s1 = Step -StepName 'Create Physical Directory' -StepDescription "This step creates a physical folder for the website." -Validate $true -StepScript { (Create-PhysicalDirectory -Path $WebsiteConfig.physical_file_path) }

$list.Add($s1)

#endregion

#region Run Steps

foreach($s in $list){
    $s | Invoke-Step
}

#endregion