#!/bin/bash
mainLoop=true

#Main Menu Loop
while [[ $mainLoop == true ]]
do
    clear
    goOn=true
    echo "<-> Para empezar, dime el grupo que le vas a dar a tu usuario Guest. <->"
    echo "*Ten cuidado que sea el nombre con minusculas/mayusculas correcto o no funcionara."
    echo "** Tienes que crear el grupo tú para poder usar el script."
    read -p "Input: " guestGroup

    #Comprovar si el grupo existe
    if [ -z $(getent group $guestGroup)]
    then
        clear
        echo "<!> El grupo introducido no existe! Pulsa para volver a intentar. <!>"
        read void
        goOn=false
    fi


    #Menu de ediciones
    while [[ $goOn == true ]]
    do
        clear
        echo "<-> Perfecto! El grupo existe, bienvenido al menú. <->"
        echo "-/-----------------------------\-"
        echo " |   1) Bloquear Terminales    |"
        echo " | 2) Bloquear apps peligrosas |"
        echo " |  3) Script de inicio Guest  |"
        echo " |      4) Hacerlo Todo        |"
        echo " |  5) Comprobar Log Script    |"
        echo "-\-----------------------------/-"
        read -p "Input: " userChoice
        clear

        #Check user input
        #Choice 1
        if [[ $userChoice == 1 ]] || [[ $userChoice == 4 ]]
        then
            goOn=false
            mainLoop=false
            echo "--------------------------------------------"

            #Terminals
            echo "<-> Desactivando terminales. <->"
            setfacl -m group:$guestGroup:000 /usr/share/applications/lxterminal.desktop
            setfacl -m group:$guestGroup:000 /usr/share/applications/mlterm.desktop
            setfacl -m group:$guestGroup:000 /usr/share/applications/xiterm+thai.desktop
            setfacl -m group:$guestGroup:000 /usr/share/applications/debian-uxterm.desktop
            setfacl -m group:$guestGroup:000 /usr/share/applications/debian-xterm.desktop
            setfacl -m group:$guestGroup:000 /usr/share/applications/lxde-x-terminal-emulator.desktop
            setfacl -m group:$guestGroup:r-- /usr/bin/x-terminal-emulator
            setfacl -m group:$guestGroup:r-- /usr/bin/x-terminal-emulator
            setfacl -m group:$guestGroup:r-- /usr/bin/lxterm
            setfacl -m group:$guestGroup:r-- /usr/bin/lxterminal
            setfacl -m group:$guestGroup:r-- /usr/bin/mlterm
            setfacl -m group:$guestGroup:r-- /usr/bin/xiterm+thai
            setfacl -m group:$guestGroup:r-- /usr/bin/uxterm
            setfacl -m group:$guestGroup:r-- /usr/bin/xterm
            echo "<!> Terminales Desactivados. <!>"
            echo "--------------------------------------------"
        fi

        #Choice 2
        if [[ $userChoice == 2 ]] || [[ $userChoice == 4 ]]
        then
            goOn=false
            mainLoop=false
            echo "--------------------------------------------"
            
            #Dangerous apps
            echo "<-> Desactivando apps 'peligrosas'. <->"
            setfacl -m group:$guestGroup:r-- /usr/bin/consolehelper-gtk
            setfacl -m group:$guestGroup:r-- /usr/bin/ibus
            setfacl -m group:$guestGroup:r-- /usr/bin/parcellite
            setfacl -m group:$guestGroup:r-- /usr/bin/ibus-daemon
            setfacl -m group:$guestGroup:r-- /usr/bin/connman
            setfacl -m group:$guestGroup:r-- /usr/bin/connmanctl
            setfacl -m group:$guestGroup:r-- /usr/bin/connman-gtk
            setfacl -m group:$guestGroup:r-- /usr/bin/lxtask
            setfacl -m group:$guestGroup:r-- /usr/bin/goldendict
            setfacl -m group:$guestGroup:r-- /usr/bin/fcitx
            setfacl -m group:$guestGroup:r-- /usr/bin/fcitx5
            setfacl -m group:$guestGroup:r-- /usr/bin/usermount
            setfacl -m group:$guestGroup:r-- /usr/bin/bfiff
            setfacl -m group:$guestGroup:r-- /usr/bin/deluge
            setfacl -m group:$guestGroup:r-- /usr/bin/synaptic-pkexec
            setfacl -m group:$guestGroup:r-- /usr/bin/xconsole
            setfacl -m group:$guestGroup:r-- /usr/bin/xload
            setfacl -m group:$guestGroup:r-- /usr/bin/pstree
            setfacl -m group:$guestGroup:r-- /usr/bin/kbd-layout-viewer5
            setfacl -m group:$guestGroup:r-- /usr/bin/gucharmap
            setfacl -m group:$guestGroup:r-- /usr/bin/xarchiver
            setfacl -m group:$guestGroup:r-- /usr/bin/gnome-disks
            setfacl -m group:$guestGroup:r-- /usr/bin/users
            setfacl -m group:$guestGroup:r-- /usr/bin/obconf
            setfacl -m group:$guestGroup:r-- /usr/bin/kasumi
            setfacl -m group:$guestGroup:r-- /usr/bin/lxrandr
            setfacl -m group:$guestGroup:r-- /usr/share/applications/menulibre.desktop
            echo "<!> Apps peligrosas desactivadas. <!>"
            echo "--------------------------------------------"
        fi

        #Choice 3
        if [[ $userChoice == 3 ]] || [[ $userChoice == 4 ]]
        then
            goOn=false
            mainLoop=false
            echo "--------------------------------------------"
            cd /etc/

            #Check if guest-session folder exists
            if [ -z $(ls | grep guest-session) ]
            then
                echo "<!> La carpeta guest-session no existe, se ha creado en /etc/ <!>"
                mkdir guest-session
            fi

            cd /etc/guest-session

            #Creates file and stuff inside
            touch prefs.sh 
            echo -n "/usr/sbin/usermod -G $guestGroup $" > prefs.sh
            echo -n "USER" >> prefs.sh

            #Using cat with the file
            echo "<!> Creado archivo prefs.sh en guest-session. <!>"
            echo "Contenido:"
            cat prefs.sh
            echo ""
            echo "--------------------------------------------"
        fi

        #Choice 5
        if [[ $userChoice == 5 ]] || [[ $userChoice == 4 ]]
        then
            goOn=false
            mainLoop=false
            echo "--------------------------------------------"

			cd /etc/guest-session
			#Check if script file exists
			if [ -z $(ls | grep logout.sh) ]
			then
				cd /home/super/Desktop
				pwd
				echo "<!> El script no existe, he creado el script y creado el servicio en systemctl. <!>"
				cp logout.sh /etc/guest-session/logout.sh
				cp script.service /etc/systemd/system/script.service
				systemctl enable script.service
			
				#Mostrar archivos
				echo "============================="
				echo "/etc/guest-session/logout.sh:"
				cat logout.sh
				echo "============================="
				echo "/etc/systemd/system/script.service"
				cat /etc/systemd/system/script.service
				echo "============================="
				else
				echo "<!> El script existe. Mostrando contenido... <!>"
				echo "============================="
				echo "/etc/guest-session/logout.sh:"
				cat logout.sh
				echo "============================="
				echo "/etc/systemd/system/script.service"
				cat /etc/systemd/system/script.service
				echo "============================="
			fi
			echo "--------------------------------------------"
	fi
    done
done
echo "El script ha acabado."
