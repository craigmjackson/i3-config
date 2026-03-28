#!/usr/bin/env bash
xrandr --query | grep "HDMI-1-0 connected" >/dev/null 2>&1
if [ "$?" != "0" ]; then
	exit 0
fi
xrandr --output eDP-1 --off --output HDMI-1-0 --auto --output DVI-I-3-2 --auto --output DVI-I-2-1 --auto
xrandr --output HDMI-1-0 --pos 1808x320 --output DVI-I-3-2 --left-of HDMI-1-0 --rotate right --pos 0x0 --output DVI-I-2-1 --right-of HDMI-1-0 --pos 4920x320
