#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

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

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

# Compositor for background opacity (pkg: picom)
# picom --config .config/picom.conf &

# Status bar (pkg: polybar)
#polybar &
#xmobar &

# Copy tmp files for cracked burpsuite
cp -r /opt/git/Burp-Suite/burp_temp/burp* /tmp/

# Script to greet on login (annoying af)
#bash /opt/project-x/scripts/main.sh

# Wallpaper manager (pkg: nitrogen)
nitrogen --restore &

#exec bspwm

# Setting mouse cursor instead of an X on screen
xsetroot -cursor_name left_ptr

# Starting xmonad (build from source version)
exec xmonad

#exec startxfce4
