#!/bin/bash

ROFI_LINES=10
ROFI_LOCATION=3
ROFI_YOFFSET=27
ROFI_FONT="DejaVu Sans Ms 9"
ROFI_WIDTH=15
ROFI_LINE_MARGIN=5
ROFI_SEPARATOR="solid"
ROFI_BORDER_WIDTH=2

WLP_INTERFACE=$(ip a | grep -o 'wlp.*$' | cut -d ':' -f 1 | uniq)
ENP_INTERFACE=$(ip a | grep -o 'enp.*$' | cut -d ':' -f 1 | uniq)

# Fonction principale qui appel le premier menu et oriente vers les autres fonctions selon le choix
function main {

				MENU=$(echo -e "\nProfiles\nInterfaces\nKill Wi-Fi Con.\n\nQuit" | rofi -dmenu -p "Welcome on Wi-Fi menu" -hide-scrollbar -lines "$ROFI_LINES" -location "$ROFI_LOCATION" -yoffset "$ROFI_YOFFSET" -font "$ROFI_FONT" -width "$ROFI_WIDTH" -line-margin "$ROFI_LINE_MARGIN" -separator-style "$ROFI_SEPARATOR" -bw "$ROFI_BORDER_WIDTH")
				
				if [ "$MENU" == "Interfaces" ]; then
								interfaces	
				elif [ "$MENU" == "Profiles" ]; then
								profiles	
				elif [ "$MENU" == "Kill Wi-Fi Con." ]; then
								kill_connection											
				else
								exit
				fi
}


# fonction appeler par le menu en allant dans "Interfaces", permet de sélectionner une des interfaces et renvoie vers une autre fonction.
function interfaces {
				
				INTERFACES=$(echo -e "\n$WLP_INTERFACE\n$ENP_INTERFACE\n\n←" | uniq | rofi -dmenu -p "Interfaces" -hide-scrollbar -lines "$ROFI_LINES" -location "$ROFI_LOCATION" -yoffset "$ROFI_YOFFSET" -font "$ROFI_FONT" -width "$ROFI_WIDTH" -line-margin "$ROFI_LINE_MARGIN" -separator-style "$ROFI_SEPARATOR" -bw "$ROFI_BORDER_WIDTH")

				if [ "$INTERFACES" == "$WLP_INTERFACE" ]; then
								updown_interface $WLP_INTERFACE
				elif [ "$INTERFACES" == "$ENP_INTERFACE" ]; then
								updown_interface $ENP_INTERFACE
				elif [ "$INTERFACES" == "←" ]; then
								main
				fi
}


# dernière fonction de la fonctionnalité interface. Permet de Up ou de Down une interface réseau.



# fonction appeler par le menu en allant dans "Profiles", permet de sélectionner un profil et renvoie vers une autre fonction.
function profiles {
				
				LIST_PROFILE=$(ls /etc/netctl | grep -o 'wlp.*$' | cut -d '-' -f 2)


				PROFILES=$(echo -e "\n$LIST_PROFILE\n\nNew Profiles\n\n←" | rofi -dmenu -p "Profil" -lines "$ROFI_LINES" -hide-scrollbar -location "$ROFI_LOCATION" -yoffset "$ROFI_YOFFSET" -font "$ROFI_FONT" -width "$ROFI_WIDTH" -line-margin "$ROFI_LINE_MARGIN" -separator-style "$ROFI_SEPARATOR" -bw "$ROFI_BORDER_WIDTH")
				
				if [ -z "$PROFILES" ]; then
								main
				elif [ "$PROFILES" == "←" ]; then
								main
				elif [ "$PROFILES" == "New Profiles" ]; then
								new_profile
				else
								startstop_profile "$PROFILES"
				fi

}



############################
####function with action####
############################


function new_profile {
				
				PASSWORD=$(zenity --title="Wi-Fi Menu" --password)
				
				PROFILE_DESCRIPTION="Automatically generated profile by Menu-Wifi-Netctl.sh"
				PROFILE_CONNECTION="wireless"
				PROFILE_ESSID=$(zenity --entry --text="Profile's SSID:")
				PROFILE_SECURITY=$(zenity --entry --text="Security: (wpa/wep)")
				PROFILE_IP=$(zenity --entry --text="Obtaining IP method: (dhcp,static,no)")
				PROFILE_KEY=$(zenity --entry --text="Wi-Fi Password: (must be 8 to 63 characters)")
				
				ENCRYPT_KEY=$(wpa_passphrase $PROFILE_ESSID "$PROFILE_KEY" | sed '/#psk/d' | grep psk | cut -d '=' -f 2 )

				if [ -z "$PROFILE_ESSID" ]; then
								zenity --error --text='Need SSID'
								profiles
				else
								NEW_PROFILE_NAME="$WLP_INTERFACE-$PROFILE_ESSID"
								touch /tmp/$NEW_PROFILE_NAME
								echo "Description='$PROFILE_DESCRIPTION'" >> /tmp/$NEW_PROFILE_NAME
								echo "Interface=$WLP_INTERFACE" >> /tmp/$NEW_PROFILE_NAME
								echo "Connection=$PROFILE_CONNECTION" >> /tmp/$NEW_PROFILE_NAME
								echo "Security=$PROFILE_SECURITY" >> /tmp/$NEW_PROFILE_NAME
								echo "ESSID=$PROFILE_ESSID" >> /tmp/$NEW_PROFILE_NAME
								echo "IP=$PROFILE_IP" >> /tmp/$NEW_PROFILE_NAME
								echo "Key=\\\"$ENCRYPT_KEY" >> /tmp/$NEW_PROFILE_NAME
								echo "$PASSWORD" | sudo -S mv /tmp/$NEW_PROFILE_NAME /etc/netctl/$NEW_PROFILE_NAME
				fi
}

function startstop_profile {
			
				STARTSTOP=$(echo -e "\nSTART\nMODIFY\n\n←\nmain" | rofi -dmenu -p "$1" -hide-scrollbar -lines "$ROFI_LINES" -location "$ROFI_LOCATION" -yoffset "$ROFI_YOFFSET" -font "$ROFI_FONT" -width "$ROFI_WIDTH" -line-margin "$ROFI_LINE_MARGIN" -separator-style "$ROFI_SEPARATOR" -bw "$ROFI_BORDER_WIDTH")
				
				if [ "$STARTSTOP" == "START" ]; then
								PASSWORD=$(zenity --title="Wi-Fi Menu" --password)
								echo "$PASSWORD" | sudo -S netctl stop-all
								echo "$PASSWORD" | sudo -S ip link set $WLP_INTERFACE down
								echo "$PASSWORD" | sudo -S netctl start "$WLP_INTERFACE-$1" 
				elif [ "$STARTSTOP" == "MODIFY" ]; then
								modify_profile $1
				elif [ "$STARTSTOP" == "←" ]; then
								profiles
				elif [ "$STARTSTOP" == "main" ]; then
								main
				fi 

}

function modify_profile {

				FILE_TO_MODIFY=$WLP_INTERFACE-$1
				
				MODIFY=$(echo -e "\nInterface\nSecurity (wpa,wep)\nESSID\nIP (dhcp,static,no)\nKey\n\n←\nmain" |  rofi -dmenu -p "Modification on $FILE_TO_MODIFY" -lines "$ROFI_LINES" -hide-scrollbar -location "$ROFI_LOCATION" -yoffset "$ROFI_YOFFSET" -font "$ROFI_FONT" -width "$ROFI_WIDTH" -line-margin "$ROFI_LINE_MARGIN" -separator-style "$ROFI_SEPARATOR" -bw "$ROFI_BORDER_WIDTH")	

				if [ "$MODIFY" == "Interface" ]; then
				
								INTERFACE=$(zenity --entry --text='New Interface Name:')
								PASSWORD=$(zenity --title="Wi-Fi Menu" --password)
				
								echo "$PASSWORD" | sudo -S sed -i -e "s/Interface=.*/Interface=$INTERFACE/g" /etc/netctl/$FILE_TO_MODIFY
								modify_profile $1
				
				elif [ "$MODIFY" == "Security (wpa,wep)" ]; then
								SECURITY=$(zenity --entry --text='New Security Method: (wpa,wep)')
								PASSWORD=$(zenity --title="menu-wifi-netctl.sh" --password)
				
								echo "$PASSWORD" | sudo -S sed -i -e "s/Security=.*/Security=$SECURITY/g" /etc/netctl/$FILE_TO_MODIFY
								modify_profile $1
				
				elif [ "$MODIFY" == "ESSID" ]; then
								ESSID=$(zenity --entry --text='New ESSID:')
								PASSWORD=$(zenity --title="menu-wifi-netctl.sh" --password)
				
								echo "$PASSWORD" | sudo -S sed -i -e "s/ESSID=.*/ESSID=$ESSID/g" /etc/netctl/$FILE_TO_MODIFY
								modify_profile $1
				
				elif [ "$MODIFY" == "IP (dhcp,static,no)" ]; then
								IP=$(zenity --entry --text='New IP attribution method: (dhcp,static,no)')
								PASSWORD=$(zenity --title="menu-wifi-netctl.sh" --password)
				
								echo "$PASSWORD" | sudo -S sed -i -e "s/IP=.*/IP=$IP/g" /etc/netctl/$FILE_TO_MODIFY
								modify_profile $1
				
				elif [ "$MODIFY" == "Key" ]; then

								KEY=$(zenity --entry --text='Wi-Fi Key:')
								ENCRYPT_KEY=$(wpa_passphrase $1 "$KEY" | sed '/#psk/d' | grep psk | cut -d '=' -f 2)
								PASSWORD=$(zenity --title="menu-wifi-netctl.sh" --password)
				
								echo "$PASSWORD" | sudo -S sed -i -e "s/Key=.*/Key=\\\"$ENCRYPT_KEY/g" /etc/netctl/$FILE_TO_MODIFY
								modify_profile $1
				
				elif [ "$MODIFY" == "←" ]; then
								startstop_profile $1
				
				elif [ "$MODIFY" == "main" ]; then
								main
				else
								profiles
				fi
}

function updown_interface {
				
				UPDOWN=$(echo -e "\nUP\nDOWN\n\n←\nmain" | rofi -dmenu -p "$1" -lines "$ROFI_LINES" -hide-scrollbar -location "$ROFI_LOCATION" -yoffset "$ROFI_YOFFSET" -font "$ROFI_FONT" -width "$ROFI_WIDTH" -line-margin "$ROFI_LINE_MARGIN" -separator-style "$ROFI_SEPARATOR" -bw "$ROFI_BORDER_WIDTH")

				if [ "$UPDOWN" == "UP" ]; then
								zenity --title="Wi-Fi Menu" --password | sudo -S ip link set $1 up
				elif [ "$UPDOWN" == "DOWN" ]; then
								zenity --title="Wi-Fi Menu" --password | sudo -S ip link set $1 down 
				elif [ "$UPDOWN" == "←" ]; then
								interfaces
				elif [ "$UPDOWN" == "main" ]; then
								main
				fi

}

# fonction qui stop toute connection wifi avec netctl || sûrement bug à corriger quand le profil est un profil ethernet
function kill_connection {

				ACTUAL_PROFIL=$(iwgetid -r)
				WLP_IS_UP=$(ip addr show wlp59s0 | grep -o 'state.*.group' | cut -d ' ' -f 2)

				if [ -z "$ACTUAL_PROFIL" ]; then
								main
				else
								if [ "$WLP_IS_UP" == "UP" ]; then
												zenity --title="Wi-Fi Menu" --password | sudo -S netctl stop-all 
												exit
								else
												main
												echo "is already down"
								fi
				fi
}


main
