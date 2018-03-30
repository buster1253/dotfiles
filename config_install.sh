#!/bin/bash

#FLAGS
COMP_TYPE=0 # 0 = not set, 1 = Desktop, 2 = Laptop
I3_FLAG=false
I3_LOCATION=$HOME/.config/i3/

print_help() {
	echo "Config_install.sh command menu"
	echo
	echo "		-i3 			Generate i3 config."
	echo "		--i3 PATH		Generate i3 config at specified PATH"
	echo "		-h  --help 		Print this menu."
}

# Create i3 config

install() {
	echo "Installing"
	if [ $I3_FLAG == true ]; then
		i3_install
	fi
}

i3_install() {
	echo "I3 install"
	if [ $COMP_TYPE > 0 ]; then
		`cat $HOME/.config/i3/config.default > $I3_LOCATION/config`
		if [ $COMP_TYPE == 1 ]; then
			#Install for desktop
			`cat $I3_LOCATION/config.desktop >> $I3_LOCATION/config`
			echo "Desktop"
			exit
		elif [ $COMP_TYPE == 2 ]; then
			#Install for laptop
			echo "Laptop"
			exit
		fi
	else
		echo "Please specify installation type: -D (desktop), -L (Laptop)"
		exit
	fi
	#`cat $HOME/.config/i3/config.desktop > $HOME/.config/i3/config`
}

### MAIN ###

while [ "$1" != "" ]; do
	case $1 in
		-D )
			COMP_TYPE=1
			;;
		-L )
			COMP_TYPE=2
			;;
		-i3 )
			I3_FLAG=true
			;;
		--i3 )
			I3_FLAG=true
			shift
			I3_PATH="$1"
			echo "Installing I3 to: $I3_PATH"
			;;
		-h | --help )
			print_help
			;;
		* )
			echo "$1 not defined"
	esac
	shift
done
#for ARG in $@
#do
	#case $ARG in
		#-D )
			#COMP_TYPE=1
		#;;
		#-L )
			#COMP_TYPE=2
		#;;
		#-i3 )
			#I3_FLAG=true
		#;;
		#-i3=* )
			#I3_FLAG=true
		#-h | --help )
			#print_help
		#;;
	#esac
#done
install
