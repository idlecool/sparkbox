FROM ubuntu:xenial
MAINTAINER Shiv Deepak (idlecool@gmail.com)

RUN apt-get -qq update && apt-get install -y curl git build-essential \
  libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev wget \
  llvm libncurses5-dev libncursesw5-dev xz-utils tk-dev && apt-get clean

RUN useradd -ms /bin/bash ubuntu
USER ubuntu
WORKDIR /home/ubuntu

RUN curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
RUN if [ `cat ~/.bashrc | grep pyenv | wc -l` -eq 0 ]; then printf 'export PATH="$HOME/.pyenv/bin:$PATH"\neval "$(pyenv init -)"\neval "$(pyenv virtualenv-init -)"\n' >> ~/.bashrc; fi;

ENV HOME /home/ubuntu
ENV PYENV_ROOT $HOME/.pyenv

ENV PATH=$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH
RUN eval "$(pyenv init -)"
RUN eval "$(pyenv virtualenv-init -)"
RUN pyenv install 3.5.3
RUN pyenv global 3.5.3
RUN pip install jupyter

USER root
