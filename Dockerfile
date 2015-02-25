# Dockerfile for a Hyla Ruby container.
#
# Provides an environment for running Hyla Ruby command line tool.

#
# FROM       fedora:20 
# error: unpacking of archive failed on file /usr/bin/systemd-detect-virt: cpio: cap_set_file
# error: systemd-208-30.fc20.x86_64: install failed
#

FROM         centos:7
MAINTAINER Charles Moulliard <ch007m@gmail.com>

# Execute system update
RUN yum -y update; yum clean all

# Install packages necessary to deploy Ruby
RUN yum -y install \
    git            \
    wget           \
    unzip          \
    tar            \
    gcc            \
    libtool        \
    make           \
    && yum clean all

#
# Create a user and group used to launch processes
# The user ID 1000 is the default for the first "regular" user on Fedora/RHEL,
# so there is a high chance that this ID will be equal to the current user
# making it easier to use volumes (no permission issues)
#
RUN groupadd -r default -g 1000 && useradd -u 1000 -r -g default -m -d /home/default -s /sbin/nologin -c "Default user" default    

# Set the working directory to default' user home directory
WORKDIR /home/default

USER default

#
# Install Ruby RBENV & Ruby-Build to manage the Ruby version
#
RUN git clone https://github.com/sstephenson/rbenv.git ~/.rbenv

RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bash_profile
RUN echo 'eval "$(rbenv init -)"' >> ~/.bash_profile

ENV HOME /home/default
ENV RBENV $HOME/.rbenv 
ENV PATH $RBENV/bin:$PATH

RUN mkdir -p ~/.rbenv/plugins/
RUN git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build

RUN rbenv install 1.9.3-p484; rbenv global 1.9.3-p484

# Ruby Path
ENV RUBY_VERSION rbenv version-name
ENV PATH         $RBENV/versions/$RUBY_VERSION/bin:$PATH"

# 
# Install Ruby Bundler & Pry
#
# RUN gem install bundler pry --no-rdoc --no-ri

# 
# Git clone Hyla, unzip the file
#
RUN mkdir -p /home/default/tmp; \
    curl -sf -o /home/default/tmp/hyla-master.zip -L https://github.com/cmoulliard/hyla/archive/master.zip; \
    cd /home/default/tmp/; \
    unzip hyla-master.zip

# 
# Build Hyla & install it
#
RUN cd hyla-master;                  \
    gem build hyla.gemspec

#       ruby -e "Dir.glob('*.gem').each {|i| puts exec(\"sudo gem install #{i}\")}"

