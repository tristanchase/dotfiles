#!/bin/bash

__black_16() 		{ printf "\e["${i}";2;%d;%d;%dm" 0x00 0x00 0x00; }
__blue_39()		{ printf "\e["${i}";2;%d;%d;%dm" 0x00 0x99 0xFF; }
__celeste() 		{ printf "\e["${i}";2;%d;%d;%dm" 0xB9 0xCE 0xB0; }
__green_41() 		{ printf "\e["${i}";2;%d;%d;%dm" 0x00 0xCC 0x33; }
__cyan_87() 		{ printf "\e["${i}";2;%d;%d;%dm" 0x33 0xFF 0xFF; }
__light_green_49() 	{ printf "\e["${i}";2;%d;%d;%dm" 0x00 0xFF 0x99; }
__magenta_201() 	{ printf "\e["${i}";2;%d;%d;%dm" 0xFF 0x00 0xFF; }
__orange_208() 		{ printf "\e["${i}";2;%d;%d;%dm" 0xFF 0x66 0x00; }
__red_196() 		{ printf "\e["${i}";2;%d;%d;%dm" 0xFF 0x00 0x00; }

i=""
_black="$(__black_16)"
_blue="$(__blue_39)"
_celeste="$(__celeste)"
_green="$(__green_41)"
_cyan="$(__cyan_87)"
_light_green="$(__light_green_49)"
_magenta="$(__magenta_201)"
_orange="$(__orange_208)"
_red="$(__red_196)"

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
fg_black="$(__black_16)"
fg_blue="$(__blue_39)"
fg_celeste="$(__celeste)"
fg_green="$(__green_41)"
fg_cyan="$(__cyan_87)"
fg_light_green="$(__light_green_49)"
fg_magenta="$(__magenta_201)"
fg_orange="$(__orange_208)"
fg_red="$(__red_196)"
light_green_fg="${fg_light_green}" # Leave these in place for legacy reasons
celeste_fg="${fg_celeste}"
orange_fg="${fg_orange}"
black_fg="${fg_black}"

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
bold_black="$(__black_16)"
bold_blue="$(__blue_39)"
bold_celeste="$(__celeste)"
bold_green="$(__green_41)"
bold_cyan="$(__cyan_87)"
bold_light_green="$(__light_green_49)"
bold_magenta="$(__magenta_201)"
bold_orange="$(__orange_208)"
bold_red="$(__red_196)"
light_green_bold="${bold_light_green}"
celeste_bold="${bold_celeste}"
orange_bold="${bold_orange}"
black_bold="${bold_black}"

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
ul_black="$(__black_16)"
ul_blue="$(__blue_39)"
ul_celeste="$(__celeste)"
ul_green="$(__green_41)"
ul_cyan="$(__cyan_87)"
ul_light_green="$(__light_green_49)"
ul_magenta="$(__magenta_201)"
ul_orange="$(__orange_208)"
ul_red="$(__red_196)"
light_green_ul="${ul_light_green}"
celeste_ul="${ul_celeste}"
orange_ul="${ul_orange}"
black_ul="${ul_black}"

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
bg_black="$(__black_16)"
bg_blue="$(__blue_39)"
bg_celeste="$(__celeste)"
bg_green="$(__green_41)"
bg_cyan="$(__cyan_87)"
bg_light_green="$(__light_green_49)"
bg_magenta="$(__magenta_201)"
bg_orange="$(__orange_208)"
bg_red="$(__red_196)"
light_green_bg="${bg_light_green}"
celeste_bg="${bg_celeste}"
orange_bg="${bg_orange}"
black_bg="${bg_black}"


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
