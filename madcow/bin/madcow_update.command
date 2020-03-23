#!/usr/bin/env bash
dir=${0%/*}; if [ "$dir" = "$0" ]; then dir="."; fi; cd "$dir";

dlpath="$TMPDIR/madcow-$(date '+%Y%m%d%H%M%S').zip";
curl -o "$dlpath" https://github.com/twardoch/madcow/archive/master.zip
mchome="$HOME/.madcow";
mkdir -p "$mchome";

mcbin="$mchome/bin";
mkdir -p "$mchome";

echo "OK";

#/usr/bin/bash -e "$(curl -fsSL https://raw.githubusercontent.com/twardoch/madcow/master/madcow_install_mac.command)"