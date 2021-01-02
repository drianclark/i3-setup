#!/bin/bash

wsNext=$(( $( i3-msg -t get_workspaces | jq '.[] | select(.focused).num' ) + $1))
wsNextName=$(i3-msg -t get_workspaces | jq ".[] | select(.num == $wsNext).name")

if [ -z "$wsNextName" ]; then
    i3-msg move container to workspace number "$wsNext"
    i3-msg workspace number "$wsNext"
else
    i3-msg move container to workspace "$wsNextName"
    i3-msg workspace "$wsNextName"
fi
