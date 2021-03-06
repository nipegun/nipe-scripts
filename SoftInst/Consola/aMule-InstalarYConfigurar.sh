#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#--------------------------------------------------------------------
#  Script de NiPeGun para instalar y configurar aMule en Debian
#--------------------------------------------------------------------

## Determinar la versión de Debian

   if [ -f /etc/os-release ]; then
       # Para systemd y freedesktop.org
       . /etc/os-release
       OS_NAME=$NAME
       OS_VERS=$VERSION_ID
   elif type lsb_release >/dev/null 2>&1; then
       # linuxbase.org
       OS_NAME=$(lsb_release -si)
       OS_VERS=$(lsb_release -sr)
   elif [ -f /etc/lsb-release ]; then
       # Para algunas versiones de Debian sin el comando lsb_release
       . /etc/lsb-release
       OS_NAME=$DISTRIB_ID
       OS_VERS=$DISTRIB_RELEASE
   elif [ -f /etc/debian_version ]; then
       # Para versiones viejas de Debian.
       OS_NAME=Debian
       OS_VERS=$(cat /etc/debian_version)
   else
       # Para el viejo uname (También funciona para BSD)
       OS_NAME=$(uname -s)
       OS_VERS=$(uname -r)
   fi


if [ $OS_VERS == "7" ]; then

  echo ""
  echo "-----------------------------------------------------------------------------"
  echo "  Iniciando el script de instalación de amule para Debian 7 (Wheezy)..."
  echo "-----------------------------------------------------------------------------"
  echo ""

  echo ""
  echo "Instalación para Debian 7 todavía no preparada. Prueba instalarlo en otra versión de Debian"
  echo ""

elif [ $OS_VERS == "8" ]; then

  echo ""
  echo "-----------------------------------------------------------------------------"
  echo "  Iniciando el script de instalación de amule para Debian 8 (Jessie)..."
  echo "-----------------------------------------------------------------------------"
  echo ""

  echo ""
  echo "Instalación para Debian 8 todavía no preparada. Prueba instalarlo en otra versión de Debian"
  echo ""

elif [ $OS_VERS == "9" ]; then

  echo ""
  echo "------------------------------------------------------------------------------"
  echo "  Iniciando el script de instalación de amule para Debian 9 (Stretch)..."
  echo "------------------------------------------------------------------------------"
  echo ""

  ArgumentosRequeridos=4
  ArgumentosInsuficientes=65

  if [ $# -ne $ArgumentosRequeridos ]
    then
      echo ""
      echo "--------------------------------------------------------------------------------------------"
      echo "  Mal uso del script."
      echo ""
      echo "  El uso correcto sería:"
      echo "  $0 [CarpetaDeDescargas] [CarpetaDeIncompletos] [Usuario] [Password] [AdminPassword]"
      echo ""
      echo "  Ejemplo:"
      echo "  $0 /var/tmp/amule/completos /var/tmp/amule/incompletos 12345678 debian-amule"
      echo "--------------------------------------------------------------------------------------------"
      echo ""
      exit $ArgumentosInsuficientes
    else
      echo ""
      echo "Creando las carpetas para las descargas..."
      echo ""
      mkdir -p $1
      mkdir -p $2
    
      echo ""
      echo "Instalando el paquete amule-daemon..."
      echo ""
      apt-get -y install amule-daemon

      echo ""
      echo "Agregando el usuario $3..."
      echo ""
      adduser $3

      echo ""
      echo "Corriendo el comando amuled por primera vez para el usuario $3..."
      echo ""
      runuser -l $3 -c 'amuled'

      echo ""
      echo "Deteniendo el servicio amule-daemon..."
      echo ""
      service amule-daemon stop

      echo ""
      echo "Realizando cambios en la configuración..."
      echo ""
      sed -i -e 's|TempDir=/home/debian-amule/.aMule/Temp|TempDir="'$1'"|g' /home/$3/.aMule/amule.conf
      sed -i -e 's|IncomingDir=/home/debian-amule/.aMule/Incoming|IncomingDir="'$2'"|g' /home/$3/.aMule/amule.conf

      runuser -l $3 -c 'amuleweb --write-config --host=localhost --password=$4 --admin-pass=$5'
      AdminPassword=$(echo -n $5 | md5sum | cut -d ' ' -f 1)
      sed -i -e 's|AcceptExternalConnections=0|AcceptExternalConnections=1|g' /home/$3/.aMule/amule.conf
      sed -i -e 's|ECPassword=|ECPassword=$AdminPassword|g' /home/$3/.aMule/amule.conf
      sed -i '/WebServer]/{n;s/.*/Enabled=1/}' /home/$3/.aMule/amule.conf
      WebPassword=$(echo -n $4 | md5sum | cut -d ' ' -f 1)
      sed -i -e 's|^Password=|Password=$WebPassword|g' /home/$3/.aMule/amule.conf
      sed -i -e 's|AMULED_USER=""|AMULED_USER="$3"|g' /etc/default/amule-daemon

      echo ""
      echo "Iniciando el servicio amule-daemon..."
      echo ""
      service amule-daemon start

      #echo ""
      #echo "Agregando el usuario al grupo amule-daemon..."
      #echo ""
      #usermod -a -G debian-amule $3

      echo ""
      echo "--------------------------------------------------------------"
      echo "  El demonio amule ha sido instalado, configurado e inciado."
      echo ""
      echo "  Deberías poder administrarlo mediante web en la IP de"
      echo "  este ordenador seguida por :4711"
      echo ""
      echo "  Ejemplo: 192.168.0.120:4711"
      echo ""
      echo "  Nombre de usuario: debian-amule"
      echo "  Contraseña: password"
      echo "---------------------------------------------------------"
      echo ""
  fi

elif [ $OS_VERS == "10" ]; then

  echo ""
  echo "------------------------------------------------------------------------------"
  echo "  Iniciando el script de instalación de amule para Debian 10 (Buster)..."
  echo "------------------------------------------------------------------------------"
  echo ""

  echo ""
  echo "Instalación para Debian 10 todavía no preparada. Prueba instalarlo en otra versión de Debian"
  echo ""

elif [ $OS_VERS == "11" ]; then

  echo ""
  echo "--------------------------------------------------------------------------------"
  echo "  Iniciando el script de instalación de amule para Debian 11 (Bullseye)..."
  echo "--------------------------------------------------------------------------------"
  echo ""

  echo ""
  echo "Instalación para Debian 11 todavía no preparada. Prueba instalarlo en otra versión de Debian"
  echo ""

fi

