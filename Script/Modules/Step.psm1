function Step {
    param(
        [Parameter(Mandatory=$true)]
        [string] $StepName,
        [Parameter(Mandatory=$true)]
        [string] $StepDescription,
        [Parameter(Mandatory=$true)]
        [boolean] $Validate,
        [Parameter(Mandatory=$true)]
        [scriptblock]$StepScript
    )
    
    New-Object psobject -property @{
        StepName = $StepName
        StepDescription = $StepDescription
        Validate = $Validate
        StepScript = $StepScript
    }
}

function Invoke-Step {
    param(
        [Parameter(Mandatory=$true, Position=0, ValueFromPipelineByPropertyName=$true)]
        [String] $StepName,
        [Parameter(Mandatory=$true, Position=1, ValueFromPipelineByPropertyName=$true)]
        [String] $StepDescription,
        [Parameter(Mandatory=$true, Position=2, ValueFromPipelineByPropertyName=$true)]
        [boolean] $Validate,
        [Parameter(Mandatory=$true, Position=3, ValueFromPipelineByPropertyName=$true)]
        [scriptblock] $StepScript
    )
    process {
            "Performing $StepName : $StepDescription"
            
            if($Validate){
                $StepScript.Invoke()
            }else{
                $StepScript.Invoke()
            }
    }
}

Export-ModuleMember -function Step
Export-ModuleMember -function Invoke-Step