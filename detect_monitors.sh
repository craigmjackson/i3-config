#!/usr/bin/env bash
laptop_display="eDP-1"
external_display_1="DVI-I-3-2"
external_display_2="HDMI-1-0"
external_display_3="DVI-I-2-1"

function is_connected() {
	xrandr --query | grep "${1} connected" >/dev/null 2>&1
	if [ "$?" == "0" ]; then
		echo "connected"
	else
		echo "disconnected"
	fi
}

function enable_0() {
	xrandr --output ${laptop_display} --auto --output ${external_display_1} --off --output ${external_display_2} --off --output ${external_display_3} --off
}

function enable_1() {
	xrandr --output ${laptop_display} --off --output ${external_display_1} --auto --output ${external_display_2} --off --output ${external_display_3} --off
	xrandr --output ${external_display_1} --rotate right
}

function enable_2() {
	xrandr --output ${laptop_display} --off --output ${external_display_1} --off --output ${external_display_2} --auto --output ${external_display_3} --off
}

function enable_3() {
	xrandr --output ${laptop_display} --off --output ${external_display_1} --off --output ${external_display_2} --off --output ${external_display_3} --auto
}

function enable_1_2() {
	xrandr --output ${laptop_display} --off --output ${external_display_1} --auto --output ${external_display_2} --auto --output ${external_display_3} --off
	xrandr --output ${external_display_2} --pos 1808x320 --output ${external_display_1} --left-of ${external_display_2} --rotate right --pos 0x0
}

function enable_2_3() {
	xrandr --output ${laptop_display} --off --output ${external_display_1} --off --output ${external_display_2} --auto --output ${external_display_3} --auto
	xrandr --output ${external_display_2} --pos 0x0 --output ${external_display_3} --right-of ${external_display_2} --pos 3840x0
}

function enable_1_3() {
	xrandr --output ${laptop_display} --off --output ${external_display_1} --auto --output ${external_display_2} --off --output ${external_display_3} --auto
	xrandr --output ${external_display_1} --pos 0x0 --rotate right --output ${external_display_3} --right-of ${external_display_1} --pos 1080x320
}

function enable_1_2_3() {
	xrandr --output ${laptop_display} --off --output ${external_display_1} --auto --output ${external_display_2} --auto --output ${external_display_3} --auto
	xrandr --output ${external_display_2} --pos 1808x320 --output ${external_display_1} --left-of ${external_display_2} --rotate right --pos 0x0 --output ${external_display_3} --right-of ${external_display_2} --pos 4920x320
}

function get_states() {
	connected_1=$(is_connected ${external_display_1})
	connected_2=$(is_connected ${external_display_2})
	connected_3=$(is_connected ${external_display_3})
	if [[ "${connected_1}" != "connected" && "${connected_2}" != "connected" && "${connected_3}" != "connected" ]]; then
		echo "0"
	elif [[ "${connected_1}" == "connected" && "${connected_2}" != "connected" && "${connected_3}" != "connected" ]]; then
		echo "1"
	elif [[ "${connected_1}" != "connected" && "${connected_2}" == "connected" && "${connected_3}" != "connected" ]]; then
		echo "2"
	elif [[ "${connected_1}" != "connected" && "${connected_2}" != "connected" && "${connected_3}" == "connected" ]]; then
		echo "3"
	elif [[ "${connected_1}" == "connected" && "${connected_2}" == "connected" && "${connected_3}" != "connected" ]]; then
		echo "1_2"
	elif [[ "${connected_1}" != "connected" && "${connected_2}" == "connected" && "${connected_3}" == "connected" ]]; then
		echo "2_3"
	elif [[ "${connected_1}" == "connected" && "${connected_2}" != "connected" && "${connected_3}" == "connected" ]]; then
		echo "1_3"
	elif [[ "${connected_1}" == "connected" && "${connected_2}" == "connected" && "${connected_3}" == "connected" ]]; then
		echo "1_2_3"
	else
		echo ""
	fi
}

previous_states=$(get_states)
while true; do
	xrandr --current >/dev/null 2>&1
	if [ "$?" != "0" ]; then
		exit 0
	fi
	current_states=$(get_states)
	if [ "${current_states}" != "${previous_states}" ]; then
		if [ "${current_states}" == "0" ]; then
			enable_0
		elif [ "${current_states}" == "1" ]; then
			enable_1
		elif [ "${current_states}" == "2" ]; then
			enable_2
		elif [ "${current_states}" == "3" ]; then
			enable_3
		elif [ "${current_states}" == "1_2" ]; then
			enable_1_2
		elif [ "${current_states}" == "2_3" ]; then
			enable_2_3
		elif [ "${current_states}" == "1_3" ]; then
			enable_1_3
		elif [ "${current_states}" == "1_2_3" ]; then
			enable_1_2_3
		fi
		previous_states=${current_states}
	fi
	sleep 5
done
