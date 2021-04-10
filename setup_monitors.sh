#!/bin/bash
DVI_1_CONNECTED=$(xrandr | grep 'DVI-I-1-1 connected' | wc -l)
DVI_2_CONNECTED=$(xrandr | grep 'DVI-I-2-2 connected' | wc -l)

if [ $DVI_1_CONNECTED -eq 1 ] && [ $DVI_2_CONNECTED -eq 1 ]
then
    xrandr --output eDP-1 --off
    export PRIMARY=DVI-I-1-1
    export VERTICAL=DVI-I-2-2
    xrandr --output $PRIMARY --primary --auto --above eDP-1

    xrandr --output $VERTICAL --auto --right-of $PRIMARY
    xrandr --newmode "1920x1080_60.00"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
    xrandr --addmode $VERTICAL 1920x1080_60.00
    xrandr --output $VERTICAL --mode 1920x1080_60.00
    xrandr --output $VERTICAL --rotate right
fi
