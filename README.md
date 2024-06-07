# Grass-Chromium-Novnc
Based on https://github.com/vital987/chrome-novnc . 

Removed the Heroku keep-alive part because you can't run Grass on Heroku anyways.

## Usage

### with docker compose
`docker compose up` and access `http://localhost:8080` to access the VNC.

### with docker run
```
docker run -d -p 8080:8080 -e VNC_PASS=CHANGE_IT  cwithw/grass-chrome-novnc:latest
```


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
|EXTRA_COMMAND |Extra command to run. can be used to update grass extension(`sh /scripts/getgrass.sh && sleep infinity`) or start ssh proxy(`sshpass -p password ssh -o StrictHostKeyChecking=no -N -C -D 1337 root@bounceServer`). make sure this command runs forever and does not exit on success.     |sleep infinity               |
|HOMEPAGE      |Homepage to open         |[grass homepage](https://app.getgrass.io/)|
|EXTRA_CHROME_OPTS|Extra chrome options. can be used to set proxy(--proxy-server=).  |               |
|HOST_PORT     |Host port for VNC        |8080           |

## directories
/data: data. mount this folder to keep your grass cookies.

/var/log: log