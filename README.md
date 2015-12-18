**Application**

[CouchPotato](http://couchpota.to)

**Application description**

Awesome PVR for usenet and torrents. Just fill in what you want to see and CouchPotato will add it to your "want to watch"-list. Every day it will search through multiple NZBs & Torrents sites, looking for the best possible match. If available, it will download it using your favorite download software.

**Build notes**

Latest GitHub Release of CouchPotato using Packer to compile.

**Usage**
```
docker run -d 
	-p 5050:5050 \ 
	--name=<container name> \
	-v <path for media files>:/media \
	-v <path for data files>:/data \
	-v <path for config files>:/config \
	-v /etc/localtime:/etc/localtime:ro \
	binhex/arch-couchpotato
```


Please replace all user variables in the above command defined by <> with the correct values.

**Access application**

http://\<host ip\>:5050

**Example**
```
docker run -d 
	-p 5050:5050 \ 
	--name=couchpotato \
	-v /media/movies:/media \
	-v /apps/sabnzbd/watched:/data \
	-v /apps/docker/couchpotato:/config \
	-v /etc/localtime:/etc/localtime:ro \
	binhex/arch-couchpotato
```


**Notes**

N/A

[Support forum](http://lime-technology.com/forum/index.php?topic=38055.0)