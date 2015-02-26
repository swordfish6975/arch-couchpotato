FROM binhex/arch-base:2015022600
MAINTAINER binhex

# additional files
##################

# add supervisor conf file for app
ADD couchpotato.conf /etc/supervisor/conf.d/couchpotato.conf

# install app
#############

# install dev tools and pre-reqs, compile and install app, set perms, cleanup
RUN pacman -Sy --noconfirm && \
	pacman -S --needed base-devel python2-pyopenssl --noconfirm && \	
	useradd -m -g wheel -s /bin/bash makepkg-user && \
	echo -e "makepkg-password\nmakepkg-password" | passwd makepkg-user && \
	echo "%wheel      ALL=(ALL) ALL" >> /etc/sudoers && \
	echo "Defaults:makepkg-user      !authenticate" >> /etc/sudoers && \
	curl -o /home/makepkg-user/package.tar.gz https://aur.archlinux.org/packages/co/couchpotato-git/couchpotato-git.tar.gz && \
	cd /home/makepkg-user && \
	tar -xvf package.tar.gz --strip-components=1 && \
	su -c "makepkg -s --noconfirm --needed" - makepkg-user && \
	pacman -U /home/makepkg-user/couchpotato*.tar.xz --noconfirm && \
	chown -R nobody:users /opt/couchpotato && \
	chmod -R 775 /opt/couchpotato && \	
	pacman -Ru base-devel git --noconfirm && \
	yes|pacman -Scc && \
	userdel -r makepkg-user && \
	rm -rf /usr/share/locale/* && \
	rm -rf /usr/share/man/* && \
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