###################################
# Google Cloud Project SDK Docker #
###################################

# Python 3
FROM python:3.7.3-stretch

# File Author / Maintainer
MAINTAINER Eddie Belter <ebelter@wustl.edu>

# Args
ARG username=ebelter


# Deps
RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
  apt-transport-https \
  ca-certificates \
  gcc \
  libnss-sss \
  less \
  python-dev \
  python-setuptools \
	sudo \
  vim && \
	apt-get clean

# GCP SDK DPKG
RUN echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -

# GCP SDK & Components
RUN sudo apt-get update && \
	DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
	kubectl \
	google-cloud-sdk \
	google-cloud-sdk-app-engine-grpc \
	google-cloud-sdk-pubsub-emulator \
	google-cloud-sdk-app-engine-go \
	google-cloud-sdk-datastore-emulator \
	google-cloud-sdk-app-engine-python \
	google-cloud-sdk-cbt \
	google-cloud-sdk-bigtable-emulator \
	google-cloud-sdk-app-engine-python-extras \
	google-cloud-sdk-datalab \
	google-cloud-sdk-app-engine-java

# CRC
RUN easy_install -U pip && \
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
ENV HOME /home/${username}

# Default Command
CMD [ /bin/bash ]
