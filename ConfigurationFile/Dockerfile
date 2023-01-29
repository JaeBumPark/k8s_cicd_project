FROM jenkins/jenkins:lts

USER root

RUN apt-get update \
 && apt-get -y install lsb-release openjdk-11-jdk \
 && curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg \
 && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null \
 && apt-get update \
 && apt-get -y install docker-ce docker-ce-cli containerd.io
RUN groupmod -g 998 docker && \
    usermod -aG docker jenkins

USER jenkins
~                               
