#!/usr/bin/env bash

if ! command -v brightnessctl &> /dev/null;
then
    echo 'Command `brightnessctl` not found'
    exit
fi

notify-screen() {
    local val=$(brightnessctl -m | awk -F, '{print substr($4, 0, length($4)-1)}')
    local urg=low

    if (($val == 100)) || (($val == 0)) then
        local urg=normal
    fi

    notify-send -u $urg "Screen brightness" "$val%"
}

notify-keyboard() {
    local val=$(brightnessctl -m -d 'asus::kbd_backlight' | awk -F, '{print substr($4, 0, length($4)-1)}')
    local urg=low

    if (($val == 100)) || (($val == 0)) then
        local urg=normal
    fi

    notify-send -u $urg "Keyboard brightness" "$val%"

}

case "$1" in
    'su' )
        brightnessctl s +10%
        notify-screen
        ;;
    'sd' )
        brightnessctl s 10%-
        notify-screen
        ;;
    'ku' )
        brightnessctl --device='asus::kbd_backlight' s +10%
        notify-keyboard
        ;;
    'kd' )
        brightnessctl --device='asus::kbd_backlight' s  10%-
        notify-keyboard
        ;;
    * )
        echo 'Invalid argument'
        ;;
esac
