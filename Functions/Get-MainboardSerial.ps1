<#
    .SYNOPSIS
    This Cmdlet is used to check the serialnumber of a machine

    .DESCRIPTION
    Function to check what the serialnumber is

    .PARAMETER ComputerName
    Computername to connect to (Default = local machine)

    .EXAMPLE
    Get-MainboardSerial -ComputerName <ComputerName>

    .NOTES
    Author: H. van der Mark
    Email : Herby@vandermark.org

    .LINK
    https://github.com/hvdm/HMUtils/
#>

function Get-MainboardSerial
{
    param 
    (
        [string]$ComputerName = $env:COMPUTERNAME
    )
    
    try
    {
        # Query the motherboard information via CIM
        # $motherboard = Get-CimInstance -ClassName Win32_BaseBoard -ComputerName $ComputerName

        # Query the motherboard information via WMI
        $motherboard = Get-WmiObject -ComputerName $ComputerName -Class Win32_BaseBoard


        if ($motherboard)
        {
            return $motherboard.SerialNumber
        }
        else
        {
            return "No motherboard information found for $ComputerName."
        }
    }
    catch
    {
        # Handle any errors that occur during the CIM query
        Write-Error "Failed to retrieve mainboard information from $ComputerName. Error: $_"
    }
    
}
