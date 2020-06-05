# movie-night-streamer
Web-based movie streamer

##Installation
---
1. Install **webfs** web server (via your favorite package installer)
2. Install **nginx**+**rtmp** (use instructions [here](https://www.nginx.com/blog/video-streaming-for-remote-learning-with-nginx/))
3. Add *viewer.html* and *index.html* symlinks to the web root directory.
4. Add *nginx.conf* symlink to replace installation *nginx.conf*
5. Create working directory for working with videos.
6. Symlink command *.sh* scripts into working directory.
7. Add videos to be streamed to working directory.

##Run Procedure
---
1. Start viewer page web server: `sudo webfsd -F -p 8081 -f index.html`
2. Verify reverse proxy server configuration squares: `sudo nginx -t`
3. Start reverse proxy server: `sudo nginx`    
4. Start playing movie file *movie.mp4*: `./reel.sh movie.mp4` 
   **OR** start playing movie file *movie.mp4* on an endless loop: `./loop.sh movie.mp4`

##Shutdown Procedure
---
1. Stop reverse proxy server: `sudo nginx -s stop`
2. Stop viewer page web server with `ctrl-C`.
