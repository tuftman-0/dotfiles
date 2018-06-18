#!/bin/bash
rofi \
    -show window -terminal urxvt -hide-scrollbar true  \
    -line-margin 0 -lines 20 -eh 1 -width 40 -bw 3 \
    -kb-cancel "Alt+Escape,Escape" \
    -kb-accept-entry "!Alt-Tab,Return"\
    -kb-row-down "Alt+Tab,Alt+Down" \
    -kb-row-up "Alt+ISO_Left_Tab,Alt+Up"&
    -bg        "#222222"  -fg        "#2ECC71" \
    -hlbg      "#2ECC71"  -hlfg      "#222222" \
    -bg-active "#222222"  -fg-active "#2288DD" \
    -font      "Mononoki 12"   -opacity 80
xdotool keyup Tab
xdotool keydown Tab
