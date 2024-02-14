#!/bin/sh

# set proper locale(1) wih LC_ALL
export LC_ALL=en_US.UTF-8

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/Xresources
sysmodmap=/etc/X11/xinit/Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

xrandr --output DisplayPort-0 --primary --mode 2560x1440 --pos 1920x0 --rotate normal --output HDMI-A-0 --mode 1920x1080 --pos 0x0 --rotate normal

# set layout for EN, AR
setxkbmap -layout us,ara -option grp:lalt_lshift_toggle

#xscreensaver -no-splash &
xdg-user-dirs-update &

#conky -d &
#conky | while read -r; do xsetroot -name "$REPLAY"; done &
conky --daemonize --pause=10 &

picom ~/.config/picom.conf &

picom -b -f &

redshift &

#clipmenud &

xrdb -load $HOME/.config/X11/Xresources

#$(sleep 4s && "$HOME/.config/polybar/launch") &

# Fixing for Java applications
AWT_TOOLKIT=MToolkit; export AWT_TOOLKIT
wmname LG3D &

#/usr/local/bin/slstatus &
#xsetroot -solid black &
#exec dbus-launch --sh-syntax --exit-with-session dwm

#exec startfluxbox
#openbox
exec dbus-launch --exit-with-session openbox
#exec dbus-launch --exit-with-session startfluxbox

#exec dbus-launch --sh-syntax --exit-with-session startxfce4
