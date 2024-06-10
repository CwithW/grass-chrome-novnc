FROM alpine:3.19.1

LABEL AboutImage "grass-chrome-novnc"

LABEL Maintainer "Chara White"

#VNC Server Password
ENV	VNC_PASS="CHANGE_IT" \
#VNC Server Title(w/o spaces)
	VNC_TITLE="GrassChromium" \
#VNC Resolution(720p is preferable)
	VNC_RESOLUTION="800x600" \
#VNC Shared Mode
	VNC_SHARED=false \
#Local Display Server Port
	DISPLAY=:0 \
#NoVNC Port
	NOVNC_PORT=$PORT \
	PORT=8080 \
#Locale
	LANG=en_US.UTF-8 \
	LANGUAGE=en_US.UTF-8 \
	LC_ALL=C.UTF-8 \
	TZ="Asia/Shanghai" \
# Extra
HOMEPAGE="https://app.getgrass.io/" \
EXTRA_CHROME_OPTS="" \
EXTRA_COMMAND="exit 0"

COPY assets/ /

RUN	sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories && \
	apk update && \
	apk add --no-cache tzdata ca-certificates supervisor curl wget openssl bash sed unzip xvfb x11vnc websockify openbox chromium nss alsa-lib font-noto font-noto-cjk openssh sshpass jq && \
# noVNC SSL certificate
	openssl req -new -newkey rsa:4096 -days 36500 -nodes -x509 -subj "/C=IN/O=Dis/CN=www.google.com" -keyout /etc/ssl/novnc.key -out /etc/ssl/novnc.cert > /dev/null 2>&1 && \
# TimeZone
	cp /usr/share/zoneinfo/$TZ /etc/localtime && \
	echo $TZ > /etc/timezone && \
# get grass extension
	sh /scripts/getgrass.sh && \
# Wipe Temp Files
# Don't delete curl,wget,jq,unzip as they are used in scripts
# keep ssh, sshpass for ssh tunneling(user custom usage)
	apk del openssl build-base && \
	rm -rf /var/cache/apk/* /tmp/* /extension

ENTRYPOINT ["supervisord", "-l", "/var/log/supervisord.log", "-c"]

CMD ["/config/supervisord.conf"]
