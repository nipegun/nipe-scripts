#!/bin/bash

# Pongo a disposición pública este script bajo el término de "software de dominio público".
# Puedes hacer lo que quieras con él porque es libre de verdad; no libre con condiciones como las licencias GNU y otras patrañas similares.
# Si se te llena la boca hablando de libertad entonces hazlo realmente libre.
# No tienes que aceptar ningún tipo de términos de uso o licencia para utilizarlo o modificarlo porque va sin CopyLeft.

#---------------------------------------------------------------------
#  SCRIPT DE NIPEGUN PARA AGREGAR USUARIOS NUEVOS SIN SHELL A DEBIAN
#---------------------------------------------------------------------

EXPECTED_ARGS=1
E_BADARGS=65

if [ $# -ne $EXPECTED_ARGS ]
  then
    echo ""
    echo "------------------------------------------------------------------"
    echo "Mal uso del script."
    echo ""
    echo "El uso correcto sería: $0 nombredeusuario"
    echo ""
    echo "Ejemplo:"
    echo "$0 pepe"
    echo "------------------------------------------------------------------"
    echo ""
    exit $E_BADARGS
  else
    cmd=(dialog --checklist "Opciones del script:" 22 76 16)
    options=(1 "Crear el usuario" on
             2 "Crear la carpeta del usuario con permisos estándar usuario" on
             3 "Denegar el acceso a la carpeta de usuario a otros usuarios" off
             4 "Compartir la carpeta de usuario mediante Samba" off
             5 "Otras opciones" off)
    choices=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    for choice in $choices
    do
      case $choice in
        1)
          echo ""
          echo "---------------------"
          echo " CREANDO EL USUARIO"
          echo "---------------------"
          echo ""
          useradd -d /home/$1/ -s /bin/false $1
        ;;

        2)
          echo ""
          echo "-------------------------------------------------------"
          echo " CREANDO LA CARPETA DEL USUARIO CON PERMISOS ESTÁNDAR"
          echo "-------------------------------------------------------"
          echo ""
          mkdir /home/$1/
          chown $1:$1 /home/$1/ -R
          find /home/$1 -type d -print0 | xargs -0 chmod 0775
          echo "hacks4geeks rules da net" > /home/$1/$1
          find /home/$1 -type f -print0 | xargs -0 chmod 0664
        ;;

        3)
          echo ""
          echo "----------------------------------------------------------------------"
          echo "  DENEGANDO EL ACCESO A LA CARPETA /home/$1 A LOS OTROS USUARIOS"
          echo "----------------------------------------------------------------------"
          echo ""
          find /home/$1 -type d -print0 | xargs -0 chmod 0750
          echo "hacks4geeks rules da net" > /home/$1/$1
          find /home/$1 -type f -print0 | xargs -0 chmod 0664
        ;;
    
        4)
          echo ""
          echo "------------------------------------------------------------"
          echo "  CREANDO LA COMPARTICIÓN SAMBA PARA LA CARPETA DE USUARIO"
          echo "------------------------------------------------------------"
          echo ""
          echo "[$1]" >> /etc/samba/smb.conf
          echo "  path = /home/$1/" >> /etc/samba/smb.conf
          echo "  comment = Carpeta del usuario $1" >> /etc/samba/smb.conf
          echo "  browsable = yes" >> /etc/samba/smb.conf
          echo "  read only = no" >> /etc/samba/smb.conf
          echo "  valid users = $1" >> /etc/samba/smb.conf
          echo ""
          echo "  AHORA DEBERÁS INGRESAR 2 VECES LA NUEVA CONTRASEÑA SAMBA PARA EL USUARIO $1."
          echo "  PUEDE SER DISTINTA A LA DE LA PROPIA CUENTA DE USUARIO PERO SI PONES UNA"
          echo "  DISTINTA, CUANDO TE CONECTES A LA CARPETA COMPARTIDA, ACUÉRDATE DE UTILIZAR"
          echo "  LA CONTRASEÑA QUE PONGAS AHORA Y NO LA DE LA CUENTA DE USUARIO."
          echo ""
          smbpasswd -a $1
        ;;

        5)
       
        ;;

      esac

    done

fi
