#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#-------------------------------------------------------------------------------
#  Script de NiPeGun para cambiar la contraseña del SuperUser en mumble-server
#-------------------------------------------------------------------------------

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
    echo -e "CambiarPasswordASuperUserEnMumble ${ColorArgumentos}[PasswordNuevo]${FinColor}"
    echo ""
    echo "Ejemplo:"
    echo ' CambiarPasswordASuperUserEnMumble 12345678'
    echo "------------------------------------------------------------------------------"
    echo ""
    exit $ArgsInsuficientes
  else
    /usr/sbin/murmurd -ini /etc/mumble-server.ini -supw $1
fi

