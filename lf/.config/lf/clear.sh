#!/bin/sh

if [ "$TERM" = "xterm-kitty" ]; then
	kitty +kitten icat --transfer-mode file --clear
else
	chafa --clear
fi
