IMAGE_NAME=python-kernel
build:
	docker build --rm -t ${IMAGE_NAME} .

test:
	./start-kernel.sh $(PWD)/connection_file.json

run:
	jupyter console --kernel ipython-kernel-docker
