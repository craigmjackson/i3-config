#!/usr/bin/env bash
# sleep 5
xrandr --output eDP-1 --off --output HDMI-1-0 --auto --output DVI-I-3-2 --auto --output DVI-I-2-1 --auto
# sleep 5
# xrandr --output DVI-I-3-2 --auto
# sleep 5
# xrandr --output HDMI-1-0 --pos 1808x320 --output DVI-I-3-2 --left-of HDMI-1-0 --rotate right --pos 0x0
# sleep 5
# xrandr --output DVI-I-2-1 --auto
xrandr --output HDMI-1-0 --pos 1808x320 --output DVI-I-3-2 --left-of HDMI-1-0 --rotate right --pos 0x0 --output DVI-I-2-1 --right-of HDMI-1-0 --pos 4920x320
