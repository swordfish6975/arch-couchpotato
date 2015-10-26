CouchPotato
===========

CouchPotato - http://couchpota.to

Latest stable CouchPotato GitHub release from Arch Linux AUR using Packer to compile.

**Pull image**

```
docker pull binhex/arch-couchpotato
```

**Run container**

```
docker run -d -p 5050:5050 --name=<container name> -v <path for media files>:/media -v <path for data files>:/data -v <path for config files>:/config -v /etc/localtime:/etc/localtime:ro binhex/arch-couchpotato
```

Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

```
http://<host ip>:5050
```