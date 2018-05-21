##################################
# Google Cloud Engine SDK Docker #
##################################

# Based on...
FROM google/cloud-sdk:latest

# File Author / Maintainer
LABEL maintainer="ebelter@wustl.edu"

# Args
ARG username=ebelter

# Deps
RUN apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	less \
        libnss-sss \
	sudo \
	vim && \
	apt-get clean

# CRC
RUN DEBIAN_FRONTEND=noninteractive apt-get install gcc python-dev python-setuptools && \
	apt-get clean && \
	easy_install -U pip && \
	pip uninstall --yes crcmod && \
	pip install -U crcmod

# Me! or You!
COPY homedir /home/${username}
RUN rm -rf /home/${username}/.git /home/${username}/.gitignore
RUN useradd -Ms /bin/bash ${username} -G staff && \
	mkdir /home/${username}/tmp/ && \
	chown -R ${username} /home/${username}/ && \
	chgrp -R ${username} /home/${username}/
RUN echo "${username} ALL=(ALL:ALL) NOPASSWD: ALL" | sudo EDITOR='tee -a' visudo
USER ${username}
WORKDIR /home/${username}

# Entry Point
CMD [--login]
ENTRYPOINT /bin/bash
