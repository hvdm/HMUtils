<#
    .SYNOPSIS
    Get the installed product key

    .DESCRIPTION
    Get the Windows product key

    .EXAMPLE
    Get-WindowsProductKey

    .NOTES
    Author: H. van der Mark
    Email : Herby@vandermark.org

    .LINK
    https://github.com/hvdm/HMUtils/
#>

function Get-WindowsProductKey
{
    [cmdletbinding()]
    Param (
        [parameter(ValueFromPipeLine, ValueFromPipelineByPropertyName)]
        [string[]]$Computername = $Env:Computername,
        [Switch] $FullReport
    )

    process
    {

        $GetProductKeyFromComputer = {
            param (
                [Parameter(Mandatory, ValueFromPipeline)]
                [String] $Computer
            )

            $map = "BCDFGHJKMPQRTVWXY2346789"

            if (Test-Connection -ComputerName $Computer -Count 1 -Quiet)
            {
                try
                {
                    Write-Verbose ("{0}: Attempting remote registry access" -f $Computer)
                    $remoteReg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey([Microsoft.Win32.RegistryHive]::LocalMachine, $Computer)
                    $ProductKeyValue = $remoteReg.OpenSubKey("SOFTWARE\Microsoft\Windows NT\CurrentVersion").GetValue('DigitalProductId')[0x34..0x42]
                    $ProductNameValue = $remoteReg.OpenSubKey("SOFTWARE\Microsoft\Windows NT\CurrentVersion").GetValue('ProductName')
                    $isWin8OrNewer = [math]::Floor(($ProductKeyValue[14] / 6)) -band 1
                    $ProductKeyValue[14] = ($ProductKeyValue[14] -band 0xF7) -bor (($isWin8OrNewer -band 2) * 4)
                    $ProductKey = ""
                    Write-Verbose ("{0}: Translating data into product key" -f $Computer)
                    for ($i = 24; $i -ge 0; $i--)
                    {
                        $r = 0
                        for ($j = 14; $j -ge 0; $j--)
                        {
                            $r = ($r * 256) -bxor $ProductKeyValue[$j]
                            $ProductKeyValue[$j] = [math]::Floor([double]($r / 24))
                            $r = $r % 24
                        }
                        $ProductKey = $map[$r] + $ProductKey
                    }
                }
                catch
                {
                    Write-Verbose "Error finding Product Key"
                    $ProductKey = $_.Exception.Message
                }

                if ($isWin8OrNewer)
                {
                    $ProductKey = $ProductKey.Remove(0, 1)
                    $ProductKey = $ProductKey.Insert($r, 'N')
                }
                for ($i = 5; $i -lt 29; $i = $i + 6)
                {
                    $ProductKey = $ProductKey.Insert($i, '-')
                }

            }
            else
            {
                $ProductKey = 'Failure'
            }

            [PSCustomObject]@{
                Machine     = $Computer
                ProductName = $ProductNameValue
                ProductKey  = $ProductKey
            }
        }

        foreach ($Computer in $Computername)
        {

            $ProductKeyObject = & $GetProductKeyFromComputer -Computer $Computer
            $OutputObject = [PSCustomObject]@{
                Machine     = $ProductKeyObject.Machine
                ProductName = $ProductKeyObject.ProductName
                ProductKey  = $ProductKeyObject.ProductKey
            }
            if ($FullReport)
            {

                $LicenseStatusDict = @{
                    0 = "Unlicensed";
                    1 = "Licensed";
                    2 = "OOBGrace";
                    3 = "OOTGrace";
                    4 = "NonGenuineGrace";
                    5 = "Notification";
                    6 = "ExtendedGrace"
                }


                $ExtendedInfoKeys = 'Name', 'Description', 'ApplicationId', 'ProductKeyChannel', 'UseLicenseURL', 'ValidationURL', 'ProductKeyID', 'LicenseStatus', 'LicenseFamily'
                $ExtendedInfo = Get-CimInstance -ClassName SoftwareLicensingProduct -Filter 'PartialProductKey is not null' | Select-Object $ExtendedInfoKeys

                $LicenseStatus = $LicenseStatusDict[$ExtendedInfo.LicenseStatus -as [Int]]
                $OutputObject | Add-Member -NotePropertyName LicenseStatus -NotePropertyValue $LicenseStatus | Out-Null
                $OutputObject | Add-Member -NotePropertyName LicenseName -NotePropertyValue $ExtendedInfo.Name | Out-Null
                $OutputObject | Add-Member -NotePropertyName Description -NotePropertyValue $ExtendedInfo.Description | Out-Null
                $OutputObject | Add-Member -NotePropertyName LicenseFamily -NotePropertyValue $ExtendedInfo.LicenseFamily | Out-Null
                $OutputObject | Add-Member -NotePropertyName ProductKeyChannel -NotePropertyValue $ExtendedInfo.ProductKeyChannel | Out-Null
                $OutputObject | Add-Member -NotePropertyName ApplicationID -NotePropertyValue $ExtendedInfo.ApplicationId | Out-Null
                $OutputObject | Add-Member -NotePropertyName ProductKeyID -NotePropertyValue $ExtendedInfo.ProductKeyID | Out-Null
                $OutputObject | Add-Member -NotePropertyName UseLicenseURL -NotePropertyValue $ExtendedInfo.UseLicenseURL | Out-Null
                $OutputObject | Add-Member -NotePropertyName ValidationURL -NotePropertyValue $ExtendedInfo.ValidationURL | Out-Null
            }

            $OutputObject
        }
    }
}       



<#
﻿function Get-WindowsProductKey {
    # Retrieve the Windows Product Key
    # Base24 Decrypt Algorithm from: http://mspowershell.blogspot.com/2010/11/sql-server-product-key.html

    param(
        [parameter(ValueFromPipeline)]
        $regKey = $(Get-ItemProperty 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion')
    )

    $keyArray = $regKey.DigitalProductId4[52..66]
    $chars = 'BCDFGHJKMPQRTVWXY2346789'
    $productKey = ''

    # decrypt base24 encoded binary data
    for ($i = 24; $i -ge 0; $i--) {
        $k = 0
        for ($j = 14; $j -ge 0; $j--) {
            $k = $k * 256 -bxor $keyArray[$j]
            $keyArray[$j] = [math]::truncate($k / 24)
            $k = $k % 24
        }

        $productKey = $chars[$k] + $productKey
        if ( ($i % 5 -eq 0) -and ($i -ne 0) ) {
            $productKey = '-' + $productKey
        }
    }

    $productKey
}
#>