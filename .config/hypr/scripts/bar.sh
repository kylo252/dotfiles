#!/usr/bin/env bash

sleep 1
killall waybar 2>/dev/null
sleep 1
exec waybar
