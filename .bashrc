#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls -l --color=auto'
alias less='less -R'
alias clc='clear'
alias qq='exit'
alias aursearch='aurget -Ss'
alias aurinst='aurget -Sy --deps --noedit --noconfirm'
alias aurupgr='aurget -Syu --deps --noedit --noconfirm'
alias ksp='$STEAM/Kerbal\ Space\ Program/KSP.x86_64'
alias cd..='cd ..'
alias pamcan='pacman'
alias upgrade='sudo pacman -Syu; aurupgr'
alias update='upgrade'
alias tree='tree -C'

export EDITOR=vim visudo
export STEAM=$HOME/.local/share/Steam/SteamApps/common
export PATH="$HOME/scripts:$HOME/.bin:$PATH"

#if [[ $? -ne 0 ]]; then
#	PS1="┌\e[1;31m[\u@\h \$]\e[0m\n├\W\n└─(\e[1;31m✗\e[0m)\$>"
#else
#	PS1="┌\e[1;32m[\u@\h \$]\e[0m\n├\W\n└─(\e[1;32m✓\e[0m)\$>"
#fi

battery_status()
{
        BATTERY=/sys/class/power_supply/BAT1
 
        CHARGE=`cat $BATTERY/capacity`
        BATSTATE=`cat $BATTERY/status`
        # Colors for humans
        NON='\033[00m'
        BLD='\033[01m'
        RED='\033[01;31m'
        GRN='\033[01;32m'
        YEL='\033[01;33m'
 
        COLOUR="$RED"
 
        case "${BATSTATE}" in
           'Charged')
           BATSTT="$BLD=$NON"
           ;;
           'Charging')
           BATSTT="$BLD+$NON"
           ;;
           'Discharging')
           BATSTT="$BLD-$NON"
           ;;
        esac
 
        # prevent a charge of more than 100% displaying
        if [ "$CHARGE" -gt "99" ]
        then
           CHARGE=100
        fi
 
        # prevent an error if the battery is not in the laptop (e.g. you have two and take out the primary)
        STATE=`cat $BATTERY/present`
         if [ "$STATE" == '0' ]
        then
                echo -e "${RED}nobat"
        exit
        fi
 
        if [ "$CHARGE" -gt "15" ]
        then
           COLOUR="$YEL"
        fi
 
        if [ "$CHARGE" -gt "30" ]
        then
           COLOUR="$GRN"
        fi
        echo -e "${BATSTT}${COLOUR}${CHARGE}%${NON}"
}

set_prompt(){
	last_cmd=$?
	boldRed='\[\e[1;31m\]'
	boldGrn='\[\e[1;32m\]'
	txtRed='\[\e[0;31m\]'
	reset='\[\e[0m\]'
	topLCorner='\342\224\214'
	midLside='\342\224\234'
	btmLCorner='\342\224\224'
	btmDash='\342\224\200'
	check='\342\234\223'
	wrong='\342\234\227'
        bold='\[\e[1;'
        red='31m\]'
        grn='32m\]'
        color=$grn
        last_cmd_stat=$check
        textcolor=$reset
	if [[ $last_cmd == 0 ]]; then
                color=$grn
                textcolor=$reset
                last_cmd_stat=$check
	else
                color=$red
                textcolor=$txtRed
                last_cmd_stat=$wrong
	fi
        PS1="$textcolor$topLCorner$bold$color[\u@\h \!]$textcolor\n"
        PS1=$PS1"$midLside$reset`if [ -e /sys/class/power_supply/BAT1 ]; then echo $(battery_status);fi;` $textcolor\A \w\n"
        PS1=$PS1"$btmLCorner$btmDash($bold$color$last_cmd_stat$textcolor)\#\$>$reset "
}
PROMPT_COMMAND='set_prompt'

#PS1='[\u@\h \W]\$ '
