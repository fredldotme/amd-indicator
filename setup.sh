#!/bin/bash
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run using sudo" 2>&1
	exit 1
else
	groupadd amdindicator
	mkdir -p /usr/lib/amdindicator
	cp 11switchable /etc/X11/Xsession.d/
	chown root:root /etc/X11/Xsession.d/11switchable
	chmod 644 /etc/X11/Xsession.d/11switchable
	cp igpuon /usr/lib/amdindicator/
	cp dgpuon /usr/lib/amdindicator/
	cp intel.png /usr/lib/amdindicator/
	cp amd.png /usr/lib/amdindicator/
	chmod a+r /usr/lib/amdindicator/*.png
	chown root:amdindicator /usr/lib/amdindicator/igpuon
	chown root:amdindicator /usr/lib/amdindicator/dgpuon
	chmod a+x /usr/lib/amdindicator/igpuon
	chmod a+x /usr/lib/amdindicator/dgpuon
	SUDOERSTRING="%amdindicator ALL=NOPASSWD: /usr/lib/amdindicator/igpuon, /usr/lib/amdindicator/dgpuon"

	if grep -Fxq "$SUDOERSTRING" /etc/sudoers
	then
    		echo "sudoer already set up"
	else
		echo "" >> /etc/sudoers
		echo $SUDOERSTRING >> /etc/sudoers
	fi
fi
