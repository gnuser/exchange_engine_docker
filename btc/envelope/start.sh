#! /bin/bash

./wait-deps.sh &&\
    echo ">>> envelope starting" &&\
    /envelope/matchengine/restart.sh &&\
    /btc/wait-for-it.sh 127.0.0.1:5316 --timeout=60 --quiet --strict -- \
    echo ">>> matchengine started on 7316"

echo ">>> accesshttp starting..." &&\
    /envelope/accesshttp/restart.sh &&\
    /btc/wait-for-it.sh 127.0.0.1:5080 --timeout=60 --quiet --strict -- \
    echo ">>> accesshttp started on 5080"

echo ">>> expire starting..." &&\
	/envelope/expire/restart.sh && \
	echo ">>> expire started"

ps -ef

touch /var/log/trade/envelope_matchengine.log
tail -f /var/log/trade/envelope_matchengine.log





