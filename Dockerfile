FROM jenkins/jenkins:lts
EXPOSE 8080
EXPOSE 50000

USER root

RUN apt-get update 
RUN apt-get -y install maven
RUN apt-get -y install python-pip python-dev libffi-dev libssl-dev
RUN pip install ansible
RUN echo 'PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc

RUN apt-get -y install apt-transport-https ca-certificates curl software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian stretch stable"
RUN apt-get update
RUN apt-get -y install docker-ce

RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -
RUN apt-get install -y nodejs