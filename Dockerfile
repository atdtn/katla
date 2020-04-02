FROM centos:7

# Install the needed packages
RUN yum -y install epel-release
RUN yum -y install docker ansible openssh-server openssh-clients git python-lxml curl
RUN curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /bin/docker-compose

# Add SSH configuration
RUN mkdir /root/.ssh;
ADD ssh/authorized_keys /root/.ssh/authorized_keys
ADD ssh/id_rsa /root/.ssh/id_rsa
ADD ssh/id_rsa.pub /root/.ssh/id_rsa.pub
ADD ssh/known_hosts /root/.ssh/known_hosts
ADD entrypoint.sh /bin/entrypoint.sh
RUN chmod -R 700 /root/.ssh; \
    chmod 755 /bin/docker-compose; \ 
    chmod 755 /bin/entrypoint.sh

# Start with bash script
ENTRYPOINT /bin/entrypoint.sh && /bin/bash 
