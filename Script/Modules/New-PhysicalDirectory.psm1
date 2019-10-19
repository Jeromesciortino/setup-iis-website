Function New-PhysicalDirectory{
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
        [String] $Path
    )
    process{
        $SplitResult = $Path.split("/")
        
        $DirName = ""

        if($SplitResult[$SplitResult.Length - 1] -ne ""){
            $DirName = $SplitResult[$SplitResult.Length - 1]
        }
        else{
            $DirName = $SplitResult[$SplitResult.Length - 2]
        }

        $ParentPath = ""

        for ($i = 0; $i -le $SplitResult.Length - 2 ; $i++) {
            $ParentPath += $SplitResult[$i] + "/"
        }

        New-Item -Path $ParentPath -Name $DirName -ItemType "directory" -Force
    }
}

Export-ModuleMember -function New-PhysicalDirectory