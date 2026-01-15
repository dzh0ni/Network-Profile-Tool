#====================================================
#   SCRIPT:                     Network Profile Tool 
#   DESCRIPTION:                Network configuration management 
#   VERSION:                    2.2-dev 
#   DEVELOPER:                  dZh0ni - Jony Rivera 
#   LAST UPDATE:                03-09-2025 
#   TELEGRAM CONTACT:           https://t.me/dZh0ni_dev 
#   OFFICIAL GITHUB:            https://github.com/dzh0ni/Network-Profile-Tool 
#====================================================

#----------------------------
# Function to show a banner
#----------------------------
function Show-Banner {
    param (
        [Parameter(Mandatory=$true)]
        [System.ConsoleColor]$BannerColor,
        [Parameter(Mandatory=$true)]
        [System.ConsoleColor]$TextColor
    )
    
    $host.UI.RawUI.ForegroundColor = $BannerColor

    Write-Host "`n|-------------------------------------------------|"
    Write-Host "|------------ Network Profile Tool ---------------|"

    $host.UI.RawUI.ForegroundColor = $TextColor
    Write-Host "|-------------- " -NoNewline
    Write-Host "PowerShell Script" -ForegroundColor $TextColor -NoNewline
    Write-Host " ----------------|"

    $host.UI.RawUI.ForegroundColor = $BannerColor
    Write-Host "|-------------------------------------------------|`n"

    $host.UI.RawUI.ForegroundColor = [System.ConsoleColor]::White
}

#----------------------------
# Function to set console color
#----------------------------
function Set-ConsoleColor {
    param (
        [Parameter(Mandatory=$true)]
        [System.ConsoleColor]$ForegroundColor
    )
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
}

#----------------------------
# Function to check if a profile exists in file
#----------------------------
function Check-ProfileExists {
    param (
        [Parameter(Mandatory=$true)]
        [string]$ProfileName,
        [Parameter(Mandatory=$true)]
        [string]$OutputFile
    )

    $profileExists = $false
    if (Test-Path $OutputFile) {
        $fileContent = Get-Content $OutputFile
        $profileHeader = "Profile: $ProfileName"
        if ($fileContent -contains $profileHeader) {
            $profileExists = $true
        }
    }
    return $profileExists
}

#----------------------------
# Define colors
#----------------------------
$green = [System.ConsoleColor]::Green
$reset = [System.ConsoleColor]::White
$cyan = [System.ConsoleColor]::Cyan
$red = [System.ConsoleColor]::Red
$yellow = [System.ConsoleColor]::Yellow

#----------------------------
# Clear screen and show banner
#----------------------------
Clear-Host
Show-Banner -BannerColor $green -TextColor $green

#----------------------------
# Display user info
#----------------------------
Set-ConsoleColor -ForegroundColor $green
Write-Host "ID       :  $env:USERNAME"
Write-Host "Version  :  2.2-dev"
Write-Host "Update   :  03-09-2025"
Write-Host "License  :  MIT License"

Set-ConsoleColor -ForegroundColor $cyan
Write-Host "`nDeveloper: dZh0ni - Jony Rivera `n"

#----------------------------
# Create directory for databases
#----------------------------
$DatabaseDir = "Database_Passwords"
if (-not (Test-Path $DatabaseDir)) {
    New-Item -ItemType Directory -Path $DatabaseDir | Out-Null
}

#----------------------------
# Define output files inside the directory
#----------------------------
$outputFile = Join-Path $DatabaseDir "database_passwords.txt"
$TableFile = Join-Path $DatabaseDir "database_table.txt"

#----------------------------
# Get all Wi-Fi profiles
#----------------------------
$wifiProfiles = netsh wlan show profiles | Select-String "Perfil de todos los usuarios" | ForEach-Object { ($_ -split ":")[1].Trim() }
$wifiProfiles = $wifiProfiles | Where-Object { $_ -ne "" }

if ($wifiProfiles.Count -eq 0) {
    Set-ConsoleColor -ForegroundColor $green
    Write-Host "No Wi-Fi profiles found!"
    Set-ConsoleColor -ForegroundColor $reset
    exit
}

#----------------------------
# Extract passwords and save
#----------------------------
foreach ($profile in $wifiProfiles) {
    $profileClean = $profile -replace '\s+', ' '

    if (-not (Check-ProfileExists -ProfileName $profileClean -OutputFile $outputFile)) {
        Set-ConsoleColor -ForegroundColor $green
        Write-Host "Profile: $profileClean"

        $password = netsh wlan show profile name="$profileClean" key=clear | Select-String "Contenido de la clave" | ForEach-Object { ($_ -split ":")[1].Trim() }
        if (-not $password) {
            $password = "Not Found"
        }

        Set-ConsoleColor -ForegroundColor $cyan
        Write-Host "Password: $password"
        
        Set-ConsoleColor -ForegroundColor $green
        Write-Host "-----------------------------------"

        Add-Content -Path $outputFile -Value "Profile: $profileClean"
        Add-Content -Path $outputFile -Value "Password: $password"
        Add-Content -Path $outputFile -Value "-----------------------------------"
    } else {
        Set-ConsoleColor -ForegroundColor $red
        Write-Host "Profile already registered: $profileClean"
    }
}

Set-ConsoleColor -ForegroundColor $cyan
Write-Host "`nWi-Fi passwords saved to $outputFile`n"

#----------------------------
# Generate table
#----------------------------
if (Test-Path $outputFile) {
    $lines = Get-Content $outputFile
    $dataTable = @()

    for ($i = 0; $i -lt $lines.Count; $i++) {
        if ($lines[$i] -like "Profile:*") {
            $ssid = $lines[$i] -replace "Profile:\s*", ""
            $pwd = $lines[$i + 1] -replace "Password:\s*", ""
            $dataTable += @{ SSID = $ssid; Password = $pwd }
        }
    }

    # Build table
    $tableContent = @()
    $tableContent += "=" * 62
    $tableContent += "             RECOVERED WI-FI PASSWORDS"
    $tableContent += "=" * 62
    $tableContent += "SSID".PadRight(38) + " | " + "Password".PadRight(20)
    $tableContent += "-" * 62

    foreach ($item in $dataTable) {
        $line = "{0,-38} | {1,-20}" -f $item['SSID'], $item['Password']
        $tableContent += $line
    }

    $tableContent += "=" * 62
    $tableContent | Out-File -FilePath $TableFile -Encoding UTF8

    $host.UI.RawUI.ForegroundColor = $cyan
    Write-Host "Table saved successfully in: $TableFile`n"
    $host.UI.RawUI.ForegroundColor = $reset
}

#----------------------------
# End of script
#----------------------------