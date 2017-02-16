
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

RUN apt-get update && apt-get install -y \
    build-essential \
    curl  \
    git   \
    jq \
    openjdk-7-jdk \
    nano  \
    ssh   \
    unzip \
    wget  

ENV JAVA_HOME=/usr/lib/jvm/java-1.7.0-openjdk-amd64

RUN apt-get update && apt-get install -y \
    ipython \
    ipython-notebook  \
    python-setuptools \
    python-matplotlib \
    python-nose   \
    python-numpy  \
    python-pandas \
    python-scipy  \
    python-sympy 


# Replace with apt-get install -y python-pip 
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py" && \
    python get-pip.py  


##################################################
## Apache Pig Latin
##################################################

#-------------------------------------
#-- Download 
#-------------------------------------
RUN wget http://apache.rediris.es/pig/latest/pig-0.16.0.tar.gz

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
RUN wget http://d3kbcqa49mib13.cloudfront.net/spark-1.6.2-bin-hadoop2.6.tgz

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
## Final Config
##################################################

WORKDIR /root


