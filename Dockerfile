# Dockerfile for a Hyla Ruby container.
#
# Provides an environment for running Hyla Ruby command line tool.

FROM       ubuntu:14.04
MAINTAINER Charles Moulliard <ch007m@gmail.com>

# Update environement
RUN apt-get update -qq -y
RUN apt-get install -qq -y \
    sudo                   \
    git                    \
    curl                   \
    build-essential        \
    autoconf               \
    man                    \
    libreadline-dev        \
    libssl-dev             \
    libxml2-dev            \
    libxslt-dev            \
    zlib1g-dev             \
    libbz2-dev

RUN useradd -m -s /bin/bash default
RUN chgrp -R default /usr/local
RUN find /usr/local -type d | xargs chmod g+w

RUN echo "default ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/default
RUN chmod 0440 /etc/sudoers.d/default

ENV     HOME /home/default
WORKDIR /home/default
USER    default

# Install Ruby Build to manage the Ruby version
ADD https://github.com/sstephenson/ruby-build/archive/v20140524.tar.gz /tmp/

RUN cd /tmp;                           \
    sudo chown default: *.tar.gz;      \
    tar xvzf *.tar.gz; rm -f *.tar.gz; \
    cd ruby-build*;                    \
    ./bin/ruby-build 1.9.3p484 /usr/local; \
    cd; rm -rf /tmp/ruby-build*

RUN gem install bundler pry --no-rdoc --no-ri

# Git clone Hyla
ADD https://github.com/cmoulliard/hyla/archive/master.zip /tmp/

RUN cd /tmp;                           \
      sudo chown default: *.zip;       \ 
      unzip *.zip; rm -rf *.gz;        \
      cd hyla-master;                  \
      gem build hyla.gemspec;          \
      ruby -e "Dir.glob('*.gem').each {|i| puts exec(\"gem install #{i} -l\")}"

