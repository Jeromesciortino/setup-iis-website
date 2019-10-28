Function New-HostFileEntry{
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
        [String] $HttpsIPAddress,
        [Parameter(Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
        [String] $HostName,
        [Parameter(Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
        [String] $HostFileLocation
    )
    process{
        $HostEntryExists = CheckHostFileEntry $HostFileLocation $HostName

        if (!$HostEntryExists) {
            CreateHostFileEntry $HostFileLocation $HttpsIPAddress $HostName 
        }
        else {
            "Host File Entry not created - Similar host entries found."
        }
    }
}

function GetHostFile($HostFileLocation){
    $File = $HostFileLocation
    $Lines = @()

    (Get-Content -Path $File)  | ForEach-Object {
        $Lines += $_
    }

    return $Lines
}

function CheckHostFileEntry($HostFileLocation, $Entry){
    foreach ($_ in GetHostFile $HostFileLocation){

        if ($_ -Like "*$($Entry)*") {
            return $True
        }
    }

    return $False
}

function CreateHostFileEntry($HostFileLocation, $HttpsIPAddress, $HostName){
    $HostFile = $HostFileLocation
    $RegionFound = $False

    #Loop through Host File entries
    foreach ($Line in Get-Content -Path $HostFile)
    {    
        $FileModified += $Line + "`n"

        if ($RegionFound -eq $False -and $Line -Like "*Generated From Powershell Script*") {
            $FileModified += "    $($HttpsIPAddress)       $($HostName)`n"
            $RegionFound = $True
        }
    }

    if($RegionFound -eq $True){
        Set-Content $HostFile $FileModified
    }
    else{
        Add-Content $HostFile "`n`n###### Generated From Powershell Script ###############################################`n    $($HttpsIPAddress)       $($HostName)"
    }
}

Export-ModuleMember -function New-HostFileEntry