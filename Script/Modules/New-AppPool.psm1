Function New-AppPool{
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
        [String] $AppPoolName,
        [Parameter(Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
        [String] $UseAppPoolIdentity,
        [Parameter(Mandatory=$true, Position=2, ValueFromPipelineByPropertyName=$true)]
        [String] $AppPoolIdentityUser,
        [Parameter(Mandatory=$true, Position=3, ValueFromPipelineByPropertyName=$true)]
        [String] $AppPoolIdentityPass
    )
    process{
        New-WebAppPool $AppPoolName -Force

        if([System.Convert]::ToBoolean($UseAppPoolIdentity) ){

            $AppPool = Get-Item IIS:\AppPools\$($AppPoolName)
            $AppPool | Stop-WebAppPool

            $AppPool.ProcessModel.identityType = 3
            $AppPool.ProcessModel.Username = $AppPoolIdentityUser
            $AppPool.ProcessModel.Password = $AppPoolIdentityPass

            $AppPool | Set-Item
            $AppPool | Start-WebAppPool
        }
    }
}

Export-ModuleMember -function New-AppPool