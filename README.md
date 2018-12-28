# Google Cloud Project SDK Docker

This docker is based on the google/cloud-sdk:latest image and has has the gcloud and gsutil commands and updated components to interact with GCP. This docker also creates a user and copy a homedir into the image. This gives the convenience of config files and aliases.

## HOW TO Build

### User - YOU!

The dockerfile is configured to create a user inside the docker container. Pass the desired user name as a build arg when building the docker image.

### Home Directory [homedir]

This docker will build using the contents of a directory inside the docker context named 'homedir' as the user's home directory. Put whatever you want copied into the container into this 'homedir' directory. Place files like .bashrc, aliases, other config, commands, etc. into this directory to have access to them in the container.

### Building

Here is the docker build command. Replace george with your user name. 

$ ME=george docker build --build-arg username=$ME -t $ME/gc-sdk:latest .

## Running

An example on MACOSX to run this container, setting $YOU as the user and /home/$YOU as the working directory. It also adds the .ssh directory as GCP tools use SSH to access instances. It also sets the hostname, so you know you inside a GCP docker!

$ docker run -it --rm -h gcp-sdk -v /Users/$YOU/.ssh:/home/$YOU/.ssh $YOU/gc-sdk:latest /bin/bash

## Using Docker Inside the Image

Notes on running dockler inside the GCP docker container. This is needed when pushing docker images to your GCP docker registry.

### Login to GCP Docker Registry

$ gcloud auth print-access-token | sudo docker login -u oauth2accesstoken --password-stdin https://us.gcr.io

### Running Docker Commands

Run docker commands as normal, except add sudo to the commands. This will give permission to access the /var/run/docker.sock resource.

