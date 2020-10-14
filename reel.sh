#!/usr/bin/env bash

ffmpeg -re -i "$1" -vcodec copy -acodec copy -f flv rtmp://localhost/live/stream
