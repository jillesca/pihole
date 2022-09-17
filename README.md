# pihole

Docker compose for pihole running on raspberry pi

## Pi-hole `v5.12.1` issue with libseccomp

While updating pihole to Docker Tag `2022.09.3` Pi-hole `v5.12.1` FTL `v5.18` Web Interface `v5.15` release had an issue with libseccomp

Errors were like:
```bash
pi@raspberrypi:~/pihole$ docker ps
CONTAINER ID   IMAGE                  COMMAND      CREATED          STATUS                           PORTS     NAMES
5514ece8b4b9   pihole/pihole:latest   "/s6-init"   20 seconds ago   Restarting (111) 3 seconds ago             pihole
pi@raspberrypi:~/pihole$ docker logs pihole
s6-svscan: warning: unable to iopause: Operation not permitted
s6-svscan: warning: executing into .s6-svscan/crash
s6-svscan crashed. Killing everything and exiting.
s6-linux-init-hpr: fatal: unable to reboot(): Operation not permitted
```

Fixed it with these commands:

```bash
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 04EE7237B7D453EC 648ACFD622F3D138
echo "deb http://deb.debian.org/debian buster-backports main" | sudo tee -a /etc/apt/sources.list.d/buster-backports.list
sudo apt update
sudo apt install -t buster-backports libseccomp2
```
[Source](https://www.reddit.com/r/pihole/comments/tz1hf3/comment/i3w0uhb)

     
## Some usefuls commands

See open ports on the containers
<https://raspberrypi.stackexchange.com/questions/69123/how-to-open-a-port>

```
sudo netstat -lptu
```
