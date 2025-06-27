#====================================================
#   SCRIPT:                   WiFi Key Harvester
#   DESARROLLADO POR:         Jony Rivera (dZh0ni)
#   FECHA DE ACTUALIZACIÓN:   09-09-2024 
#   CONTACTO TELEGRAM:        https://t.me/dZh0ni_dev
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
    Write-Host "|------------- WiFi Key Harvester ----------------|"

    # Cambiar el color del texto
    $host.UI.RawUI.ForegroundColor = $TextColor
    Write-Host "|-------------- " -NoNewline
    Write-Host "PowerShell Scrip" -ForegroundColor $TextColor -NoNewline
    Write-Host " -----------------|"

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

Write-Host "ID       :  $env:USERNAME"
Write-Host "Version  :  v0.0.01-dev"
Write-Host "Update   :  09-09-2024"
Write-Host "Licencia :  MIT License"

# Mostrar información del usuario y versión del script
Set-ConsoleColor -ForegroundColor $cyan

Write-Host "`n Desarrollador: dZh0ni - Jony Rivera `n"

# Crear o abrir un archivo para guardar las Clave secretas
$outputFile = "database_passwords.txt"

# Obtener todos los perfiles Wi-Fi
$wifiProfiles = netsh wlan show profiles | Select-String "Perfil de todos los usuarios" | ForEach-Object { ($_ -split ":")[1].Trim() }

if ($wifiProfiles.Count -eq 0) {
    Set-ConsoleColor -ForegroundColor $green
    Write-Host "¡No se encontraron perfiles Wi-Fi!"
    Set-ConsoleColor -ForegroundColor $reset
    exit
}

# Extraer la Clave secreta de cada perfil y guardarla en el archivo
foreach ($profile in $wifiProfiles) {
    $profile = $profile.Replace("`r", "")
    $profileClean = $profile -replace '\s+', ' '

    if (-not (Check-ProfileExists -ProfileName $profileClean -OutputFile $outputFile)) {
        Set-ConsoleColor -ForegroundColor $green
        Write-Host "Perfil: $profileClean"

        $password = netsh wlan show profile name="$profileClean" key=clear | Select-String "Contenido de la clave" | ForEach-Object { ($_ -split ":")[1].Trim() }
        if (-not $password) {
            $password = "No se encontro"
        }

        Set-ConsoleColor -ForegroundColor $cyan
        Write-Host "Clave secreta: $password"
        
        Set-ConsoleColor -ForegroundColor $green
        Write-Host "-----------------------------------"

        # Escribir en el archivo
        Add-Content -Path $outputFile -Value "Perfil: $profileClean"
        Add-Content -Path $outputFile -Value "Clave secreta: $password"
        Add-Content -Path $outputFile -Value "-----------------------------------"
    } else {
        Set-ConsoleColor -ForegroundColor $red
        Write-Host "Perfil ya registrado: $profileClean"
        # Write-Host "-----------------------------------"
    }
}

Set-ConsoleColor -ForegroundColor $cyan
Write-Output "`nLas Clave secretas Wi-Fi se han guardado en $outputFile`n"

# Generar tabla simple al finalizar
$tablaFile = "database_tabla.txt"

if (Test-Path $outputFile) {
    $lineas = Get-Content $outputFile
    $datosTabla = @()

    for ($i = 0; $i -lt $lineas.Count; $i++) {
        if ($lineas[$i] -like "Perfil:*") {
            $perfil = $lineas[$i] -replace "Perfil:\s*", ""
            $clave = $lineas[$i + 1] -replace "Contraseña:\s*", ""
            $datosTabla += @{ Perfil = $perfil; Contrasena = $clave }
        }
    }

    # Construcción de tabla con barras normales
    $tablaDecorada = @()
    $tablaDecorada += "=============================================================="
    $tablaDecorada += "             CONTRASEÑAS WI-FI RECUPERADAS                    "
    $tablaDecorada += "=============================================================="
    $tablaDecorada += "Perfil                                 | Contraseña           "
    $tablaDecorada += "--------------------------------------------------------------"

    foreach ($item in $datosTabla) {
        $linea = "{0,-38} | {1,-20}" -f $item['Perfil'], $item['Contrasena']
        $tablaDecorada += $linea
    }

    $tablaDecorada += "=============================================================="

    # Guardar en archivo
    $tablaDecorada | Out-File -FilePath $tablaFile -Encoding UTF8

    Set-ConsoleColor -ForegroundColor $cyan
    Write-Host "Tabla generada correctamente y guardada en: $tablaFile`n"
}

Set-ConsoleColor -ForegroundColor $reset

# Fin del script