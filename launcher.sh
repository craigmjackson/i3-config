#!/usr/bin/env bash
program="brave
gimp
libreoffice
ristretto
thunar
vlc
xfce4-power-manager-settings"

result=$(echo "$program" | dmenu -i -l 20 -fn "Hack Nerd Font Mono-14" -nb "#0b1133" -nf "#ffffff" -sb "#ffffff" -sf "#000000")
$result
