#!/usr/bin/env bash

ffmpeg -re -stream_loop -1 -i $1 -vcodec copy -acodec aac -f flv rtmp://localhost/live/stream
