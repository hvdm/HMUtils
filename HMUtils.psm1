# Get all function *.ps1 files.
$Functions = @( Get-ChildItem -Path $PSScriptRoot\Functions\*.ps1 -ErrorAction SilentlyContinue )
   
# Loop through
Foreach ($function in $Functions)
{
    Try
    {
        . $function.fullname
    }
    Catch
    {
        Write-Error -Message "Failed to import function $($function.fullname): $_"
    }
}

# Export all the Functions modules
Export-ModuleMember -Function $Functions.Basename