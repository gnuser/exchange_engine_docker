#!/bin/bash

killall -s SIGQUIT envelope.exe
sleep 1
cd /envelope/matchengine && ./envelope.exe config.json
