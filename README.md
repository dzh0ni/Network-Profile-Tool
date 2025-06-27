![logo](https://github.com/AAAAAEXQOSyIpN2JZ0ehUQ/WiFi-Key-Harvester/blob/main/Imagenes/WiFi-Key-Harvester.png)

# WiFi Key Harvester :octocat:
 
## :information_source: Descripción
WiFi Key Harvester es un script en PowerShell diseñado para extraer y registrar 
las contraseñas de todas las redes Wi-Fi guardadas en tu equipo. Este script 
es útil para recuperar contraseñas olvidadas o para realizar auditorías 
de seguridad en tus propios dispositivos.

### :computer: Instalación

Para instalar y ejecutar el script WiFi Key Harvester, sigue estos pasos:

1. Descarga el archivo ZIP del repositorio:

   [Descargar el repositorio](https://github.com/dzh0ni/WiFi-Key-Harvester/archive/refs/heads/main.zip)

2. Extrae el contenido del archivo ZIP:

   Descomprime el archivo descargado en una carpeta de tu elección. Esto creará una carpeta con todos los archivos necesarios.

## :rocket: Modo de Uso

Sigue estos pasos para ejecutar el script.

1. Navega al directorio del script.

   Navega hasta la carpeta donde descomprimiste el archivo ZIP. 

2. Ejecuta el script:

   Dentro de la carpeta descomprimida, haz doble clic en el siguiente archivo para ejecutar el script

   - `RunGetWiFiKeyHarvesters.cmd`

3. Visualiza los resultados:
   - El script mostrará los perfiles Wi-Fi encontrados y sus contraseñas en la consola.
   - Las contraseñas se guardarán en un archivo de texto llamado `wifi_passwords.txt` en el mismo directorio donde se encuentra el script.

¡Y eso es todo! Ahora estás listo para utilizar WiFi Key Harvester para recuperar tus contraseñas Wi-Fi guardadas.

## :mag: Ejemplo de Salida
El archivo wifi_passwords.txt contendrá entradas en el siguiente formato:

- Seguridad: Guarda el archivo `wifi_passwords.txt` en un lugar seguro y elimínalo si no es necesario para evitar que terceros accedan a esta información.

```plaintext
Perfil: <Nombre del Perfil>
Contraseña: <Contraseña>
-----------------------------------
```

## :bookmark_tabs: Notas
Este script permite ejecutar con un simple clic para obtener los resultados deseados.

- Extracción Automática: Extrae automáticamente las contraseñas de todos los perfiles Wi-Fi almacenados en tu equipo.
- Registro de Contraseñas: Guarda las contraseñas extraídas en un archivo de texto para su posterior consulta.
- Detección de Duplicados: Verifica si un perfil ya ha sido registrado previamente para evitar duplicados en el archivo de salida.
- Soporte para Windows: Diseñado específicamente para entornos Windows.
- Permisos: Asegúrate de ejecutar los scripts con permisos adecuados

## :star2: Características 

- Automatización: Ejecuta comandos de forma automatizada para simplificar las auditorías Wi-Fi.
- Organización: Agrupa funcionalidades relacionadas para un acceso rápido y eficiente.

## :hammer_and_wrench: Requisitos 

- Sistema Operativo: Windows
- PowerShell: Versión 5.1 o superior

## :open_file_folder: Estructura del Repositorio

| Icono            | Nombre                        | Descripción                                          |
|------------------|-------------------------------|------------------------------------------------------|
| :file_folder:    | imágenes                      | Carpeta para imágenes                                |
| :file_folder:    | .gitattributes                | Archivo para configuración de Git                    |
| :page_facing_up: | GetWiFiKeyHarvester.ps1       | Script principal para la extracción de claves Wi-Fi  |
| :page_facing_up: | LICENSE                       | Archivo de licencia del proyecto                     |
| :page_facing_up: | README.md                     | Archivo de documentación principal                   |
| :page_facing_up: | RunGetWiFiKeyHarvesters.cmd   | Script de bat para ejecutar el script en Windows     |

## :star2: Contribuciones

Las contribuciones son bienvenidas. Si tienes ideas para mejorar este script o encuentras algún problema, siéntete libre de abrir un *pull request* o *issue*.

## :warning: Advertencias

- Uso Responsable: Este script está diseñado para ser utilizado en dispositivos y redes que te pertenecen o para las que tienes permiso de uso. No lo utilices para actividades no autorizadas.

## :email: Contacto 
* :busts_in_silhouette: **dZh0ni**: [Telegram](https://t.me/dZh0ni_Dev) - Desarrollador WiFi Key Harvester
