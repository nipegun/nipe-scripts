#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#----------------------------------------------------
#  Script de NiPeGun para sincronizar los d-scripts
#----------------------------------------------------

ColorRojo='\033[1;31m'
ColorVerde='\033[1;32m'
FinColor='\033[0m'

# Comprobar si el paquete wget está instalado. Si no lo está, instalarlo.
if [[ $(dpkg-query -s wget 2>/dev/null | grep installed) == "" ]]; then
    echo ""
    echo "wget no está instalado. Iniciando su instalación..."
    echo ""
    apt-get -y update
    apt-get -y install wget
    echo ""
fi

# Comprobar si hay conexión a Internet antes de sincronizar los d-scripts
wget -q --tries=10 --timeout=20 --spider https://github.com
  if [[ $? -eq 0 ]]; then
    echo ""
    echo "---------------------------------------------------------"
    echo -e "  ${ColorVerde}Sincronizando los d-scripts con las últimas versiones${FinColor}"
    echo -e "  ${ColorVerde} y descargando nuevos d-scripts si es que existen...${FinColor}"
    echo "---------------------------------------------------------"
    echo ""
    rm /root/scripts/d-scripts -R 2> /dev/null
    mkdir /root/scripts 2> /dev/null
    cd /root/scripts
    git clone --depth=1 https://github.com/nipegun/d-scripts
    mkdir -p /root/scripts/d-scripts/Alias/
    rm /root/scripts/d-scripts/.git -R 2> /dev/null
    find /root/scripts/d-scripts/ -type f -iname "*.sh" -exec chmod +x {} \;
    /root/scripts/d-scripts/DScripts-CrearAlias.sh
    find /root/scripts/d-scripts/Alias -type f -exec chmod +x {} \;
    
    echo ""
    echo "-----------------------------------------"
    echo -e "  ${ColorVerde}d-scripts sincronizados correctamente${FinColor}"
    echo "-----------------------------------------"
    echo ""
  else
    echo ""
    echo "---------------------------------------------------------------------------------------------------"
    echo -e "${ColorRojo}No se pudo iniciar la sincronización de los d-scripts porque no se detectó conexión a Internet.${FinColor}"
    echo "---------------------------------------------------------------------------------------------------"
    echo ""
  fi

