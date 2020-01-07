#!/bin/bash
MYSQL_ROOT_PASSWORD="root"

#!/bin/bash
mysql -uroot -p$MYSQL_ROOT_PASSWORD <<EOF
source $WORK_PATH/$FILE_0;
EOF
#
