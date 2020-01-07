#!/bin/bash
MYSQL_ROOT_PASSWORD="root"

#!/bin/bash
mysql -uroot -p$MYSQL_ROOT_PASSWORD <<EOF
source $WORK_PATH/$FILE_0;
source $WORK_PATH/$FILE_1;
source $WORK_PATH/$FILE_2;

source $WORK_PATH/envelope/$FILE_1;

source $WORK_PATH/conversion/$FILE_0;
source $WORK_PATH/conversion/$FILE_1;

EOF
#
sh /docker-entrypoint-initdb.d/init_trade_history.sh1
sh /docker-entrypoint-initdb.d/envelope/init_trade_history.sh1
sh /docker-entrypoint-initdb.d/conversion/init_trade_history.sh1
