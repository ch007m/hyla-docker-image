# Hyla - Ruby Docker Image

This Docker Image allows to provision a Docker container with Ruby 1.9, Hyla &amp; the gems required. It uses as Base OS Image __Fedora 21__

# Developer

If you would like to change the content definition of this image and generates a new docker image, here is the command to be used

    docker build -rm -t your-username/your-project .

Remark : Do not forget to fork the project in that case.

# Technical Writer

To launch the docker container and use the bash terminal to run the hyla commands, tun this command

    docker run -t -i cmoulliard/hyla-ruby bash


To mount the directory containing your project, use the -v option

	docker run -t -i -v /path/on/your/machine/to/the/content:/home/default/content cmoulliard/hyla-ruby bash    