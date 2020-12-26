#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#---------------------------------------------------------------------
#  Script de NiPeGun para instalar y configurar MLDonkey en Debian 9
#---------------------------------------------------------------------

CantArgsEsperados=1
ArgsInsuficientes=65

ColorAdvertencia='\033[1;31m'
ColorArgumentos='\033[1;32m'
FinColor='\033[0m'

if [ $# -ne $CantArgsEsperados ]
  then
    echo ""
    echo "------------------------------------------------------------------------------"
    echo -e "${ColorAdvertencia}Mal uso del script.${FinColor} El uso correcto sería:"
    echo ""
    echo -e "InstalarYConfigurarMLDonkey ${ColorArgumentos}[IPDesdeLaQueSeVaAControlar]${FinColor}"
    echo ""
    echo "Ejemplo:"
    echo ' InstalarYConfigurarMLDonkey 192.168.0.51'
    echo "------------------------------------------------------------------------------"
    echo ""
    exit $ArgsInsuficientes
  else
    echo ""
    echo "  Instalando el paquete mldonkey-server..."
    echo ""
    apt-get update
    apt-get -y install mldonkey-server
    echo ""
    echo "  Deteninendo el servicio..."
    echo ""
    service mldonkey-server stop
    echo ""
    echo "  Realizando cambios en la configuración..."
    echo ""
    cp /var/lib/mldonkey/downloads.ini /var/lib/mldonkey/downloads.ini.bak
    sed -i -e 's| allowed_ips = \[| allowed_ips = ["127.0.0.1"; "'"$1"'";]|g' /var/lib/mldonkey/downloads.ini
    sed -i -e 's|  "127.0.0.1";]| |g' /var/lib/mldonkey/downloads.ini
    sed -i -e 's| nolimit_ips = \[| nolimit_ips = ["127.0.0.1";]|g' /var/lib/mldonkey/downloads.ini
    echo ""
    echo "  Re-arrancando el servicio..."
    echo ""
    service mldonkey-server start
    echo ""
    echo "  Ejecución del script, finalizada."
    echo "  Ya deberías ser capaz de controlar MLDonkey desde la IP $1."
    echo ""
fi
