#!/usr/bin/env bash
ffmpeg -i $1 -c:v libx264 -c:a aac $1.out.mp4
