<#
    .SYNOPSIS
    This Cmdlet is used to test an URL

    .DESCRIPTION
    Function to check the status of an URL

    .PARAMETER URL
    URL to test

    .EXAMPLE
    Get-UpTime -ComputerName <ComputerName>

    .NOTES
    Author: H. van der Mark
    Email : Herby@vandermark.org

    .LINK
    https://github.com/hvdm/HMUtils/
#>

function Test-URL
{
    param 
    (
        [ValidateNotNullOrEmpty()]    
        [string]$url
    )

    try
    {
        # Make the web request
        $response = Invoke-WebRequest -Uri $url -UseBasicParsing -ErrorAction Stop
        
        # Check if status code is 200 (OK)
        if ($response.StatusCode -eq 200)
        {
            Write-Host -ForegroundColor Green "[$($response.StatusCode)]" -NoNewline
            Write-Host " $url"
            return $true
        }
        else
        {
            Write-Host -ForegroundColor Red "[$($response.StatusCode)]" -NoNewline
            Write-Host " $url"
            return $false
        }
    }
    catch
    {
        Write-Host -ForegroundColor Red "[   ]" -NoNewline
        Write-Host " $url" -NoNewline
        Write-Host " (Connection failed or invalid URL)" -ForegroundColor Red
        return $false
    }
}