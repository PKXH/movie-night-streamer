#!/usr/bin/env bash

ffmpeg -re -ss 1:00:00 -i $1 -vcodec libx264 -acodec aac -f flv rtmp://localhost/ingest/stream
