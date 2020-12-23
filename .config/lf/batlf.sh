#!/bin/sh
unset COLORTERM
bat --color=always --style=plain --wrap auto "$1"
