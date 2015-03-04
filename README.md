# Hyla & Ruby Docker Image

This Docker Image uses as base OS Image __Fedora 21__ and allows to provision a Docker container with :

* __Ruby__ 1.9.3
* [Rbenv - Tool to manage the Ruby version installed](https://github.com/sstephenson/rbenv)
* [Ruby-Build - Tool to install Ruby](https://github.com/sstephenson/ruby-build)
* [Hyla - Asciidoctor Content Generator](https://github.com/cmoulliard/hyla)

Hyla is a Ruby command line tool to create a new documentation/training/blog/static web site project, add artefacts (articles, blog, audio, video, content, code source, …), render it in HTML, SlideShow, … using asciidoc(tor) as markup language.

Until now, hyla looks like asciidoctor client but is is more similar to Jekyll on the principle but here we support asciidoc, asciidoctor formats and not markdown.

The tool allows to :

* Generate slideshow presentations (deckJs, RevealJS) - https://twitter.com/cmoulliard/status/421587832159756288,
* Setup a blank project,
* Setup a project from template (book, training, training-exercises, documentation/training content, …
* Create a documentation/training project (including directories + files) from a Table of Content
* Generate a one HTML file (= sum of all the asciidoc files) for slideshow (or trainer presentation) using index files (= file containing links to include other files)
* Render html content from asciidoc (http://asciidoctor.org/docs/user-manual)
* Render html using different styles
* Watch files (LiveReload - WebSocket) and render them if a modification has been detected or file added …

It is not a replacement or a concurrent of awestruct. Idea is to package in hyla css styles, backends, samples (article, image, table, audio, video, book, report) and collection of templates (blog, static web site, awestruct, training, documentation = collection of modules, … ) to boost process to develop documentation, training content (reason why hyla will assist you to create from a Table of content the structure of directories + asciidoc files (a file = a chapter =a module)), blog web, book, articles, static web site site … without the need to install git projects (everything is packaged in one tool like jekyll).

More info about the project can be find here : 

* [Hyla](https://github.com/cmoulliard/hyla)
* [Docker Image - Hyla & Ruby](https://github.com/cmoulliard/hyla-docker-image#technical-writer)

# Technical Writer

## Prerequisite

- Install the Docker server and client on your machine ([MacOS](https://docs.docker.com/installation/mac/), [Windows](https://docs.docker.com/installation/windows/), [Fedora](https://docs.docker.com/installation/fedora/), ...).

## Procedure

What you should do to use the __hyla ruby__ command line tool consists in starting a Docker container and pass as paramzter the bash function. That will tell to Docker to book a container created from the image definition and when the contaienr is started, a bash terminal will be launched. So run this command.

    docker run -t -i -p 7000:7000 cmoulliard/hyla-ruby bash   

To mount the directory containing your project, use the -v option. The first part of the value is your local path while the second (placed after the : character) is where it will be mounted into the Docker container.

    docker run -t -i -p 7000:7000 -v /path/on/your/machine/to/the/content:/home/default/content cmoulliard/hyla-ruby bash    

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

# Developer

If you would like to change the content definition of this image and generates a new docker image, here is the command to be used

    docker build -rm -t your-username/your-project .

Remark : Do not forget to fork the project in that case.
