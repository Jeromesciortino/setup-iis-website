Function Install-Certificate{
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
        [String] $CertificateSubject,
        [Parameter(Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
        [String] $CertificateDirectory
    )

    process{

        $SafeCertSubject = $CertificateSubject.replace("`*", "``*")

        $certs = (Get-ChildItem cert:\localmachine\my | Where-Object { $_.Subject -like '*' + $SafeCertSubject + '*' })

        if($certs){
            "A Certificate with the subject of $CertificateSubject or similar is already installed on this machine."
        }
        else{
            "Locating $CertSubject in $CertificateDirectory.."

            #Check if certificate exists in the certificates directory
            $CertSearch = Get-ChildItem -Path $CertificateDirectory | Where-Object { $_.Name -like '*' + $SafeCertSubject + '*' }

            #Found certificate
            if($CertSearch.Length -gt 0){
                $CertName = $CertSearch[0].Name

                "Found Certificate in $CertificateDirectory - Installing Certificate"
                
                $InstallResult = $null

                while(!$InstallResult){
                    $CertCreds = Get-Credential -Username "Enter the password below" -Message "Enter the password below"
                
                    if(!$CertCreds){
                        return
                    }
                
                    $InstallResult = Import-PfxCertificate -FilePath "$CertificateDirectory/$CertName" -CertStoreLocation Cert:\LocalMachine\My -Password $CertCreds.Password -Exportable
                }
            }
            else{
                "Certificate $CertificateSubject was not found in $CertificateDirectory"
            }
        }
    }
}

Export-ModuleMember -function Install-Certificate