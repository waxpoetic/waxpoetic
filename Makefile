##
# Build script
##

.PHONY: all clean services

all: services

services:
	docker-compose up

clean:
	docker-compose down
