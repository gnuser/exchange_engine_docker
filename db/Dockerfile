FROM mysql:5.7

MAINTAINER gnuser

ENV MYSQL_USER=mysql\
MYSQL_PASSWORD=mysql \
MYSQL_ROOT_PASSWORD=root

#定义shell文件名
ENV INSTALL_DATA_SHELL install-data.sh

ENV WORK_PATH /sql/

ENV FILE_0 create_trade_history.sql
ENV FILE_1 create_trade_log.sql
ENV FILE_2 create_trade_coin.sql

RUN mkdir -p $WORK_PATH
COPY sql/*.sql /sql/

COPY /sql/*.sh*  /docker-entrypoint-initdb.d/
RUN chmod a+x  /docker-entrypoint-initdb.d/$INSTALL_DATA_SHELL

RUN mkdir -p $WORK_PATH/envelope/
RUN mkdir -p /docker-entrypoint-initdb.d/envelope/
COPY envelope/*.sql /sql/envelope/


RUN mkdir -p $WORK_PATH/conversion/
RUN mkdir -p /docker-entrypoint-initdb.d/conversion/

COPY conversion/*.sql /sql/conversion/
COPY conversion/*.sh*  /docker-entrypoint-initdb.d/conversion/

EXPOSE 3306




