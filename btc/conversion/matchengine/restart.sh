#!/bin/bash

killall -s SIGQUIT conversion.exe
sleep 1
cd /btc/conversion/matchengine && ./conversion.exe config.json
