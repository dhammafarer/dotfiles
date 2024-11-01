#!/usr/bin/env bash

launcher='dmenu -i -nb #1d1f21 -nf #D3D7CF -sb #37ADD4 -sf #192330 -fn 11'
#launcher="rofi -dmenu -i"

cmd=~/dotfiles/arch/bin/hass

rm4c=f3e8f78e81ce8fbbbe613ed7d0382f11

remote_cmd() {
    $cmd service call remote.send_command --arguments device_id=$rm4c,device=$1,command=$2
}


lights_all="light.desk light.workbench light.salon light.kitchen light.kitchen_ceiling"
lights_studio="light.desk light.workbench"
lights_kitchen="light.kitchen light.kitchen_ceiling"
plug_sonoff=switch.0x00124b0026b87179

declare -a options=(
"light.desk"
"light.workbench"
"light.salon"
"light.kitchen"
"light.kitchen_ceiling"
"light.all_on"
"light.all_off"
"light.studio_on"
"light.studio_off"
"input_number.master_offset"
"input_number.desk_addend"
"input_number.salon_addend"
"input_number.workbench_addend"
"input_number.bathroom_addend"
"input_number.kitchen_addend"
"input_number.kitchen_ceiling_addend"
"fan.toggle"
"fan.turn_on"
"fan.turn_off"
"tv.power"
"tv.cnn"
"tv.prev"
"tv.mute"
"tv.vol"
"tv.volume_up"
"tv.volume_down"
"ac.on"
"ac.off"
"ac.high"
"ac.mid"
"ac.low"
"ac.ac"
"ac.22"
"ac.23"
"ac.24"
"ac.25"
"ac.26"
"sleep"
)

# The combination of echo and printf is done to add line breaks to the end of each
# item in the array before it is piped into dmenu.  Otherwise, all the items are listed
# as one long line (one item).

choice=$(echo "$(printf '%s\n' "${options[@]}")" | $launcher -p 'Home Assistant')
case "$choice" in
	light.all_on)
        $cmd state turn_on $lights_all
	;;
	light.all_off)
        $cmd state turn_off $lights_all
	;;
	light.studio_on)
        $cmd state turn_on $lights_studio
	;;
	light.studio_off)
        $cmd state turn_off $lights_studio
	;;
	light.kitchen_off)
        $cmd state turn_off $lights_kitchen
	;;
	light.*)
        $cmd state toggle $choice
	;;
	fan.*)
        $cmd state $(echo $choice | cut -d"." -f2) $plug_sonoff
	;;
	input_number.*)
        value=$(echo -e "0\n25\n50\n100" | ${launcher} -p "$choice:")
        $cmd state edit $choice --json="{\"state\":${value}}"
	;;
	ac.on)
        $cmd service call automation.trigger --arguments entity_id=automation.ac_on \
        && notify-send "AC" "ON"
	;;
	ac.off)
        $cmd service call automation.trigger --arguments entity_id=automation.ac_off \
        && notify-send "AC" "OFF"
	;;
	ac.*)
        remote_cmd "aircon" $(echo $choice | cut -d"." -f2) 
	;;
	tv.cnn)
        remote_cmd "tv" "5"
	;;
	tv.vol)
        value=$(echo -e "-1\n-3\n-5\n+5\n+3\n+1" | ${launcher} -p "$choice:")
        case "$value" in
            +*)
                rep=$(echo $value | cut -d"+" -f2)
                $cmd service call remote.send_command \
                    --arguments device_id=${rm4c},device=tv,command=volume_up,num_repeats=${rep}
                notify-send "TV" "Volume ${value}"
	        ;;
            -*)
                rep=$(echo $value | cut -d"-" -f2)
                $cmd service call remote.send_command \
                    --arguments device_id=${rm4c},device=tv,command=volume_down,num_repeats=${rep}
                notify-send "TV" "Volume ${value}"
	        ;;
            *)
                exit 1
            ;;
        esac
	;;
	tv.*)
        remote_cmd "tv" $(echo $choice | cut -d"." -f2) 
	;;
	sleep)
        $cmd state turn_off $lights_studio light.kitchen light.kitchen_ceiling $plug_sonoff
	;;
	*)
		exit 1
	;;
esac
