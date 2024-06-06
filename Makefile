USR=cwithw
NAME=grass-chrome-novnc
TAG=latest
IMG=${USR}/${NAME}:${TAG}
PUSH_TAG=$(shell date +%Y%m%d%H%M%S)
PUSH_IMG=${USR}/${NAME}:${PUSH_TAG}

build: clean
	docker build --tag ${IMG} --no-cache .  --build-arg https_proxy=http://192.168.32.2:7890

up:
	docker-compose up

down:
	docker-compose down

clean:
	docker stop ${IMG} 2>/dev/null || :
	docker rm ${IMG} 2>/dev/null || :
	docker rmi ${IMG} 2>/dev/null || :

push:
	docker tag ${IMG} ${PUSH_IMG}
	docker push ${PUSH_IMG}
