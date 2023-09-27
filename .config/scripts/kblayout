#!/usr/bin/bash

case $(setxkbmap -query | grep layout | awk '{ print $2 }') in
	us) setxkbmap br ;;
	br) setxkbmap us ;;
esac
