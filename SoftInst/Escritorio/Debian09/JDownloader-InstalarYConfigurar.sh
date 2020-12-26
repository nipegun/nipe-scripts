#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#----------------------------------------------------------------
#  SCRIPT DE NIPEGUN PARA INSTALAR JDOWNLOADER.
#  ES NECESARIO TENER INSTALADO PREVIAMENTE UN ENTORNO GRÁFICO.
-----------------------------------------------------------------

cmd=(dialog --checklist "Instalación de JDownloader en Debian:" 22 76 16)
options=(1 "Instalación en Debian 32 bits" off
         2 "Instalación en Debian 64 bits" on)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
  case $choice in
  
    1)
      mkdir -p /root/paquetes/jdownloader
      cd /root/paquetes/jdownloader
      wget hacks4geeks.com/_/premium/descargas/debian/root/paquetes/jdownloader/JD2Setup_x32.sh
      chmod +x /root/paquetes/jdownloader/JD2Setup_x32.sh
      /root/paquetes/jdownloader/JD2Setup_x32.sh
    ;;

    2)
      mkdir -p /root/paquetes/jdownloader
      cd /root/paquetes/jdownloader
      wget hacks4geeks.com/_/premium/descargas/debian/root/paquetes/jdownloader/JD2Setup_x64.sh
      chmod +x /root/paquetes/jdownloader/JD2Setup_x64.sh
      /root/paquetes/jdownloader/JD2Setup_x64.sh
    ;;

  esac

done
