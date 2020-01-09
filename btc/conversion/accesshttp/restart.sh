#!/bin/bash

killall -s SIGQUIT cs_http.exe
sleep 1
cd /conversion/accesshttp && ./cs_http.exe config.json
