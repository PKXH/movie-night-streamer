#!/usr/bin/env bash

ffmpeg -re -stream_loop -1 -i "$1" -vcodec libx264 -acodec aac -f flv rtmp://localhost/ingest/stream
