IMAGE_NAME=python-kernel
build:
	docker build --rm -t ${IMAGE_NAME} .

test:
	./start-kernel.sh /Users/lanhamt/Developer/ipython-kernel-docker/connection_file.json

real:
	jupyter console --kernel ipython-kernel-docker
