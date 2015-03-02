FROM binhex/arch-base:2015010500
MAINTAINER binhex

# additional files
##################

# add supervisor conf file for app
ADD couchpotato.conf /etc/supervisor/conf.d/couchpotato.conf

# add install bash script
ADD install.sh /root/install.sh

# add packer bash script
ADD packer.sh /root/packer.sh

# install app
#############

# install base devel, install app using packer, set perms, cleanup
RUN chmod +x /root/install.sh && \
	chmod +x /root/packer.sh && \
	/bin/bash /root/install.sh

# docker settings
#################

# map /config to host defined config path (used to store configuration from app)
VOLUME /config

# map /data to host defined data path (used to store downloads or use blackhole)
VOLUME /data

# map /media to host defined media path (used to read/write to media library)
VOLUME /media

# expose port for http
EXPOSE 5050

# run supervisor
################

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]