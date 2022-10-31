#!/usr/bin/env bash

killall waybar 2>/dev/null
sleep 1
exec waybar
