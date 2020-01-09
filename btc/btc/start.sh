#! /bin/bash

./wait-deps.sh &&\
    echo ">>> matchengine starting" &&\
    /btc/matchengine/restart.sh &&\
    /btc/wait-for-it.sh 127.0.0.1:7316 --timeout=60 --quiet --strict -- \
    echo ">>> matchengine started on 7316"

echo ">>> readhistory starting" &&\
    /btc/readhistory/restart.sh &&\
    /btc/wait-for-it.sh 127.0.0.1:7424 --timeout=60 --quiet --strict -- \
    echo ">>> readhistory started on 7424"

echo ">>> alertcenter starting..." &&\
    /btc/alertcenter/restart.sh &&\
    /btc/wait-for-it.sh 127.0.0.1:4444 --timeout=60 --quiet --strict -- \
    echo ">>> alertcenter started on 4444"

echo ">>> accesshttp starting..." &&\
    /btc/accesshttp/restart.sh &&\
    /btc/wait-for-it.sh 127.0.0.1:8080 --timeout=60 --quiet --strict -- \
    echo ">>> accesshttp started on 8080"


echo ">>> accessws starting..." &&\
    /btc/accessws/restart.sh &&\
    /btc/wait-for-it.sh 127.0.0.1:8091 --timeout=60 --quiet --strict -- \
    echo ">>> accessws started on 8091"

echo ">>> marketprice starting..." &&\
    /btc/marketprice/restart.sh &&\
    /btc/wait-for-it.sh 127.0.0.1:7416 --timeout=60 --quiet --strict -- \
    echo ">>> marketprice started on 7416"

touch /var/log/trade/matchengine.log
tail -f /var/log/trade/matchengine.log

./wait-deps.sh &&\
    echo ">>> envelope starting" &&\
    /envelope/matchengine/restart.sh &&\
    /btc/wait-for-it.sh 127.0.0.1:5316 --timeout=60 --quiet --strict -- \
    echo ">>> matchengine started on 7316"

echo ">>> accesshttp starting..." &&\
    /envelope/accesshttp/restart.sh &&\
    /btc/wait-for-it.sh 127.0.0.1:5080 --timeout=60 --quiet --strict -- \
    echo ">>> accesshttp started on 5080"

touch /var/log/trade/envelope_matchengine.log
tail -f /var/log/trade/envelope_matchengine.log

./wait-deps.sh &&\
    echo ">>> conversion matchengine starting" &&\
    /conversion/matchengine/restart.sh &&\
    /btc/wait-for-it.sh 127.0.0.1:6316 --timeout=60 --quiet --strict -- \
    echo ">>> conversion matchengine started on 6316"

echo ">>> conversion accesshttp starting..." &&\
    /conversion/accesshttp/restart.sh &&\
    /btc/wait-for-it.sh 127.0.0.1:6080 --timeout=60 --quiet --strict -- \
    echo ">>> conversion accesshttp started on 6080"

echo ">>> expire starting..." &&\
        /envelope/expire/restart.sh && \
        echo ">>> expire started"

ps -ef

touch /var/log/trade/conversion_matchengine.log
tail -f /var/log/trade/conversion_matchengine.log





