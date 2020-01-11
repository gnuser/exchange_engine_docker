FROM ubuntu:xenial AS btc-build

MAINTAINER gnuser

RUN sed -i "s/archive.ubuntu./mirrors.aliyun./g" /etc/apt/sources.list

RUN apt-get update &&\
    apt-get install -y wget vim psmisc &&\
	# 依赖包
	apt-get -y install libev-dev libssl-dev libmpdec-dev libjansson-dev libmysqlclient-dev libcurl4-openssl-dev &&\
 	# 安装构建工具
	apt-get install -y  build-essential autoconf libtool python cmake &&\
	# 清理
	#rm -rf /var/lib/apt/lists/* &&\
	# 建立工作目录
	mkdir /src/ &&\
	cd /src

WORKDIR /src/

# 安装kafka
RUN wget https://codeload.github.com/edenhill/librdkafka/tar.gz/v0.11.3 -O  /src/librdkafka.tar.gz &&\
	tar xzvf /src/librdkafka.tar.gz &&\
	rm -rf /src/librdkafka.tar.gz
#	mv librdkafka-* librdkafka &&\
RUN ls /src/
RUN	cd /src/librdkafka-* &&\
  	./configure --prefix=/usr/local &&\
  	sed -i "s/WITH_LDS=/#WITH_LDS=/g" Makefile.config &&\
  	make &&\
  	make install

# 安装 curl
RUN wget https://codeload.github.com/curl/curl/tar.gz/curl-7_57_0 -O /src/curl-7.57.0.tar.gz &&\
	tar xzvf /src/curl-7.57.0.tar.gz &&\
	rm -rf /src/curl-7.57.0.tar.gz &&\
	mv curl-* curl &&\
	cd /src/curl &&\
	./buildconf &&\
	./configure --prefix=/usr/local --disable-shared --enable-static --without-libidn --without-ssl --without-librtmp --without-gnutls --without-nss --without-libssh2 --without-zlib --without-winidn --disable-rtsp --disable-ldap --disable-ldaps --disable-ipv6 &&\
	make &&\
	make install

# 必须装完kafka才能装lz4,可能是版本选冲突了
RUN apt-get install -y liblz4-dev 


ADD build.sh /src/build.sh

# 编译viabtc
RUN wget https://codeload.github.com/gnuser/exchange_engine/tar.gz/master -O /src/viabtc.tar.gz &&\
 	tar xzvf /src/viabtc.tar.gz  &&\
 	rm -rf /src/viabtc.tar.gz &&\
 	mv exchange_engine-master/exchange_server* viabtc &&\
    cd /src/viabtc/network &&\
    make clean && make &&\
    cd /src/viabtc/depends/hiredis &&\
    make && make install &&\
    cd /src/viabtc/utils/ &&\
    make

# 编译红包和微交易
RUN wget https://codeload.github.com/gnuser/xpay_server/tar.gz/master -O /src/xpay.tar.gz &&\
        tar xzvf /src/xpay.tar.gz  &&\
        rm -rf /src/xpay.tar.gz &&\
        mv xpay_server-master/envelope_server* envelope &&\
	mv xpay_server-master/conversion_server* conversion &&\
    cd /src/conversion/network &&\
    make clean && make &&\
    cd /src/conversion/utils/ &&\
    make &&\
    cd /src/envelope/network &&\
    make clean && make &&\
    cd /src/envelope/utils/ &&\
    make

RUN /bin/bash /src/build.sh

WORKDIR /btc/

CMD /bin/bash

FROM btc-build

COPY /btc/ /btc/
COPY /envelope/ /envelope/
COPY /conversion/ /conversion/

RUN mkdir -p /var/log/trade &&\
	mv /src/viabtc/matchengine/matchengine.exe  /btc/matchengine/ &&\
	mv /src/viabtc/accesshttp/accesshttp.exe  /btc/accesshttp/ &&\
	mv /src/viabtc/marketprice/marketprice.exe  /btc/marketprice/ &&\
	mv /src/viabtc/accessws/accessws.exe  /btc/accessws/ &&\
	mv /src/viabtc/alertcenter/alertcenter.exe  /btc/alertcenter/ &&\
	mv /src/viabtc/readhistory/readhistory.exe  /btc/readhistory/

RUN mv /src/envelope/matchengine/envelope.exe /envelope/matchengine/ &&\
	mv /src/envelope/accesshttp/el_http.exe /envelope/accesshttp/ &&\
	mv /src/envelope/expire/envelope_expired /envelope/expire/

RUN mv /src/conversion/matchengine/conversion.exe /conversion/matchengine/ &&\ 
        mv /src/conversion/accesshttp/cs_http.exe /conversion/accesshttp/ 

RUN chmod +x /btc/*/*.sh &&\
	chmod +x /btc/*.sh &&\
	chmod +x /btc/*/*.exe &&\
	chmod +x /envelope/*.sh &&\
	chmod +x /envelope/*/*.sh &&\
	chmod +x /envelope/*/*.exe &&\
	chmod +x /conversion/*.sh &&\
	chmod +x /conversion/*/*.sh &&\
	chmod +x /conversion/*/*.sh &&\
	chmod +x /envelope/expire/envelope_expired

# marketprice
EXPOSE 7416
# matchengine
EXPOSE 7316
# matchengine cli
EXPOSE 7317
# readhistory
EXPOSE 7424
# alertcenter
EXPOSE 4444
# accesshttp
EXPOSE 8080

# monitor
EXPOSE 8081

# monitor
EXPOSE 8091


# envelope matchengine
EXPOSE 5316

# accesshttp
EXPOSE 5080

# conversion
EXPOSE 6316

# accesshttp
EXPOSE 6080

ENV LD_LIBRARY_PATH /usr/local/lib

CMD /btc/start.sh  
#&& /envelope/start.sh && /conversion/start.sh
