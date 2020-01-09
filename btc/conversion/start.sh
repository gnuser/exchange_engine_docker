#! /bin/bash

./wait-deps.sh &&\
    echo ">>> conversion matchengine starting" &&\
    /conversion/matchengine/restart.sh &&\
    /btc/wait-for-it.sh 127.0.0.1:6316 --timeout=60 --quiet --strict -- \
    echo ">>> conversion matchengine started on 6316"

echo ">>> conversion accesshttp starting..." &&\
    /conversion/accesshttp/restart.sh &&\
    /btc/wait-for-it.sh 127.0.0.1:6080 --timeout=60 --quiet --strict -- \
    echo ">>> conversion accesshttp started on 6080"

ps -ef

touch /var/log/trade/conversion_matchengine.log
tail -f /var/log/trade/conversion_matchengine.log





