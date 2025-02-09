
@{

    # Script module or binary module file associated with this manifest.
    RootModule           = 'HMUtils.psm1'

    # Version number of this module.
    ModuleVersion        = '1.0.0'

    # Supported PSEditions
    CompatiblePSEditions = "Desktop", "Core"

    # ID used to uniquely identify this module
    GUID                 = '698e7dca-a019-476a-b781-78422cd52fca'

    # Author of this module
    Author               = 'H. van der Mark'

    # Company or vendor of this module
    CompanyName          = 'Herby'

    # Copyright statement for this module
    Copyright            = '(c) 2024 Herby. All rights reserved.'

    # Description of the functionality provided by this module
    Description          = 'A set of tools, handy for regular use'

    # Minimum version of the Windows PowerShell engine required by this module
    PowerShellVersion    = '5.0'

    # Format files (.ps1xml) to be loaded when importing this module
    # FormatsToProcess = 'Get-Uptime.Format.ps1xml'

    # Functions to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no functions to export.
    FunctionsToExport    = 
    @(  'Get-BootTime',
        'Get-LastLogon', 
        'Get-MainboardSerial', 
        'Get-NetExternalIP',
        'Get-UpTime', 
        'Get-WindowsProductKey',
        'Test-WinRM',
        'Get-InteractiveMultiMenuOption', 'Get-InteractiveMenuUserSelection', 'Get-InteractiveChooseMenuOption', 'Get-InteractiveMenuChooseUserSelection',
        'Test-URL'
    )

    # Aliases to export from this module, for best performance, do not use wildcards and do not delete the entry, use an empty array if there are no aliases to export.
    # AliasesToExport      = 

    # Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
    PrivateData          = @{

        PSData = @{

            # Tags applied to this module. These help with module discovery in online galleries.
            Tags       = 'HMUtils'

            # A URL to the license for this module.
            LicenseUri = 'https://github.com/hvdm/HMUtils/blob/main/LICENSE.txt'

            # A URL to the main website for this project.
            ProjectUri = 'https://github.com/hvdm/HMUtils/'

            # A URL to an icon representing this module.
            # IconUri = ''

            # ReleaseNotes of this module
            #ReleaseNotes = ''

        } # End of PSData hashtable

    } # End of PrivateData hashtable

    # HelpInfo URI of this module
    # HelpInfoURI = ''

    # Default prefix for commands exported from this module. Override the default prefix using Import-Module -Prefix.
    # DefaultCommandPrefix = ''

}

