all: build push

build:
	docker build -t ${DOCKER_USER}/saltmaster:develop .

push: build
	docker push ${DOCKER_USER}/saltmaster:develop

test: build
	docker run -i ${DOCKER_USER}/saltmaster:develop /bin/bash -l -c 'salt --versions-report'
