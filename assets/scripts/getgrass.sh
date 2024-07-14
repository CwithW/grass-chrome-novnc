#!/bin/sh

set -e


if [ "$GRASS_FLAVOR" != "community" ] && [ "$GRASS_FLAVOR" != "lite" ]; then
  echo "Invalid GRASS_FLAVOR: $GRASS_FLAVOR, must be one of 'community' or 'lite'"
  exit 1
fi

if [ "$GRASS_FLAVOR" = "community" ]; then
  echo "Downloading Grass extension (community)..."
  CRX_URL="https://files.getgrass.io/file/grass-extension-upgrades/extension-latest/grass-community-node-linux-4.20.2.zip"
  USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36"
  # download the zip file, need to extract the CRX file from it.
  wget -O /tmp/grass.zip --user-agent="$USER_AGENT" "$CRX_URL"
  unzip /tmp/grass.zip -d /tmp
  mv /tmp/grass*.crx /tmp/grass.crx
  rm /tmp/grass.zip
else
  echo "Downloading Grass extension (lite)..."
  extensionId='ilehaonighjijnmpnagapkhpcdbhclfg'
  CRX_URL="https://clients2.google.com/service/update2/crx?response=redirect&prodversion=98.0.4758.102&acceptformat=crx2,crx3&x=id%3D~~~~%26uc&nacl_arch=x86-64"
  USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/98.0.4758.102 Safari/537.36"
  REAL_CRX_URL=$(echo "$CRX_URL" | sed "s/~~~~/$extensionId/g")
  # Download the CRX file
  wget -O /tmp/grass.crx --user-agent="$USER_AGENT" "$REAL_CRX_URL"
fi


# extract the CRX file
if [ -d /root/grass-extension ]; then
  rm -rf /root/grass-extension
fi
mkdir -p /root/grass-extension
(unzip /tmp/grass.crx -d /root/grass-extension || true)

rm /tmp/grass.crx

# Assert that the extension is valid
ls /root/grass-extension/manifest.json >/dev/null
GRASS_EXTENSION_VERSION=$(cat /root/grass-extension/manifest.json | jq -r '.version')
echo "Downloaded Grass extension version: $GRASS_EXTENSION_VERSION" 