#!/bin/bash

killall -q swaylock

swaylock \
  --screenshots \
  --effect-blur 8x3 \
  --clock \
  --indicator \
  --indicator-radius 120 \
  --indicator-thickness 8 \
  --ring-color FFFFFF \
  --ring-clear-color 0e91cfCC \
  --ring-ver-color 7ce38b  \
  --ring-wrong-color fb958bCC \
  --key-hl-color a6e3a1CC \
  --bs-hl-color  a6e3a1CC \
  --line-color 00000000 \
  --inside-color 1b1a2bcc \
  --inside-clear-color 0d0f18CC \
  --inside-ver-color 0d0f18CC \
  --inside-wrong-color 0d0f18CC \
  --separator-color 00000000 \
  --text-color D8DEE9 \
  --text-clear-color D8DEE9 \
  --text-ver-color D8DEE9 \
  --text-wrong-color D8DEE9 \
  --fade-in 0.3

