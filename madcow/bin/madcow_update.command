#!/usr/bin/env bash
dir=${0%/*}; if [ "$dir" = "$0" ]; then dir="."; fi; cd "$dir";

mctmp="$TMPDIR/madcow-$(date '+%Y%m%d%H%M%S')";
curl -L -o "$mctmp.zip" https://github.com/twardoch/madcow/archive/master.zip
mkdir -p "$mctmp";
unzip "$mctmp.zip" "madcow-master/madcow/*" -d "$mctmp";
rm -f "$mctmp.zip";
mchome="$HOME/.madcow";
mkdir -p "$mchome";
rsync -r -u "$mctmp/madcow-master/madcow/" "$mchome";
rm -rf "$mctmp";
mcbin="$mchome/bin";
source "$mcbin/madcowlib";
echo "OK";

#/usr/bin/bash -e "$(curl -fsSL https://raw.githubusercontent.com/twardoch/madcow/master/madcow_install_mac.command)"