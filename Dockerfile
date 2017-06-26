
##################################################
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
## Big Data Lab
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
##################################################

FROM ubuntu:trusty
MAINTAINER Javier Espinosa <javier.espinosa@bsc.es>


##################################################
## Developer Tools 
##################################################

#-------------------------------------
#-- Basic Tools + Java 
#-------------------------------------
RUN apt-get update && apt-get install -y \
    build-essential \
    openjdk-7-jdk   \
    curl  \
    git   \
    jq    \
    nano  \
    ssh   \
    unzip \
    wget  

ENV JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64


#-------------------------------------
#-- Python & Libs
#-------------------------------------
RUN apt-get update && apt-get install -y python-dev && \
    curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && \
    python get-pip.py && \
    rm get-pip.py 

RUN pip install ipython \
    setuptools \
    matplotlib \
    nose   \
    numpy  \
    pandas \
    scipy  \
    sympy 


#-------------------------------------
#-- SSH 
#-------------------------------------   
RUN apt-get update && apt-get -y install openssh-server && \
    mkdir /var/run/sshd && \
    echo 'root:root' |chpasswd && \
    sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config && \
    /usr/sbin/sshd



##################################################
## Apache Pig Latin
##################################################

#-------------------------------------
#-- Download 
#-------------------------------------
RUN wget http://apache.rediris.es/pig/latest/pig-0.17.0.tar.gz

#-------------------------------------
#-- Install
#-------------------------------------
RUN tar -xvf pig-* && \
    rm pig-*.tar* &&  \
    mkdir -p /usr/local/apache/ && \   
    mv pig-* /usr/local/apache/pig

#-------------------------------------
#-- Config
#-------------------------------------
ENV PIG_HOME=/usr/local/apache/pig
ENV PATH=$PATH:$PIG_HOME/bin


##################################################
## Spark
##################################################

#-------------------------------------
#-- Download 
#-------------------------------------
RUN wget https://d3kbcqa49mib13.cloudfront.net/spark-2.1.1-bin-hadoop2.7.tgz

#-------------------------------------
#-- Install
#-------------------------------------
RUN tar -xvf spark-* && \
    rm  spark-*.tgz  && \
    mkdir -p /usr/local/apache/ && \
    mv spark-* /usr/local/apache/spark

#-------------------------------------
#-- Config
#-------------------------------------
ENV SPARK_HOME=/usr/local/apache/spark
ENV PATH=$PATH:$SPARK_HOME/bin


##################################################
## MongoDB
##################################################

#-------------------------------------
#-- Pre config
#-------------------------------------
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10 && \
    echo "deb http://repo.mongodb.org/apt/ubuntu "$(lsb_release -sc)"/mongodb-org/3.0 multiverse" | \
    tee /etc/apt/sources.list.d/mongodb-org-3.0.list    

#-------------------------------------
#-- Install
#-------------------------------------   
RUN apt-get update && apt-get install -y \
    mongodb-org 
 

#-------------------------------------
#-- Config 
#-------------------------------------
RUN mkdir -p /data/db


##################################################
## Node
##################################################

#-------------------------------------
#-- Install
#-------------------------------------   
RUN apt-get update && apt-get install -y \
    nodejs \
    npm 
 
#-------------------------------------
#-- Config 
#-------------------------------------
RUN ln -s `which nodejs` /usr/bin/node


##################################################
## Geospatial Data Abstraction Library (gdal)
##################################################

#-------------------------------------
#-- Dependencies
#-------------------------------------   

RUN apt-get install -y software-properties-common 

#-------------------------------------
#-- Install
#-------------------------------------   

RUN add-apt-repository ppa:ubuntugis/ppa && \
    apt-get update && \
    apt-get install -y gdal-bin
 


##################################################
## Hands-On
##################################################

#-------------------------------------
#-- D3 Map
#-------------------------------------   

RUN npm install -g \
    http-server \
    topojson@1.6.27


#-------------------------------------
#-- Sharding 
#-------------------------------------

RUN pip install jupyter \
    pymongo \
    plotly


##################################################
## Cleaning
##################################################

RUN rm -r /root/tmp

WORKDIR /root

