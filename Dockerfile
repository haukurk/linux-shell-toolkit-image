FROM centos:7
LABEL maintainer "Haukur Kristinsson <haukur@hauxi.is>"

# Persisted data
VOLUME /persistance

# Private Key
WORKDIR ~/.ssh
COPY id_rsa .

# yum update
RUN yum -y update && yum clean all
RUN yum install epel-release -y
RUN yum install unzip git nmap gcc-c++ sudo make telnet wget lynx netcat python-pip -y

# Node
RUN curl -sL https://rpm.nodesource.com/setup_6.x | sudo -E bash -
RUN yum install nodejs -y

# Python
RUN pip install --upgrade pip

# Java
WORKDIR /opt/
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jdk-8u131-linux-x64.tar.gz"
RUN tar xzf jdk-8u131-linux-x64.tar.gz && rm *.tar.gz
ENV JAVA_HOME="/opt/jdk1.8.0_131"
ENV JRE_HOME="/opt/jdk1.8.0_131/jre"
RUN wget http://www-eu.apache.org/dist/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz
RUN tar xzf apache-maven-3.3.9-bin.tar.gz
RUN rm *.gz
RUN ln -s apache-maven-3.3.9 maven
ENV M2_HOME="/opt/maven" 

# Scala
WORKDIR /root
RUN wget http://downloads.lightbend.com/scala/2.11.8/scala-2.11.8.rpm
RUN yum install scala-2.11.8.rpm -y
RUN rm *.rpm

# Go
WORKDIR /tmp
RUN curl -LO https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz
RUN tar -C /usr/local -xvzf go1.8.linux-amd64.tar.gz
RUN mkdir -p /persistance/go/projects/{bin,pkg,src}
ENV GOBIN="$HOME/projects/bin"
ENV GOPATH="$HOME/projects/src"
ENV GOROOT="/usr/local/go"

# Other tools
RUN npm install -g http-server
WORKDIR /tmp
RUN wget https://releases.hashicorp.com/terraform/0.9.8/terraform_0.9.8_linux_amd64.zip
RUN unzip terraform_0.9.8_linux_amd64.zip
RUN rm terraform_0.9.8_linux_amd64.zip
RUN cp terraform /usr/local/bin/terraform
RUN pip install --upgrade --user awscli
RUN npm install -g vtop
RUN npm install -g public-ip

ENV PATH="/opt/maven/bin/:/usr/local/go/bin:/opt/jdk1.8.0_131/bin:/opt/jdk1.8.0_131/jre/bin:${PATH}"