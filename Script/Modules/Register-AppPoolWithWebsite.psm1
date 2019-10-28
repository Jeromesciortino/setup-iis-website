Function Register-AppPoolWithWebsite{
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
        [String] $SiteName,
        [Parameter(Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
        [String] $AppPoolName
    )
    process{
        Set-ItemProperty "IIS:\Sites\$($SiteName)" applicationPool $AppPoolName
    }
}

Export-ModuleMember -function Register-AppPoolWithWebsite