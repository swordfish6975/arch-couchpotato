**CouchPotato**<br>
[Application website](http://couchpota.to)

**Description**<br>
Latest GitHub release of CouchPotato using Packer to compile.

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

**Access application**<br>
http://\<host ip\>:5050

**Notes**<br>
N/A

[Support forum](http://lime-technology.com/forum/index.php?topic=38055.0)