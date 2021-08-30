FROM jenkins/ssh-agent:jdk11
RUN apt update
RUN apt install default-jre -y
RUN apt install default-jdk -y
RUN apt-get install -y apt-transport-https ca-certificates curl software-properties-common
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
RUN apt-key fingerprint 0EBFCD88
RUN apt-get update
RUN apt-get install -y docker.io
COPY docker.sock /var/run/docker.sock
RUN chmod +777 -R /var/run/docker.sock

