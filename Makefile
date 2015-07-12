##
# Build script
##

.PHONY: all docker services

all: docker services

docker: /usr/local/bin/boot2docker
	boot2docker up

services: /usr/local/bin/docker-compose
	docker-compose up

/usr/local/bin/boot2docker: /usr/local/bin/brew
	brew install boot2docker

/usr/local/bin/docker-compose: /usr/local/bin/brew
	brew install docker-compose

/usr/local/bin/brew:
	$(error you must install homebrew)
