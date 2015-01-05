FROM binhex/arch-base:2015010500
MAINTAINER binhex

# additional files
##################

# add supervisor conf file for app
ADD couchpotato.conf /etc/supervisor/conf.d/couchpotato.conf

# install app
#############

# install base devel, install app using packer, set perms, cleanup
RUN pacman -Sy --noconfirm && \
	pacman -S --needed base-devel python2-pyopenssl --noconfirm && \	
	useradd -m -g wheel -s /bin/bash makepkg-user && \
	echo -e "makepkg-password\nmakepkg-password" | passwd makepkg-user && \
	echo "%wheel      ALL=(ALL) ALL" >> /etc/sudoers && \
	echo "Defaults:makepkg-user      !authenticate" >> /etc/sudoers && \
	curl -o /home/makepkg-user/packer.tar.gz https://aur.archlinux.org/packages/pa/packer/packer.tar.gz && \
	cd /home/makepkg-user && \
	tar -xvf packer.tar.gz && \
	su -c "cd /home/makepkg-user/packer && makepkg -s --noconfirm --needed" - makepkg-user && \
	pacman -U /home/makepkg-user/packer/packer*.tar.xz --noconfirm && \
	su -c "packer -S couchpotato-git --noconfirm" - makepkg-user && \
	chown -R nobody:users /opt/couchpotato && \
	chmod -R 775 /opt/couchpotato && \	
	pacman -Ru packer base-devel git --noconfirm && \
	yes|pacman -Scc && \
	userdel -r makepkg-user && \
	rm -rf /usr/share/locale && \
	rm -rf /usr/share/man && \
	rm -rf /root/* && \
	rm -rf /tmp/*

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