# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

FROM centos:6
LABEL maintainer="Khosrow Moossavi <me@khosrow.io> (@khos2ow)"

RUN \
    yum clean metadata && \
    yum install -y epel-release && \
    yum clean metadata && \
    yum install -y \
        make \
        which \
        mlocate \
        tar \
        rpm-build \
        yum-utils \
        createrepo \
        mkisofs \
        git \
        java-1.8.0-openjdk-devel \
        tomcat6 \
        centos-release-scl \
        gcc \
        gcc-c++ \
        jq \
        wget \
        ws-commons-util \
        zlib-devel \
        bzip2-devel \
        openssl-devel \
        ncurses-devel \
        sqlite-devel \
        readline-devel \
        tk-devel \
        gdbm-devel \
        db4-devel \
        libpcap-devel \
        xz-devel \
        expat-devel

RUN wget --no-check-certificate http://python.org/ftp/python/2.7.14/Python-2.7.14.tar.xz && \
    tar xf Python-2.7.14.tar.xz && \
    cd Python-2.7.14 && \
    ./configure --prefix=/usr/local && \
    make && make altinstall && \
    wget https://bootstrap.pypa.io/get-pip.py && \
    python2.7 get-pip.py && \
    yum upgrade python-setuptools && \ 
    yum install -y mysql-connector-python

RUN wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo && \
    yum clean metadata && \
    yum install -y \
        apache-maven && \
    yum clean all && rm -rf /var/cache/yum && \
    sed -i "s/%dist .el7$/%dist .el7.centos/g" /etc/rpm/macros.dist

ENV JAVA_HOME=/usr/lib/jvm/java-1.8.0
ENV CATALINA_HOME=/usr/share/tomcat6/

VOLUME /mnt/build
WORKDIR /mnt/build

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
COPY environment-info.sh /usr/local/bin/environment-info.sh

ENTRYPOINT ["docker-entrypoint.sh"]
