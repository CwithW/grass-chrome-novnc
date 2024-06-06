#!/bin/sh
set -e

mkdir -p /data/root_config
if [ ! -L /root/.config ]; then
    ln -s /data/root_config /root/.config
fi

# fixup for chrome complaining The profile appears to be in use by another Chromium process (16) on another computer (cbcb739847a2)
rm -f ~/.config/chromium/Singleton*