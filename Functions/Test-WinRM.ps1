<#
    .SYNOPSIS
    This Cmdlet is used to check if WinRM is allowing a remote connection

    .DESCRIPTION
    Function to check if remote control is possible (WinRM enabled)

    .PARAMETER ComputerName
    Computername to connect to

    .EXAMPLE
    Test-WinRM -ComputerName <ComputerName>

    .NOTES
    Author: H. van der Mark
    Email : Herby@vandermark.org

    .LINK
    https://github.com/hvdm/HMUtils/
#>
Function Test-WinRM
{
    [CmdletBinding()]
    param 
    (
        [Parameter(Mandatory = $True)]
        [String]$ComputerName
    )

    try 
    {
        # Test WinRM connection
        $WSManResponse = Test-WSMan -ComputerName $ComputerName -ErrorAction Stop
        if ($null -ne $WSManResponse) 
        {
            return $True
        }
    } 

    catch 
    {
        return $False
    }
}
