#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#---------------------------------------------------------------------------------------------------------------
#  Script de NiPeGun para preparar un ordenador o servidor con Debian 9 recién instalado y sin entorno gráfico
#---------------------------------------------------------------------------------------------------------------

cmd=(dialog --checklist "Script de NiPeGun para para post instalación de Debian 9 sin entorno gráfico:" 22 76 16)
options=(1 "Poner repositorios correctos" off
         2 "Actualizar el sistema" on
         3 "Instalar el servidor SSH" on
         4 "Instalar herramientas para compilar" on
         5 "Instalar herramientas para volúmenes" on
         6 "Instalar herramientas de red" on
         7 "Instalar otras cosas útiles" on
         8 "x" on)
choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
clear
for choice in $choices
do
  case $choice in
    1)
      echo ""
      echo "---------------------------------------"
      echo "  PONIENDO LOS REPOSITORIOS CORRECTOS"
      echo "---------------------------------------"
      echo ""
      sleep 2
      echo "deb http://ftp.debian.org/debian/ stretch main contrib non-free" > /etc/apt/sources.list
      echo "deb-src http://ftp.debian.org/debian/ stretch main contrib non-free" >> /etc/apt/sources.list
      echo "" >> /etc/apt/sources.list
      echo "deb http://ftp.debian.org/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list
      echo "deb-src http://ftp.debian.org/debian/ stretch-updates main contrib non-free" >> /etc/apt/sources.list
      echo "" >> /etc/apt/sources.list
      echo "deb http://security.debian.org/ stretch/updates main contrib non-free" >> /etc/apt/sources.list
      echo "deb-src http://security.debian.org/ stretch/updates main contrib non-free" >> /etc/apt/sources.list
      echo "" >> /etc/apt/sources.list
      echo ""
    ;;

    2)
      echo ""
      echo "---------------------------"
      echo "  ACTUALIZANDO EL SISTEMA"
      echo "---------------------------"
      echo ""
      sleep 2
      apt-get update && apt-get -y upgrade && apt-get -y dist-upgrade && apt-get autoremove
      echo ""
    ;;

    3)
      echo ""
      echo "------------------------------"
      echo "  INSTALANDO EL SERVIDOR SSH"
      echo "------------------------------"
      echo ""
      sleep 2
      apt-get -y install tasksel
      tasksel install ssh-server
      apt-get -y install sshpass
      echo ""
      echo "Match Group enjaulados" >> /etc/ssh/sshd_config
      echo "  ChrootDirectory /home" >> /etc/ssh/sshd_config
      echo "  AllowTCPForwarding no" >> /etc/ssh/sshd_config
      echo "  X11Forwarding no" >> /etc/ssh/sshd_config
      echo "  ForceCommand internal-sftp -u 002" >> /etc/ssh/sshd_config
      echo ""
    ;;

    4)
      echo ""
      echo "--------------------------------------------"
      echo "  INSTALANDO HERRAMIENTAS PARA COMPILACIÓN"
      echo "--------------------------------------------"
      echo ""
      sleep 2
      apt-get -y install linux-headers-$(uname -r) make gcc build-essential module-assistant git libsqlite3-dev libssl-dev
      m-a prepare
      echo ""
    ;;

    5)
      echo ""
      echo "--------------------------------------"
      echo "  INSTALANDO PAQUETES PARA VOLÚMENES"
      echo "--------------------------------------"
      echo ""
      sleep 2
      apt-get -y install hdparm
      apt-get -y install cifs-utils
      apt-get -y sshfs
      apt-get -y ecryptfs-utils
      apt-get -y install ntfs-3g ntfsprogs                # Para manejar sistemas de archivos NTFS
      apt-get -y install hfsplus hfsprogs hfsutils        # Para manejar sistemas de archivos HFS
      apt-get -y install libguestfs-tools                 # Para montar VHDs
      echo ""
    ;;

    6)
      echo ""
      echo "----------------------------------"
      echo "  INSTALANDO HERRAMIENTAS DE RED"
      echo "----------------------------------"
      echo ""
      sleep 2
      apt-get -y install whois
      apt-get -y nmap
      apt-get -y nbtscan
      apt-get -y mailutils
      apt-get -y wireless-tools
      apt-get -y wpasupplicant
      apt-get -y install arp-scan
      apt-get -y install tshark # WireShark para terminal
      echo ""
    ;;

    7)
      echo ""
      echo "---------------------------------"
      echo "  INSTALANDO OTRAS COSAS ÚTILES"
      echo "---------------------------------"
      echo ""
      sleep 2
      apt-get -y remove manpages
      apt-get -y install testdisk
      apt-get -y dialog
      apt-get -y hddtemp
      apt-get -y manpages-es
      apt-get -y mc
      apt-get -y nano
      apt-get -y members
      apt-get -y sysv-rc-conf
      apt-get -y zip
      apt-get -y unzip
      apt-get -y elinks
      apt-get -y python
      apt-get -y rsync
      apt-get -y install hardinfo
      apt-get -y install genisoimage
      echo ""
      
      echo ""
      echo "  Instalando herramientas para comprimir y descomprimir"
      echo ""
      apt-get -y install unace
      apt-get -y rar
      apt-get -y unrar
      apt-get -y unar
      apt-get -y p7zip-rar
      apt-get -y p7zip
      apt-get -y zip
      apt-get -y unzip 
    ;;

    8)
    ;;

    esac

done
