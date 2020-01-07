#! /bin/bash

./wait-deps.sh &&\
    echo ">>> envelope starting" &&\
    /btc/envelope/matchengine/restart.sh &&\
    /btc/wait-for-it.sh 127.0.0.1:5316 --timeout=60 --quiet --strict -- \
    echo ">>> matchengine started on 7316"

echo ">>> accesshttp starting..." &&\
    /btc/envelope/accesshttp/restart.sh &&\
    /btc/wait-for-it.sh 127.0.0.1:5080 --timeout=60 --quiet --strict -- \
    echo ">>> accesshttp started on 5080"

echo ">>> expire starting..." &&\
	/btc/envelope/expire/restart.sh && \
	echo ">>> expire started"

ps -ef

touch /var/log/trade/envelope/matchengine.log
tail -f /var/log/trade/envelope/matchengine.log





