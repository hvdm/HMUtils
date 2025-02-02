<#
    .SYNOPSIS
    This Cmdlet is used to check the uptime of a machine

    .DESCRIPTION
    Function to check how long a machine is up

    .PARAMETER ComputerName
    Computername to connect to (Default = localhost)

    .EXAMPLE
    Get-UpTime -ComputerName <ComputerName>

    .NOTES
    Author: H. van der Mark
    Email : Herby@vandermark.org

    .LINK
    https://github.com/hvdm/HMUtils/
#>


function Get-UpTime
{
    [CmdletBinding()]
    param 
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$ComputerName = $env:COMPUTERNAME
    )

    try
    {
        # Test if WinRM is available on the remote or local computer
        if (Test-WSMan -ComputerName $ComputerName -ErrorAction SilentlyContinue)
        {
            # Get the LastBootUpTime using CIM (WSMan)
            return (Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $ComputerName).LastBootUpTime
        }
        else
        {
            # Return an error if WSMan is unavailable
            Write-Error "Unable to contact the computer (WinRM is not enabled or reachable): $ComputerName"
        }
    }
    catch
    {
        Write-Error "An error occurred: $_"
    }
}