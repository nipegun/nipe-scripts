#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#------------------------------------------------------------------
#  Script de NiPeGun para instalar eMule como demonio en Debian 9
#------------------------------------------------------------------

echo ""
echo "Instalando el paquete amule-daemon..."
echo ""
apt-get -y install amule-daemon

echo ""
echo "Agregando el usuario debian-amule..."
echo ""
adduser debian-amule

echo ""
echo "Corriendo el comando amuled por primera vez para el usuario debian-amule..."
echo ""
runuser -l debian-amule -c 'amuled'

echo ""
echo "Deteniendo el servicio amule-daemon..."
echo ""
service amule-daemon stop

echo ""
echo "Realizando cambios en la configuración..."
echo ""

runuser -l debian-amule -c 'amuleweb --write-config --host=localhost --password=password --admin-pass=adminpassword'
AdminPassword=$(echo -n adminpassword | md5sum | cut -d ' ' -f 1)
sed -i -e 's|AcceptExternalConnections=0|AcceptExternalConnections=1|g' /home/debian-emule/.aMule/amule.conf
sed -i -e 's|ECPassword=|ECPassword=$AdminPassword|g' /home/debian-amule/.aMule/amule.conf
sed -i '/WebServer]/{n;s/.*/Enabled=1/}' /home/debian-amule/.aMule/amule.conf
sed -i -e 's|^Password=|Password=5f4dcc3b5aa765d61d8327deb882cf99|g' /home/debian-amule/.aMule/amule.conf
sed -i -e 's|AMULED_USER=""|AMULED_USER="debian-amule"|g' /etc/default/amule-daemon

echo ""
echo "Iniciando el servicio amule-daemon..."
echo ""
service amule-daemon start

#echo ""
#echo "Agregando el usuario al grupo amule-daemon..."
#echo ""
#usermod -a -G debian-amule debian-amule

#bajar el IPFilter desde aqui:
#https://89f8c187-a-62cb3a1a-s-sites.googlegroups.com/site/ircemulespanish/descargas-2/ipfilter.zip

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
