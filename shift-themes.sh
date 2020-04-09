#!/bin/bash

# DESCRIÇÃO
# Este script serve para alterar os temas do XFCE, VSCode e wallpapers. 
# Quando o horário está entre 6 e 18, temas claros são configurados
# nos outros horários os temas escuros são defindos.

# COMO USAR
# Primeiramente é preciso definir os temas claros e escuros tanto para o XCFE 
# como para o VSCode. Vale lembrar que é preciso que esses temas e wallpapers
# já estejam instalados/baixados corretamente.

# COMANDO
# $ ./script.sh $USER
# 

# SCRIPT + CRON
# Para automatizar esse script, basta utilizar o agendamento de tarefas. 
# O cron é recurso presente no Linux que permite a execução automática 
# de tarefas. 
# 
# Basta utilzar o seguinte comando:
# 
# $ crontab -e
#
# Após isso, irá abrir um editor de texto, dessa forma basta adicionar esta linha
# de comando: 0-55/5 * * * * <caminho-completo-até-o-arquivo> <usuário>
#
# Ex: 0-55/5 * * * * /home/joao/Documents/<script>.sh joao
#
# Essa tarefa irá executar este script a cada 5 minutos. Porém você pode escolher
# o intervalo mais adequado para você. Basta pesquisar sobre regras do crontab.

# OBS
# Esse script foi desenvolvido na distro XUBUNTU. Dessa forma se você usa 
# outra distro que utiliza XCFE, talvez seja preciso fazer alterações.


# ------------------------------------------------------------------------- #


# TEMAS E WALLPAPERS

PATH_LIGHT_WALLPAPER="/home/$1/Pictures/wallpapers/wallpaper-condigo6-light.png"
PATH_DARK_WALLPAPER="/home/$1/Pictures/wallpapers/wallpaper-condigo6-dark.png"

VSCODE_LIGHT_THEME="Ayu Light"
VSCODE_DARK_THEME="Ayu Mirage"

XFCE_WINDOW_LIGHT_THEME="Qogir-light"
XFCE_WINDOW_DARK_THEME="Qogir-dark"

XFCE_LIGHT_THEME="Qogir-light" 
XFCE_DARK_THEME="Qogir-dark"

# Usado para que seja possível a troca de temas e wallpapers.
PID=$(pgrep xfce4-session -n)
export DBUS_SESSION_BUS_ADDRESS=$(grep -z DBUS_SESSION_BUS_ADDRESS /proc/$PID/environ|cut -d= -f2-)

VSCODE_SETTINGS="/home/$1/.config/Code/User/settings.json"
if [[ ! -f $VSCODE_SETTINGS ]]; then
  echo "Arquivo de configuração não encontrado"
  exit
fi

CURRENT_HOUR=$(date +"%H")
if [ $CURRENT_HOUR -ge 6 -a $CURRENT_HOUR -lt 17 ]; then

  xfconf-query --channel xfwm4 --property /general/theme --set $XFCE_WINDOW_LIGHT_THEME
  xfconf-query --channel xsettings --property /Net/ThemeName --set $XFCE_LIGHT_THEME
  xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set $PATH_LIGHT_WALLPAPER
  xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor1/workspace0/last-image --set $PATH_LIGHT_WALLPAPER

  if [ -z  "$(cat $VSCODE_SETTINGS | grep "\"${VSCODE_LIGHT_THEME}\"")" ]; then    
    cat $VSCODE_SETTINGS | sed "s:$VSCODE_DARK_THEME:$VSCODE_LIGHT_THEME:g" | tee $VSCODE_SETTINGS
  fi
  
else

  xfconf-query --channel xfwm4 --property /general/theme --set $XFCE_WINDOW_DARK_THEME
  xfconf-query --channel xsettings --property /Net/ThemeName --set $XFCE_DARK_THEME
  xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor0/workspace0/last-image --set $PATH_DARK_WALLPAPER
  xfconf-query --channel xfce4-desktop --property /backdrop/screen0/monitor1/workspace0/last-image --set $PATH_DARK_WALLPAPER
  
  if [ -z "$(cat $VSCODE_SETTINGS | grep "\"${VSCODE_DARK_THEME}\"")" ]; then
    cat $VSCODE_SETTINGS | sed "s:$VSCODE_LIGHT_THEME:$VSCODE_DARK_THEME:g" | tee $VSCODE_SETTINGS
  fi
  
fi
