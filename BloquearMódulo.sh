#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#--------------------------------------------------------
#  Script de NiPeGun para bloquear un módulo específico
#--------------------------------------------------------

CantArgsEsperados=3
ArgsInsuficientes=65

ColorRojo='\033[1;31m'
ColorVerde='\033[1;32m'
FinColor='\033[0m'

if [ $# -ne $CantArgsEsperados ]
  then
    echo ""
    echo "------------------------------------------------------------------------------"
    echo -e "${ColorRojo}Mal uso del script.${FinColor} El uso correcto sería:"
    echo ""
    echo -e "$0 ${ColorVerde}[NombreDelMódulo]${FinColor}"
    echo ""
    echo "Ejemplo:"
    echo " $0 igb"
    echo "------------------------------------------------------------------------------"
    echo ""
    exit $ArgsInsuficientes
  else
    echo ""
    echo "  Estás a punto de bloquear el módulo $1"
    echo ""
    echo "  Lo siguientes módulos dependen de él"
    echo ""
    modinfo -F depends $1
    echo ""
    echo "  No es bueno bloquear módulos que sirvan a otros módulos"
    echo "blacklist $1" >> /etc/modprobe.d/$1.conf
    update-initramfs -u
    echo ""
fi

