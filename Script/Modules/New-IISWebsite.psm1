Function New-IISWebsite{
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
        [String] $SiteName,
        [Parameter(Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
        [String] $PhysicalPath,
        [Parameter(Mandatory=$true, Position=2, ValueFromPipelineByPropertyName=$true)]
        [String] $HostName
    )

    process{
        New-WebSite -Name $SiteName -PhysicalPath $PhysicalPath -Force
        Set-WebBinding -Name $SiteName -PropertyName "HostHeader" -Value $HostName
    }
}

Export-ModuleMember -function New-IISWebsite