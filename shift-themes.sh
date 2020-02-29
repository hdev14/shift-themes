#!/bin/bash

# TEMAS E WALLPAPERS

PATH_LIGHT_WALLPAPER="/home/$1/Pictures/wallpapers/wallpaper-condigo6-light.png"
PATH_DARK_WALLPAPER="/home/$1/Pictures/wallpapers/wallpaper-condigo6-dark.png"

VSCODE_LIGHT_THEME="Github Light Theme - Gray"
VSCODE_DARK_THEME="Abyss"

XFCE_WINDOW_LIGHT_THEME="Qogir-light"
XFCE_WINDOW_DARK_THEME="Qogir-dark"

XFCE_LIGHT_THEME="Qogir-light"
XFCE_DARK_THEME="Arc-Black-Steel"

# Usado para que seja possível a troca de temas e wallpapers.
PID=$(pgrep xfce4-session)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

VSCODE_SETTINGS="/home/$1/.config/Code/User/settings.json"
if [[ ! -f $VSCODE_SETTINGS ]]; then
  echo "Arquivo de configuração não encontrado"
  exit
fi

CURRENT_HOUR=$(date +"%H")
if [ $CURRENT_HOUR -ge 6 -a $CURRENT_HOUR -lt 18 ]; then

  if [ -z  "$(cat $VSCODE_SETTINGS | grep "\"${VSCODE_LIGHT_THEME}\"")" ]; then

    xfconf-query --channel xfwm4 --property /general/theme --set $XFCE_WINDOW_LIGHT_THEME

    xfconf-query --channel xsettings --property /Net/ThemeName --set $XFCE_LIGHT_THEME

    xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set $PATH_LIGHT_WALLPAPER
    xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor1/workspace0/last-image --set $PATH_LIGHT_WALLPAPER

    cat $VSCODE_SETTINGS | sed "s:$VSCODE_DARK_THEME:$VSCODE_LIGHT_THEME:g" | tee $VSCODE_SETTINGS

  fi
  
else

  if [ -z "$(cat $VSCODE_SETTINGS | grep "\"${VSCODE_DARK_THEME}\"")" ]; then
    
    xfconf-query --channel xfwm4 --property /general/theme --set $XFCE_WINDOW_DARK_THEME

    xfconf-query --channel xsettings --property /Net/ThemeName --set $XFCE_DARK_THEME

    xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set $PATH_DARK_WALLPAPER
    xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor1/workspace0/last-image --set $PATH_DARK_WALLPAPER

    cat $VSCODE_SETTINGS | sed "s:$VSCODE_LIGHT_THEME:$VSCODE_DARK_THEME:g" | tee $VSCODE_SETTINGS

  fi
  
fi
