<#
    .SYNOPSIS
    This Cmdlet is used to check the time a machine is last booted

    .DESCRIPTION
    Function to check when a machine is booted

    .PARAMETER ComputerName
    Computername to connect to

    .EXAMPLE
    Get-BootTime -ComputerName <ComputerName>

    .NOTES
    Author: H. van der Mark
    Email : Herby@vandermark.org

    .LINK
    https://github.com/hvdm/HMUtils/
#>function Get-BootTime
{
    [CmdletBinding()]
    param 
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$ComputerName = $env:COMPUTERNAME
    )

    (Get-CimInstance -ComputerName $ComputerName -ClassName win32_operatingsystem).LastBootUpTime
}

<#
    .SYNOPSIS
    This Cmdlet is used to check the time a machine is last booted

    .DESCRIPTION
    Function to check when a machine is booted

    .PARAMETER ComputerName
    Computername to connect to

    .EXAMPLE
    Get-BootTime -ComputerName <ComputerName>

    .NOTES
    Author: H. van der Mark
    Email : Herby@vandermark.org

    .LINK
    https://github.com/hvdm/HMUtils/
#>function Get-BootTime
{
    [CmdletBinding()]
    param 
    (
        [Parameter()]
        [ValidateNotNullOrEmpty()]
        [string]$ComputerName = $env:COMPUTERNAME
    )

    (Get-CimInstance -ComputerName $ComputerName -ClassName win32_operatingsystem).LastBootUpTime
}
