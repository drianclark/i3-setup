#!/bin/bash

d=$(date +%e)

case $d in
    1?) d=${d}th ;;
    *1) d=${d}st ;;
    *2) d=${d}nd ;;
    *3) d=${d}rd ;;
    *)  d=${d}th ;;
esac

date "+%H:%M %A, $d %B %Y  "
