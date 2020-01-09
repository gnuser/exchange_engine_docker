#!/bin/bash

killall -s SIGQUIT conversion.exe
sleep 1
cd /conversion/matchengine && ./conversion.exe config.json
