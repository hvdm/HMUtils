<#
    .SYNOPSIS
    This Cmdlet is used to list all the local drives

    .DESCRIPTION
    Function to list all the local drives with name, size, freespace etc

    .PARAMETER ComputerName
    Computername to connect to

    .EXAMPLE
    Get-Drives -ComputerName <ComputerName>

    .NOTES
    Author: H. van der Mark
    Email : Herby@vandermark.org

    .LINK
    https://github.com/hvdm/HMUtils/
#>

function Get-Drives
{
    param (
        [string]$ComputerName = $env:COMPUTERNAME, # Defaults to local computer if not provided
        [string]$Drive = "*"                       # Defaults to all drives if not provided
    )

    # If specific drive is not provided, fetch all drives
    $filter = if ($Drive -eq "*") { $null } else { 'DeviceID = "' + $Drive + '"' }

    # Use Get-WmiObject with the optional ComputerName
    Get-WmiObject Win32_LogicalDisk -ComputerName $ComputerName -Filter $filter | 
    Where-Object { $_.DriveType -ne 4 -and $_.DriveType -ne 5 }  # Exclude network and optical drives



    # DeviceID     : T:
    # DriveType    : 4
    # ProviderName : \\nas01\data
    # FreeSpace    : 534197252096
    # Size         : 2113653604352
    # VolumeName   : DATA

    # Get-PSDrive c | Select-Object *
    # Used            : 230661627904
    # Free            : 87632564224
    # CurrentLocation :
    # Name            : C
    # Provider        : Microsoft.PowerShell.Core\FileSystem
    # Root            : C:\
    # Description     : System
    # MaximumSize     :
    # Get-Credential      : System.Management.Automation.PSCredential
    # DisplayRoot     :


    # Get-PSDrive -PSProvider filesystem | Where-Object { $_.used -gt 0 } |
    # select-Object -property Root, @{name = "SizeGB"; expression = { ($_.used + $_.free) / 1GB -as [int] } },
    # @{name = "FreeGB"; expression = { ($_.free / 1GB) -as [int] } },
    # @{name = "PctFree"; expression = { [math]::round(($_.free / ($_.used + $_.free)) * 100, 2)} } | ft

    # Get-PSDrive -PSProvider FileSystem | Where-Object -Property DisplayRoot -NotMatch '\\'

    # $disk = Get-WmiObject Win32_LogicalDisk -ComputerName remotecomputer -Filter "DeviceID='C:'" |
    # Select-Object Size, FreeSpace
}