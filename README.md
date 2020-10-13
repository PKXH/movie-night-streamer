# movie-night-streamer
A Web-based ffmpeg-sourced movie streamer with dynamic bitrate throttling

I've used this to host to about 10 people on a cheap, piddly, un-accelerated AWS EC2 micro instance (running Ubuntu) with no problems, but you'll probably want to make sure you get all the bugs worked out on a local machine first before you start paying for cpu and bandwidth usage. 

If you decide to edit the `nginx.conf` to enable DASH encoding, or to add more dynamic bitrate throttling resolutions for HLS, you may want to opt for a hosting intance with some GPU-acceleration. (Note that I usually pre-emptively transcode my videos down to about a 1600kbps bitrate, & tuned for fast decoding, but you probably won't have to be so aggressive with some GPU. Also, if you're using the "remote livestream option" below, programs like [OBS](https://obsproject.com) will let you soft-cap the bitrate locally, which might allow you to transfer some of the load to your local machine. Anyway, just mess around with it and find a balance that works for you :)

**Also:** if you're using a cloud server to bounce the stream out to everybody ***do not forget to stop the instance when you're done*** or your compute provider will be more-than-happy to keep charging you for the uptime!

## Installation
#### (do this on the machine people will be connecting to)
1. Install **webfs** web server (via your favorite package installer)
2. Install **nginx**+**rtmp** (use instructions [here](https://www.nginx.com/blog/video-streaming-for-remote-learning-with-nginx/))
3. Add *viewer.html* and *index.html* symlinks to the web root directory.
4. Add *nginx.conf* symlink to replace installation *nginx.conf*
5. Create a directory to hold your videos.
6. Symlink command *.sh* scripts into this same directory.
7. Add videos to be streamed to the same directory.
8. Unblock ports **80**, **1935**, and **8080-8081** if firewalled.

## Run Procedure
#### (do this on the machine people will be connecting to)
1. Start viewer page web server: `sudo webfsd -F -p 8081 -f index.html`
2. Verify that the reverse proxy server configuration squares: `sudo nginx -t`
3. Start reverse proxy server: `sudo nginx`

### remote command line-based option
#### (do this on the machine that people will be connecting to)
4. On a console connected to your server, go to the video directory and start playing movie file *movie.mp4*: `./reel.sh movie.mp4` 
   **OR** start playing movie file *movie.mp4* on an endless loop: `./loop.sh movie.mp4`

### remote livestream option
#### (do this on your local machine if you want to use the nginx machine purely as a re-streamer)
4. Set up an ssh tunnel to forward rtmp port **1935** from your local machine to the server on which you're running nginx & webfs **OR** make sure port **1935** is unblocked on the remote server
5. Play your video using your local rtmp-stream capable app ([OBS](https://obsproject.com), [VLC](https://www.videolan.org/vlc/index.html), [ffmpeg](http://trac.ffmpeg.org/wiki/StreamingGuide), etc.) and (if ssh-tunneling) set it to rtmp-stream to `rtmp://localhost:1935/ingest/stream` **OR** (if port-connecting) set it to rtmp-stream to `rtmp://<your nginx machine's ip address>:1935/ingest/stream` (note that for security you can change the "stream" portion of the URL to a less-predictable custom stream-key by changing the name of the "stream" application context in `nginx.conf`)

At this point, your video should be visible at `http://<your nginx machine's ip address>:8081/viewer.html`. Enjoy!

## Shutdown Procedure
1. Stop reverse proxy server: `sudo nginx -s stop`
2. Stop viewer page web server with `ctrl-C`.
