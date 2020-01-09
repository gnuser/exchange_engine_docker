#!/bin/bash

killall -s SIGQUIT el_http.exe
sleep 1
cd /envelope/accesshttp && ./el_http.exe config.json
