# Grass-Chromium-Novnc
Based on https://github.com/vital987/chrome-novnc . 

Removed the Heroku keep-alive part because you can't run Grass on Heroku anyways.

## Disclaimer
This project is not affiliated with getgrass in any way.

You CAN get banned by getgrass if you use this project.

Getgrass shouldn't care about using chromium inside a container, but they may. Use at your own risk.

## Usage

### with docker compose
`docker compose up` and access `http://localhost:8080` to access the VNC.

Login your getgrass account from the chromium browser inside the VNC, and the grass extension will be running like in a normal browser.

### with docker run
```
docker run -d -p 8080:8080 -e VNC_PASS=CHANGE_IT  cwithw/grass-chrome-novnc:latest
```

Add other environment variables if needed.


## Pre built image
amd64: `cwithw/grass-chrome-novnc:latest`

arm64: `cwithw/grass-chrome-novnc:latest`

## Building
if you are having trouble building it because you cannot access google server to download Grass plugin, you can use `docker build . -t cwithw/grass-chrome-novnc:latest --build-arg https_proxy=http://192.168.32.2:7890` to build it with proxy.

## Environment variables:
|VARIABLE      |DESCRIPTION              |DEFAULT VALUE  |
|-------------:|:------------------------|:-------------:|
|VNC_PASS      |VNC Password             |CHANGE_IT      |
|VNC_TITLE     |VNC Session Title        |GrassChromium       |
|VNC_SHARED    |VNC Shared Mode          |false          |
|VNC_RESOLUTION|VNC Resolution           |800x600       |
|EXTRA_COMMAND |Extra command to run. can be used to update grass extension(`sh /scripts/getgrass.sh`) or start ssh proxy(`sshpass -p password ssh -o StrictHostKeyChecking=no -N -C -D 1337 root@bounceServer`). make sure this command runs forever or exit with code 0 on success.     |exit 0               |
|HOMEPAGE      |Homepage to open         |[grass homepage](https://app.getgrass.io/)|
|EXTRA_CHROME_OPTS|Extra chrome options. can be used to set proxy(--proxy-server=).  |               |
|HOST_PORT     |Host port for VNC        |8080           |

## directories
/data: data. mount this folder to keep your grass cookies.

/var/log: log