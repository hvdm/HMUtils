. .\Functions\Get-Menu.ps1

# #Get-Menu
# Write-Host "Try-Catch=(with error)========================================"
# ##### TRY - CATCH #####
# try
# {
#     function get-directorycount
#     {
#         param ($directory)
    
#         # Get a list of directories found
#         $dirs = Get-ChildItem $directory -Directory

#         # Count the directories and write it
#         Write-Host -ForegroundColor Black -BackgroundColor Yellow "Directory count: $($dirs.count)"
#     }
    
#     Write-Host "TRY    : Run a directory count "
#     get-directorycount "x:\"

# }
# catch
# {
#     # Catch the error
#     Write-Host "CATCH  : An error occured"
#     Write-Host $_.Exception.Message -ForegroundColor Red
# }

# Define the items for the menu
# Note: the url, info, selected and readonly parameters are optional

# Multiple selection items
$multiMenuOptions = @(
    Get-InteractiveMultiMenuOption `
        -Item "Sample option deselected" `
        -Label "Sample option deselected" `
        -Order 0 `
        -Info "This is some info" `
        -Url "https://google.com"
    Get-InteractiveMultiMenuOption `
        -Item "Sample option selected" `
        -Label "Sample option selected" `
        -Order 1 `
        -Info "This is some info" `
        -Url "https://google.com" `
        -Selected
    Get-InteractiveMultiMenuOption `
        -Item "Sample option mandatory" `
        -Label "Sample option mandatory" `
        -Order 3 `
        -Info "This is some info" `
        -Url "https://google.com" `
        -Selected `
        -Readonly
    Get-InteractiveMultiMenuOption `
        -Item "Sample option unavailable" `
        -Label "Sample option unavailable" `
        -Order 4 `
        -Info "This is some info" `
        -Url "https://google.com" `
        -Readonly
    Get-InteractiveMultiMenuOption `
        -Item "Sample option without info" `
        -Label "Sample option without info" `
        -Order 5 `
        -Url "https://google.com"
    Get-InteractiveMultiMenuOption `
        -Item "Sample option without URL" `
        -Label "Sample option without URL" `
        -Order 6 `
        -Info "This is some info"
)

$options = @{
    HeaderColor          = [ConsoleColor]::Magenta;
    HelpColor            = [ConsoleColor]::Cyan;
    CurrentItemColor     = [ConsoleColor]::DarkGreen;
    LinkColor            = [ConsoleColor]::DarkCyan;
    CurrentItemLinkColor = [ConsoleColor]::Black;
    MenuDeselected       = "[ ]";
    MenuSelected         = "[x]";
    MenuCannotSelect     = "[/]";
    MenuCannotDeselect   = "[!]";
    MenuInfoColor        = [ConsoleColor]::DarkYellow;
    MenuErrorColor       = [ConsoleColor]::DarkRed;
}

$header = "Demo of the multi-selection menu"

$selectedOptions = Get-InteractiveMenuUserSelection -Header $header -Items $multiMenuOptions -Options $options

$selectedOptions | Format-List