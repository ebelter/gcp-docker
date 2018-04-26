# Google Cloud Engine SDK Docker

This docker has has the gcloud and gsutil commands to interact with GCE

# How To Build

## User - YOU!

The dockerfile is configured to create a user inside the docker container. Pass the desired user name as build arg when building the docker image.

## Home Directory

This docker will build using the contents of a directory insidethe docker context named 'homedir' as the user's home directory. Put whatever you want copied into the container into this 'homedir' directory. Git can be used to store bash config, commands, etc., and cloned into this directory to have access to it in the container.

## Building

$ docker build --build-arg username=$YOU -t $YOU/gc-sdk:latest .

# Running

An example to run this container, setting $YOU as the user and /home/$YOU as the working directory. It also adds the .ssh directory as GCE tools use SSH to access instances. It also sets the hostname, so you know you inside a GCE docker!

$ docker run -it --rm -h gc-sdk --workdir /home/$YOU --user $YOU -v /Users/$YOU/.ssh:/home/$YOU/.ssh $YOU/gc-sdk:latest /bin/bash
