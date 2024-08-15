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
#picom --config .config/picom.conf &

# Copy tmp files for cracked burpsuite
# cp -r /opt/git/Burp-Suite/burp_temp/burp* /tmp/

# Wallpaper manager (pkg: nitrogen)
nitrogen --restore &

# Setting mouse cursor instead of an X on screen
xsetroot -cursor_name left_ptr
exec dbus-launch --sh-syntax --exit-with-session dwm
#while type dwm >/dev/null ; do dwm && continue || break ; done
