#!/usr/bin/env bash
dir=${0%/*}; if [ "$dir" = "$0" ]; then dir="."; fi; cd "$dir";
eval "$(curl -fsSL https://raw.githubusercontent.com/twardoch/madcow/master/bin/madcow_update.command)"