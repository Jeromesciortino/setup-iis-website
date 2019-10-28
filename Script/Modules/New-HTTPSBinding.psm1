Function New-HTTPSBinding{
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
        [String] $SiteName,
        [Parameter(Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
        [String] $HttpsIPAddress,
        [Parameter(Mandatory=$true, Position=2, ValueFromPipelineByPropertyName=$true)]
        [String] $HttpsPort,
        [Parameter(Mandatory=$true, Position=3, ValueFromPipelineByPropertyName=$true)]
        [String] $HostName,
        [Parameter(Mandatory=$true, Position=4, ValueFromPipelineByPropertyName=$true)]
        [String] $CertSubject
    )
    process{

        $SafeCertSubject = $CertSubject.replace("`*", "``*")
        $certs = (Get-ChildItem cert:\localmachine\my | Where-Object { $_.Subject -like '*' + $SafeCertSubject + '*' })

        if(!$certs){
            "A Certificate with the subject of $CertSubject is not installed on this machine. Skipping HTTPS binding creation."
        }
        else{
            "Certificate with subject $CertSubject found in 'my' store"
            
            New-WebBinding -Name $SiteName -IPAddress $HttpsIPAddress -Port $HttpsPort -Protocol "https" -HostHeader $HostName -SslFlags 1
            (Get-WebBinding -Name $SiteName).AddSslCertificate($certs[0].Thumbprint, "my")
        }
    }
}

Export-ModuleMember -function New-HTTPSBinding