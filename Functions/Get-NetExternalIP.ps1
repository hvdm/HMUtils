<#
    .SYNOPSIS
    This Cmdlet is used to check the external IP address

    .DESCRIPTION
    Function to check what thje external IP address is

    .EXAMPLE
    Get-NetExternalIP

    .NOTES
    Author: H. van der Mark
    Email : Herby@vandermark.org

    .LINK
    https://github.com/hvdm/HMUtils/
#>

function Get-NetExternalIP
{
    try
    {
        # Attempt to get the external IP
        (Invoke-WebRequest -UseBasicParsing -Uri "http://ifconfig.me/ip").Content.Trim()
    }
    catch
    {
        # Catch if no internet access
        "No Internet"
    }
}
