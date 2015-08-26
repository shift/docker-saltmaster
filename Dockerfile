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
    && pip install pygit2 M2Crypto Mako msgpack_pure GitPython \
    && pip install -i https://pypi.binstar.org/pypi/simple python-etcd \
    && python setup.py install \
    && mkdir -p /etc/salt /var/log/salt \
    && cp -av conf/* /etc/salt \
    && rm -rf /var/lib/apt/lists/* \
    && echo "Host github.com\n  IdentityFile /etc/salt/repo.key" \
    && ssh-keyscan -H github.com > /etc/ssh/ssh_known_hosts \
    && ssh-keyscan -H bitbucket.com >> /etc/ssh/ssh_known_hosts

VOLUME /etc/salt
VOLUME /srv/pillar
VOLUME /srv/salt
VOLUME /srv/reactor
VOLUME /var/log/salt

# ZeroMQ ports
EXPOSE 4505/tcp
EXPOSE 4506/tcp
# RAET port
EXPOSE 4506/udp

