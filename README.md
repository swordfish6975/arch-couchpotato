
this is a copy of binhex docker build script for couchpotato, it points to my updated (dev branch) version of couchpotato with IPtorrents working again.

to build:

**(if required)**
```
docker stop couchpotato   
docker rm couchpotato
```

```
docker build --no-cache https://github.com/swordfish6975/arch-couchpotato.git -t swordfish6975/couchpotato-dev
```

**(customise for your setup)**
```
docker run -d \ 
    -p 5050:5050 \
    --name=couchpotato \
    -v /mnt/Backup/MOVIES:/media \
    -v /mnt/Files/Raspberry/downloads/UNPROCESSED/MOVIES:/data \
    -v /apps/docker/couchpotato:/config \
    -v /etc/localtime:/etc/localtime:ro \
    -e PUID=0 \
    -e PGID=0 \
    swordfish6975/couchpotato-dev:latest
```


**Application**

[CouchPotato](http://couchpota.to)

**Description**

Awesome PVR for usenet and torrents. Just fill in what you want to see and CouchPotato will add it to your "want to watch"-list. Every day it will search through multiple NZBs & Torrents sites, looking for the best possible match. If available, it will download it using your favorite download software.

**Build notes**

Latest stable CouchPotato release from Arch Linux AUR.

**Usage**
```
docker run -d \
    -p 5050:5050 \ 
    --name=<container name> \
    -v <path for media files>:/media \
    -v <path for data files>:/data \
    -v <path for config files>:/config \
    -v /etc/localtime:/etc/localtime:ro \
    -e UMASK=<umask for created files> \
    -e PUID=<uid for user> \
    -e PGID=<gid for user> \
    binhex/arch-couchpotato
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

`http://<host ip>:5050`

**Example**
```
docker run -d \
    -p 5050:5050 \ 
    --name=couchpotato \
    -v /media/movies:/media \
    -v /apps/docker/sabnzbd/watched:/data \
    -v /apps/docker/couchpotato:/config \
    -v /etc/localtime:/etc/localtime:ro \
    -e UMASK=000 \
    -e PUID=0 \
    -e PGID=0 \
    binhex/arch-couchpotato
```

**Notes**

User ID (PUID) and Group ID (PGID) can be found by issuing the following command for the user you want to run the container as:-

```
id <username>
```
___
If you appreciate my work, then please consider buying me a beer  :D

[![PayPal donation](https://www.paypal.com/en_US/i/btn/btn_donate_SM.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=MM5E27UX6AUU4)

[Support forum](http://lime-technology.com/forum/index.php?topic=45837.0)
