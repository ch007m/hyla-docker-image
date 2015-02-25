# Hyla - Ruby Docker Image

This Docker Image allows to provision a Docker container with Ruby 1.9, Hyla &amp; the gems required. It uses as Base OS Image __Fedora 21__

# Developer

If you would like to change the content definition of this image and generates a new docker image, here is the command to be used

    docker build -rm -t your-username/your-project .

Remark : Do not forget to fork the project in that case.

# Technical Writer

## Prerequisite

- Install the Docker server and client on your machine ([MacOS»(https://docs.docker.com/installation/mac/), [Windows](https://docs.docker.com/installation/windows/), [Fedora](https://docs.docker.com/installation/fedora/), ...).

## Procedure

What you should do to use the __hyla ruby__ command line tool consists in starting a Docker container and pass as paramzter the bash function. That will tell to Docker to book a container created from the image definition and when the contaienr is started, a bash terminal will be launched. So run this command.

    docker run -t -i cmoulliard/hyla-ruby bash   

To mount the directory containing your project, use the -v option

	docker run -t -i -v /path/on/your/machine/to/the/content:/home/default/content cmoulliard/hyla-ruby bash    

When the bash prompt appears, you can run the hyla command to render the content of the folder mounted

```
hyla generate -s . -d generated_content -b HTML5 -r index2html -a stylesdir=/home/default/.rbenv/versions/1.9.3-p484/lib/ruby/gems/1.9.1/gems/hyla-1.0.6/lib/resources/styles/

Config file to be parsed : /home/default/content/modules/1_Introduction_to_Messaging/_config.yaml
No configuration file retrieved for the name : _config.yaml
Rendering : Asciidoctor Indexed Files to HTML
>>       Source dir: /home/default/content/modules/1_Introduction_to_Messaging
>>  Destination dir: /home/default/content/modules/1_Introduction_to_Messaging/generated_content
>>       Current dir: /home/default/content/modules/1_Introduction_to_Messaging
>>        Dir of html: /home/default/content/modules/1_Introduction_to_Messaging/generated_content/.
>> File to be rendered : AllSlides.txt
>>        Dir of html: /home/default/content/modules/1_Introduction_to_Messaging/generated_content/.
```

Remark : The location of the styles can change according to the version of hyla deployed. So change ../hyla-1.0.6/.. to the version deployed to the variable of stylesdir.
