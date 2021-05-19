# Build a container from Dockerfile

#vars
IMAGENAME=awspluskube
REPO=lemonaidhealth
IMAGEFULLNAME=${REPO}/${IMAGENAME}:latest

.PHONY: \build push all

.DEFAULT_GOAL := all

build:
	    @docker build --pull -t ${IMAGEFULLNAME} .

push:
	    @docker push ${IMAGEFULLNAME}

all: build push
