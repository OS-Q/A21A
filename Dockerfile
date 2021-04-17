# Container image that runs your code
FROM ubuntu:latest

ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8

# Install prerequisites
RUN apt-get --quiet=2 update && apt-get install --quiet=2 --assume-yes git python3 python3-pip wget apt-utils

# Install PlatformIO
RUN pip3 install --quiet -U https://github.com/OS-Q/S03/releases/latest/download/S03.zip
RUN qio platform install https://github.com/OS-Q/P21/releases/latest/download/P21.zip
# RUN pip3 install --quiet --upgrade platformio
CMD /bin/bash

# Copies your code file from your action repository to the filesystem path `/` of the container
# COPY builder.py /builder.py
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
