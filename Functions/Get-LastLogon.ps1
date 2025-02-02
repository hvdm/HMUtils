<#
    .SYNOPSIS
    Get the users last logon

    .DESCRIPTION
    Get the date and time a user has his/her last logon

    .EXAMPLE
    Get-LastLogon <username>

    .NOTES
    Author: H. van der Mark
    Email : Herby@vandermark.org

    .LINK
    https://github.com/hvdm/HMUtils/
#>

function Get-LastLogon()
{
    # get user's last logon from each domain controller

    param($user = $env:USERNAME)

    Get-ADDomainController -Filter * | ForEach-Object {
        $server = $_.hostname
        
        try
        {
            Get-ADObject -IncludeDeletedObjects `
                -Filter { samaccountname -eq $user } `
                -Server $server `
                -Properties SamAccountName, LastLogon, DisplayName | 
            Select-Object 'SamAccountName', 
            @{ n = 'LastLogonDate'; e = { [datetime]::FromFileTime($_.lastlogon) } }, 
            'DisplayName', @{ n = 'dc'; e = { $dc } }, 'BadPwdCount', 'LockedOut', 
            'LastBadPasswordAttempt', 'Deleted'
        }
        catch { Write-Warning $_ }
    }
}