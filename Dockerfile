FROM centos:7

# update and epel-release
RUN yum -y update && yum -y install epel-release

# basic tools
RUN yum -y install wget \
                   net-tools \
                   ns \
                   vim \
                   mc \
                   nc \
                   tcpdump

# asterisk dependencies
RUN yum -y install autoconf \
                   automake \
                   bzip2 \
                   gcc-c++ \
                   jansson-devel \
                   libtool \
                   libuuid-devel \
                   libxml2-devel \
                   ncurses-devel \
                   make \
                   pjproject \
                   sqlite-devel \
                   tar \
                   uuid-devel \
                   xmlstarlet

WORKDIR /usr/src

RUN wget http://downloads.asterisk.org/pub/telephony/asterisk/releases/asterisk-19.3.1.tar.gz && \
    tar -zxvf asterisk-19.3.1.tar.gz

RUN cd asterisk-19.3.1/contrib/scripts/ && \
    ./install_prereq install && \
    ./install_prereq install-unpackaged

RUN cd asterisk-19.3.1 && \
    ./configure --with-jansson-bundled && \
    make menuselect.makeopts && \
    menuselect/menuselect --disable BUILD_NATIVE \
                          --enable chan_pjsip \
                          --enable chan_sip \
                          --enable res_srtp \
                          --enable res_crypto \
                          --enable res_http_websocket \
                          --enable codec_opus \
                          --enable codec_silk \
                          --enable codec_g729a \
                          menuselect.makeopts && \
    make && \
    make install

RUN yum clean all

EXPOSE \
    5060/udp \
    5061/tcp \
    10000-10010/tcp \
    10000-10010/udp

# example scripts
COPY sip.conf /etc/asterisk/sip.conf
COPY http.conf /etc/asterisk/http.conf
COPY rtp.conf /etc/asterisk/rtp.conf
COPY modules.conf /etc/asterisk/modules.conf
COPY extensions.conf /etc/asterisk/extensions.conf

# change external ip address
COPY entrypoint.sh /
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]