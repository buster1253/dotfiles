#!/bin/bash

#FLAGS
COMP_TYPE=0 # 0 = not set, 1 = Desktop, 2 = Laptop
COMP_TYPES=("desktop" "laptop");
I3_FLAG=false
I3_PATH=$HOME.config/i3/ #Default directory

I3SR_FLAG=false
I3SR_PATH=$HOME.config/i3status_rust/

print_help() {
	u="_"
	echo "config_install.sh"
	printf "%.0s=" {1..10}
	echo -n "Options"
	printf "%.0s=" {1..10}
	echo -e "\\n	--i3 [path]_____________Generate i3 config at specified path. Default path=\$HOME/.config/i3/config"
	echo "	--i3status-rust [path]_________i3status_rust"
	echo "	-h  --help			Print this menu."
}

# Create i3 config

install() {
	if [ $COMP_TYPE == 0 ]; then
		echo "Specify type: -D/L desk-&laptop"
	fi
	echo "installing"
	if [ $I3_FLAG == true ]; then
		i3_install
	fi
	if [ $I3SR_FLAG == true ]; then
		i3status_rust_install
	fi
}

i3_install() {
	echo "installing i3 to: $I3_PATH"
	cat "${I3_PATH}config.default" "${I3_PATH}config.${COMP_TYPES[COMP_TYPE - 1]}" > "${I3_PATH}config"
}

## i3status_rust 

i3status_rust_install() {
	echo "installing i3status_rust to: $I3SR_PATH"
	cat "${I3SR_PATH}config.toml.${COMP_TYPES[$COMP_TYPE - 1]}" > "${I3SR_PATH}config.toml"
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
		-i | --i3 )
			I3_FLAG=true
			shift
			if [ "$1" == "" ]; then
				continue
			fi
			if [ "${1: 0:1}" == "-" ]; then
				echo "no path"
				continue
			fi
			echo "$1"
			echo "${1:0:1}"
			I3_PATH="$1"
			;;
		-s | --i3status-rust )
			#i3status_rust
			I3SR_FLAG=true
			shift
			if [ "$1" == "" ]; then
				continue
			fi
			if [ "${1: 0:1}" == "-" ]; then
				echo "no path"
				continue
			fi
			I3SR_PATH="$1"
			;;
		-h | --help )
			print_help
			;;
		* )
			echo "$1 not defined"
	esac
	shift
done
install
