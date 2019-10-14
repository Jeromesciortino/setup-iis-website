function Read-XMLFile{
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
        [string] $XMLFilePath
    )

    process{
        [xml] $XmlDocument = Get-Content $XMLFilePath

        return $XmlDocument
    }
}

Export-ModuleMember -function Read-XMLFile