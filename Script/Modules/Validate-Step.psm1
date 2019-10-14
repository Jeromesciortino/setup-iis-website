Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function YesNoDialog($YesNoTitle, $YesNoMessage){
    if ([System.Windows.Forms.MessageBox]::Show("$YesNoMessage","$YesNoTitle",'YesNoCancel','Question') -eq "YES") 
    {
        return $True
    } 

    return $False
}

Export-ModuleMember -Function YesNoDialog