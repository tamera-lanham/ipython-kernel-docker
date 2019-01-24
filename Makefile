IMAGE_NAME=python-kernel
build:
	docker build --rm -t ${IMAGE_NAME} .

test:
	./start-kernel.sh connection_file.json
