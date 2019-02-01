# iPython Kernel in Docker

Basic example of connecting to an iPython kernel running within a Docker container.

## Prerequisites

- [`jq`](https://stedolan.github.io/jq/) - needed to parse the [connection file](https://jupyter-client.readthedocs.io/en/stable/kernels.html#connection-files)

## 10 Second Tutorial

Build the docker image. The docker container will launch a kernel running Python3 and listen on the ports defined in the connection file.

```
make build
```

Make Jupyter aware of our kernel

```
make install
```

Launch a Jupyter Console, which will create a connection file and a container, then attach to the kernel running inside of the container.

```
make run
```

## Debugging and Testing

To start the kernel yourself and attach using the `--existing` flag, use:

```
make test
```

And then in a separate terminal, from the project directory, run

```
jupyter console --existing $(pwd)/sample_connection_file.json
```
