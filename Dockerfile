FROM shift/ubuntu:15.04

MAINTAINER Vincent Palmer <shift@someone.section.me>

RUN apt-get update \
    && apt-get install git-core python-pip python-dev \
      libzmq3-dev libzmq3 libyaml-dev libgit2-dev \
      libssh2-1-dev python-cffi pkg-config swig --yes --force-yes \
    && git clone https://github.com/saltstack/salt.git /opt/salt \
    && cd /opt/salt \
    && pip install -r requirements/base.txt \
    && pip install -r requirements/zeromq.txt \
    && pip install -r requirements/raet.txt \
    && pip install -r requirements/dev_python27.txt \
    && pip install pygit2 M2Crypto Mako msgpack_pure \
    && python setup.py install \
    && mkdir -p /etc/salt \
    && cp -av conf/* /etc/salt \
    && rm -rf /var/lib/apt/lists/*

VOLUME /etc/salt
VOLUME /srv/pillar
VOLUME /srv/salt
VOLUME /srv/reactor

# ZeroMQ ports
EXPOSE 4505/tcp
EXPOSE 4506/tcp
# RAET port
EXPOSE 4506/udp

