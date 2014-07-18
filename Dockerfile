FROM binhex/arch-base
MAINTAINER binhex

# install application
#####################

# update package databases for arch
RUN pacman -Sy --noconfirm

# install any pre-reqs for application
RUN pacman -S python2-pyopenssl --noconfirm

# run packer to install application
RUN packer -S couchpotato-git --noconfirm

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

# set permissions
#################

# change owner
RUN chown -R nobody:users /opt/couchpotato

# set permissions
RUN chmod -R 775 /opt/couchpotato

# add conf file
###############

ADD couchpotato.conf /etc/supervisor/conf.d/couchpotato.conf

# cleanup
#########

# completely empty pacman cache folder
RUN pacman -Scc --noconfirm

# remove temporary files
RUN rm -rf /tmp/*

# run supervisor
################

# run supervisor
CMD ["supervisord", "-c", "/etc/supervisor.conf", "-n"]
