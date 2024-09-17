#====================================================
#   SCRIPT:                   WiFi Key Harvester
#   DESARROLLADO POR:         JONY RIVERA (Dzhoni_dev) 
#   FECHA DE ACTUALIZACIÓN:   09-09-2024 
#   CONTACTO TELEGRAM:        https://t.me/Dzhoni_dev
#   GITHUB OFICIAL:           https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/WiFi-Key-Harvester
#====================================================

# Función para mostrar un banner
function Show-Banner {
    param (
        [Parameter(Mandatory=$true)]
        [System.ConsoleColor]$BannerColor,
        [Parameter(Mandatory=$true)]
        [System.ConsoleColor]$TextColor
    )
    
    # Definir colores del banner
    $host.UI.RawUI.ForegroundColor = $BannerColor

    Write-Host "`n|-------------------------------------------------|"
    Write-Host "|--------- WiFi Key Harvester - PowerShell -------|"

    # Cambiar el color del texto
    $host.UI.RawUI.ForegroundColor = $TextColor
    Write-Host "|-------------- " -NoNewline
    Write-Host "Harvesting WiFi Keys" -ForegroundColor $TextColor -NoNewline
    Write-Host " -------------|"

    # Restablecer el color del banner
    $host.UI.RawUI.ForegroundColor = $BannerColor
    Write-Host "|-------------------------------------------------|`n"

    # Restablecer color
    $host.UI.RawUI.ForegroundColor = [System.ConsoleColor]::White
}

# Función para establecer el color de la consola
function Set-ConsoleColor {
    param (
        [Parameter(Mandatory=$true)]
        [System.ConsoleColor]$ForegroundColor
    )
    $host.UI.RawUI.ForegroundColor = $ForegroundColor
}

# Función para verificar si un perfil ya está en el archivo
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
        $profileHeader = "Perfil: $ProfileName"
        if ($fileContent -contains $profileHeader) {
            $profileExists = $true
        }
    }
    return $profileExists
}

# Definir colores
$green = [System.ConsoleColor]::Green
$reset = [System.ConsoleColor]::White
$cyan = [System.ConsoleColor]::Cyan
$red = [System.ConsoleColor]::Red
$yellow = [System.ConsoleColor]::Yellow
$blue = [System.ConsoleColor]::Blue
$magenta = [System.ConsoleColor]::Magenta
$gray = [System.ConsoleColor]::Gray
$darkCyan = [System.ConsoleColor]::DarkCyan
$darkRed = [System.ConsoleColor]::DarkRed
$darkGreen = [System.ConsoleColor]::DarkGreen
$darkYellow = [System.ConsoleColor]::DarkYellow
$darkBlue = [System.ConsoleColor]::DarkBlue
$darkMagenta = [System.ConsoleColor]::DarkMagenta
$darkGray = [System.ConsoleColor]::DarkGray
$black = [System.ConsoleColor]::Black

# Limpiar la pantalla y mostrar banner
Clear-Host
Show-Banner -BannerColor $green -TextColor $green

# Mostrar información del usuario y versión del script
Set-ConsoleColor -ForegroundColor $green
Write-Host "   ID        :  $env:USERNAME"
Write-Host "   Version   :  v0.0.01-dev"
Write-Host "   Update    :  [09-09-2024]`n"

Write-Host " Version coded by: Dzhoni_dev`n"

# Crear o abrir un archivo para guardar las contraseñas
$outputFile = "wifi_passwords.txt"

# Obtener todos los perfiles Wi-Fi
$wifiProfiles = netsh wlan show profiles | Select-String "Perfil de todos los usuarios" | ForEach-Object { ($_ -split ":")[1].Trim() }

if ($wifiProfiles.Count -eq 0) {
    Set-ConsoleColor -ForegroundColor $green
    Write-Host "¡No se encontraron perfiles Wi-Fi!"
    Set-ConsoleColor -ForegroundColor $reset
    exit
}

# Extraer la contraseña de cada perfil y guardarla en el archivo
foreach ($profile in $wifiProfiles) {
    $profile = $profile.Replace("`r", "")
    $profileClean = $profile -replace '\s+', ' '

    if (-not (Check-ProfileExists -ProfileName $profileClean -OutputFile $outputFile)) {
        Set-ConsoleColor -ForegroundColor $green
        Write-Host "Perfil: $profileClean"

        $password = netsh wlan show profile name="$profileClean" key=clear | Select-String "Contenido de la clave" | ForEach-Object { ($_ -split ":")[1].Trim() }
        if (-not $password) {
            $password = "No se encontró"
        }

        Set-ConsoleColor -ForegroundColor $cyan
        Write-Host "Contraseña: $password"
        
        Set-ConsoleColor -ForegroundColor $green
        Write-Host "-----------------------------------"

        # Escribir en el archivo
        Add-Content -Path $outputFile -Value "Perfil: $profileClean"
        Add-Content -Path $outputFile -Value "Contraseña: $password"
        Add-Content -Path $outputFile -Value "-----------------------------------"
    } else {
        Set-ConsoleColor -ForegroundColor $red
        Write-Host "Perfil ya registrado: $profileClean"
        # Write-Host "-----------------------------------"
    }
}

Set-ConsoleColor -ForegroundColor $cyan
Write-Output "`nLas contraseñas Wi-Fi se han guardado en $outputFile`n"

# Restablecer el color del texto
Set-ConsoleColor -ForegroundColor $reset

# Fin del script