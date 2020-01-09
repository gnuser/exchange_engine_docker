#!/bin/bash

killall -s SIGQUIT envelope_expired
sleep 1
cd /envelope/expire && nohup ./envelope_expired 2>&1 & 
