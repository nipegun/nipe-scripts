#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#------------------------------------------------------------------
#  Script de NiPeGun para poner a cero todos los logs de /var/log
#------------------------------------------------------------------
ColorVerde="\033[1;32m"
ColorAzul="\033[0;34m" 
FinColor="\033[0m"

echo ""
echo -e "${ColorVerde}Poniendo a cero todos los logs...${FinColor}"
echo ""

echo ""
echo -e "${ColorAzul}Borrando archivos sobrantes...${FinColor}"
echo ""
find /var/log/ -type f -name "*.gz" -print -exec rm {} \;
for ContExt in {0..100}
  do
    find /var/log/ -type f -name "*.$ContExt" -print -exec rm {} \;
    find /var/log/ -type f -name "*.$ContExt.log" -print -exec rm {} \;
    find /var/log/ -type f -name "*.old" -print -exec rm {} \;
  done

echo ""
echo -e "${ColorAzul}Poniendo a cero todos los logs de /var/log/...${FinColor}"
echo ""
find /var/log/ -type f -print -exec truncate -s 0 {} \;

echo ""
echo -e "${ColorAzul}Estado en el que quedaron los logs...${FinColor}"
echo ""
ls -n /var/log/
echo ""

