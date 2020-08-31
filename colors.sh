#!/bin/bash

__light_green() { printf "\e["${i}";2;%d;%d;%dm" 0x00 0xFF 0x99; }
__celeste() { printf "\e["${i}";2;%d;%d;%dm" 0xB9 0xCE 0xB0; }
__orange() { printf "\e["${i}";2;%d;%d;%dm" 0xFF 0x66 0x00; }
__black() { printf "\e["${i}";2;%d;%d;%dm" 0x00 0x00 0x00; }

#Regular text
BLK="\e[0;30m"
RED="\e[0;31m"
GRN="\e[0;32m"
YEL="\e[0;33m"
BLU="\e[0;34m"
MAG="\e[0;35m"
CYN="\e[0;36m"
WHT="\e[0;37m"
i="0;38"
light_green_fg="$(__light_green)"
celeste_fg="$(__celeste)"
orange_fg="$(__orange)"
black_fg="$(__black)"

#Regular bold text
BBLK="\e[1;30m"
BRED="\e[1;31m"
BGRN="\e[1;32m"
BYEL="\e[1;33m"
BBLU="\e[1;34m"
BMAG="\e[1;35m"
BCYN="\e[1;36m"
BWHT="\e[1;37m"
i="1;38"
light_green_bold="$(__light_green)"
celeste_bold="$(__celeste)"
orange_bold="$(__orange)"
black_bold="$(__black)"

#Regular underline text
UBLK="\e[4;30m"
URED="\e[4;31m"
UGRN="\e[4;32m"
UYEL="\e[4;33m"
UBLU="\e[4;34m"
UMAG="\e[4;35m"
UCYN="\e[4;36m"
UWHT="\e[4;37m"
i="4;38"
light_green_ul="$(__light_green)"
celeste_ul="$(__celeste)"
orange_ul="$(__orange)"
black_ul="$(__black)"

#Regular background
BLKB="\e[40m"
REDB="\e[41m"
GRNB="\e[42m"
YELB="\e[43m"
BLUB="\e[44m"
MAGB="\e[45m"
CYNB="\e[46m"
WHTB="\e[47m"
i="48"
light_green_bg="$(__light_green)"
celeste_bg="$(__celeste)"
orange_bg="$(__orange)"
black_bg="$(__black)"


#High intensty background
BLKHB="\e[0;100m"
REDHB="\e[0;101m"
GRNHB="\e[0;102m"
YELHB="\e[0;103m"
BLUHB="\e[0;104m"
MAGHB="\e[0;105m"
CYNHB="\e[0;106m"
WHTHB="\e[0;107m"

#High intensty text
HBLK="\e[0;90m"
HRED="\e[0;91m"
HGRN="\e[0;92m"
HYEL="\e[0;93m"
HBLU="\e[0;94m"
HMAG="\e[0;95m"
HCYN="\e[0;96m"
HWHT="\e[0;97m"

#Bold high intensity text
BHBLK="\e[1;90m"
BHRED="\e[1;91m"
BHGRN="\e[1;92m"
BHYEL="\e[1;93m"
BHBLU="\e[1;94m"
BHMAG="\e[1;95m"
BHCYN="\e[1;96m"
BHWHT="\e[1;97m"

#Reset
reset="\e[0m"
reset_colors="\e[0m"
