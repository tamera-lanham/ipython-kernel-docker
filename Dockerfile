FROM ubuntu:16.04

RUN apt-get update && apt-get install -y --no-install-recommends \
  jq \
  python3.5 \
  python3-pip \
  python3-setuptools \
  netcat

RUN pip3 install ipython ipykernel

# Add Tini. Tini operates as a process subreaper for jupyter. This prevents
# kernel crashes.
ENV TINI_VERSION v0.6.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /usr/bin/tini
RUN chmod +x /usr/bin/tini

COPY entrypoint.sh entrypoint.sh

# At runtime, mount the connection file to /tmp/connection_file.json
ENTRYPOINT [ "./entrypoint.sh"]
