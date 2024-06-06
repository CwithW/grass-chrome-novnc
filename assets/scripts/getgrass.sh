#!/bin/sh

set -e

extensionId='ilehaonighjijnmpnagapkhpcdbhclfg'
CRX_URL="https://clients2.google.com/service/update2/crx?response=redirect&prodversion=98.0.4758.102&acceptformat=crx2,crx3&x=id%3D~~~~%26uc&nacl_arch=x86-64"
USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36"

# Download the CRX file

REAL_CRX_URL=$(echo "$CRX_URL" | sed "s/~~~~/$extensionId/g")
echo "Downloading Grass extension..."
wget -O /tmp/grass.crx --user-agent="$USER_AGENT" "$REAL_CRX_URL"


# extract the CRX file
if [ -d /root/grass-extension ]; then
  rm -rf /root/grass-extension
fi
mkdir -p /root/grass-extension
(unzip /tmp/grass.crx -d /root/grass-extension || true)

# Assert that the extension is valid
ls /root/grass-extension/manifest.json >/dev/null
GRASS_EXTENSION_VERSION=$(cat /root/grass-extension/manifest.json | jq -r '.version')
echo "Downloaded Grass extension version: $GRASS_EXTENSION_VERSION" 