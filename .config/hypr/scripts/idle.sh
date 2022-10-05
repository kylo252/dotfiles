#!/usr/bin/env bash

exec swayidle -w \
	timeout 120 'hyprctl dispatch dpms off' \
	resume 'hyprctl dispatch dpms on'
