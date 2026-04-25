#!/bin/bash
LOGO_DIR="$HOME/.config/fastfetch/logo"
logos=("$LOGO_DIR"/*)
random_logo="${logos[RANDOM % ${#logos[@]}]}"
fastfetch --logo "$random_logo" --logo-type kitty --logo-height 18
