#!/bin/bash
if [[ $EUID -ne 0 ]]; then
	echo "This script must be run using sudo" 2>&1
	exit 1
else
	rm -f /etc/ld.so.conf.d/multiarchfix.conf
	mkdir -p /usr/i386-linux-gnu
	if ! [[ -L /usr/i386-linux-gnu/mesa ]]
	then
		ln -s /usr/lib/i386-linux-gnu/mesa /usr/i386-linux-gnu/mesa
	fi

	rm -f /usr/bin/amd-indicator
	rm -Rf /usr/lib/amdindicator
	rm -Rf /usr/local/indicator-amd

	mkdir -p /usr/local/indicator-amd
	cp amd-indicator /usr/local/indicator-amd/
	chown root:root /usr/local/indicator-amd/amd-indicator
	chmod 755 /usr/local/indicator-amd/amd-indicator
	ln -sf /usr/local/indicator-amd/amd-indicator /usr/local/bin/amd-indicator
	cp dgpuon /usr/local/indicator-amd/
	chown root:root /usr/local/indicator-amd/dgpuon
	chmod a+x /usr/local/indicator-amd/dgpuon
	cp igpuon /usr/local/indicator-amd/
	chown root:root /usr/local/indicator-amd/igpuon
	chmod a+x /usr/local/indicator-amd/igpuon
	cp restart /usr/local/indicator-amd/
	chown root:root /usr/local/indicator-amd/restart
	chmod a+x /usr/local/indicator-amd/restart
	cp amd.png /usr/local/indicator-amd/
	cp amd-dark.png /usr/local/indicator-amd/
	cp amd-light.png /usr/local/indicator-amd/
	cp intel.png /usr/local/indicator-amd/
	cp intel-dark.png /usr/local/indicator-amd/
	cp intel-light.png /usr/local/indicator-amd/
	chmod a+r /usr/local/indicator-amd/*.png
	cp -f amd-indicator-sudoers /etc/sudoers.d/
	chmod 644 /etc/sudoers.d/amd-indicator-sudoers
	cp -f amd-indicator.desktop /etc/xdg/autostart/
	cp -f amd-indicator.desktop /usr/share/applications/
fi
