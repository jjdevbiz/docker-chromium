# docker-chromium
* start
```docker run --rm -v /home/$HOME/.chromium-docker/:/home/docker/.config/chromium -p 55560:22 jjdevbiz/chromium &```

* ghetto tmux daemon of session (req: tmux, sshpass, pulseaudio)
```tmux new -s chromium -d "sshpass -p 'docker' ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no docker-chromium 'pulseaudio --start && export PULSE_SERVER=tcp:localhost:64713 && chromium-browser'"```
