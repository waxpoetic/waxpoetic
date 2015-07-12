##
# Build script
##

.PHONY: all docker services

all: docker services

docker:
	boot2docker up

services:
	docker-compose up
