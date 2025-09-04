![logo](https://multianime.com.mx/wp-content/uploads/2020/08/anime-404-gomen-.jpg)

# Network Profile Tool :octocat:

## :information_source: Descripción
Network Profile Tool es un script en PowerShell diseñado para gestionar y recuperar la configuración de redes Wi-Fi, incluyendo la extracción de contraseñas de los perfiles guardados en tu equipo. Este script es útil para auditorías de seguridad y para recuperar contraseñas olvidadas en tus dispositivos propios.

### :computer: Instalación

Para instalar y ejecutar Network Profile Tool, sigue estos pasos:

1. Descarga el archivo ZIP del repositorio:

   [Descargar el repositorio](https://github.com/dzh0ni/WiFi-Key-Harvester/archive/refs/heads/main.zip)

2. Extrae el contenido del archivo ZIP:

   Descomprime el archivo descargado en una carpeta de tu elección. Esto creará una carpeta con todos los archivos necesarios.

## :rocket: Modo de Uso

Sigue estos pasos para ejecutar el script:

1. Navega al directorio del script.

   Ve a la carpeta donde descomprimiste el archivo ZIP. 

2. Ejecuta el script:

   Dentro de la carpeta descomprimida, haz doble clic en el archivo:

   - RunNetworkProfileTool.cmd

3. Visualiza los resultados:
   - El script mostrará los perfiles Wi-Fi encontrados y sus contraseñas en la consola.
   - Las contraseñas se guardarán en la carpeta Database_Passwords:
     - database_passwords.txt
     - database_table.txt

## :mag: Ejemplo de Salida

### database_passwords.txt
Perfil: <Nombre del Perfil>
Contraseña: <Contraseña>
-----------------------------------

### database_table.txt
==============================================================
             RECOVERED WI-FI PASSWORDS
==============================================================
SSID                                   | Password           
--------------------------------------------------------------
<Perfil1>                              | <Contraseña1>
<Perfil2>                              | <Contraseña2>
<Perfil3>                              | <Contraseña3>
--------------------------------------------------------------
==============================================================

> Seguridad: Guarda los archivos generados en un lugar seguro y elimínalos si no son necesarios para evitar accesos no autorizados.

## :bookmark_tabs: Notas
Este script permite ejecutar con un simple clic y obtener los resultados de manera organizada.  
Algunas recomendaciones de uso:

- Ejecuta el script con permisos adecuados para acceder a los perfiles Wi-Fi.  
- Guarda los archivos generados en la carpeta Database_Passwords para mantenerlos organizados.  
- Elimina los archivos si no son necesarios para evitar que terceros accedan a la información sensible.  
- Verifica los perfiles existentes antes de un nuevo escaneo para evitar duplicados.  

## :star2: Características

- Extracción Automática: Obtiene automáticamente las contraseñas de todos los perfiles Wi-Fi guardados en el equipo.  
- Registro de Contraseñas: Guarda los resultados en archivos separados (database_passwords.txt y database_table.txt) para facilitar la consulta.  
- Organización: Presenta los datos de manera ordenada, con tabla y formato claro.  
- Soporte para Windows: Compatible con entornos Windows modernos.  
- Automatización: Ejecuta los comandos automáticamente sin intervención adicional.  

## :hammer_and_wrench: Requisitos

- Sistema Operativo: Windows  
- PowerShell: Versión 5.1 o superior  

## :open_file_folder: Estructura del Repositorio

| Icono            | Nombre                        | Descripción                                          |
|------------------|-------------------------------|------------------------------------------------------|
| :file_folder:    | imágenes                      | Carpeta para imágenes                                |
| :file_folder:    | .gitattributes                | Archivo para configuración de Git                    |
| :page_facing_up: | NetworkProfileTool.ps1        | Script principal para la gestión de redes Wi-Fi      |
| :page_facing_up: | LICENSE                       | Archivo de licencia del proyecto                     |
| :page_facing_up: | README.md                     | Archivo de documentación principal                   |
| :page_facing_up: | README.html                   | Versión HTML del README para visualización en navegador |
| :page_facing_up: | RunNetworkProfileTool.cmd     | Script para ejecutar el script en Windows           |

## :star2: Contribuciones

Las contribuciones son bienvenidas. Si tienes ideas para mejorar este script o encuentras algún problema, siéntete libre de abrir un pull request o issue.

## :warning: Advertencias

- Uso Responsable: Este script está diseñado para ser utilizado únicamente en dispositivos y redes que te pertenezcan o para las que tengas permiso de uso. No lo uses para actividades no autorizadas.

## :email: Contacto 

- :busts_in_silhouette: dZh0ni: [Telegram](https://t.me/dZh0ni_Dev) - Desarrollador de Network Profile Tool
