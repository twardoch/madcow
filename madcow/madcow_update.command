#!/usr/bin/env bash
dir=${0%/*}; if [ "$dir" = "$0" ]; then dir="."; fi; cd "$dir";

echo "OK";

#/usr/bin/bash -e "$(curl -fsSL https://raw.githubusercontent.com/twardoch/madcow/master/madcow_install_mac.command)"