# hyla-docker-image
Docker Image to provision a container with Ruby 1.9, Hyla &amp; the gems required

# Developers

If you have to change the content definition of this image and generates a new docker image, here is the command to be used

    docker build -rm -t your-username/your-project .

To access to the docker container (= Fedora 20 OS) using bash

    docker run -t -i cmoulliard/hyla-ruby bash