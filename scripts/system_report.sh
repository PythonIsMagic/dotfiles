#!/bin/bash
# Author: Erik Lunna
# Date Created: 2015
# Purpose: Print out vital system info into an HTML report.
# Note: May need to run as superuser to get full report.
# Usage: ./sysinfo.sh > sys.html

TITLE="My System Information $HOSTNAME"
RIGHT_NOW=$(date +"%x %r %Z")
TIME_STAMP="Updated on $RIGHT_NOW by $USER"

function today() {
    echo "Today's date is:"
    date +"%A, %B %-d, %Y":
}

function show_uptime {
    echo "<h2>System uptime</h2>"
    echo "<pre>"
    uptime
    echo "</pre>"
}

function system_info {
	echo -e "<H2>System Analysis:</H2>"
	echo "<pre>"
	uname -a

	echo -e "<H3>Kernel Info</H3>"
	echo -n "Kernel Name: "
	uname --kernel-name
	echo -n "Kernel Release: "
	uname --kernel-release
	echo -n "Kernel Version: "
	uname --kernel-version
	echo -n "Machine: "
	uname --machine
	echo -n "Processor "
	uname --processor
	echo -n "Hardware-platform "
	uname --hardware-platform
	echo -n "OS: "
	uname --operating-system
	echo -n "Version: "
	uname --version

	echo "<H3>lscpu info:</H3>"

	lscpu
	echo "</pre>"

	echo "<pre>"

	echo "Linux Distribution:"
	cat /etc/lsb-release
	echo -n "Grub:"
	grub-install --version

	echo "<H3>RAM:</H3>"
	cat /proc/meminfo

	echo "<H3>BIOS INFO</H3>"
	#Need su privilege
	sudo dmidecode | head -40

    echo "<H4>Show all driver packages which apply to the current system.</H4>"
    ubuntu-drivers list

    echo "<H4>Show all devices which need drivers, and which packages apply to them.</H4>"
    ubuntu-drivers devices

	echo "</pre>"
}

function drive_space {
    echo "<h2>Filesystem space</h2>"
    echo "<pre>"
    df -h
    echo ""
    free -m -l -t
    # du -ach
    # du -sh /home/*
    #du --all --total --human-readable | sort --human-numeric-sort # View du output formatted:

    echo "<H4>vmstat - Virtual Memory Statistics</H4>"
    vmstat

    echo "ps auxf -- AUXF"
    ps auxf

echo "</pre>"
}

# get current host related info
function host_info () {
    echo -e "<H3>Host Info and Statistics</H3>"
    echo "<pre>"
    echo -e "Users logged on:\\n $(w -h)"
    echo ""
    echo "USER: $USER"
    echo "LOGNAME: $LOGNAME"
    echo "USERNAME: $USERNAME"
    echo "HOSTNAME: $HOSTNAME"
    echo "LANGUAGE: $LANG"
	echo ""
	echo "ALL USERS:"
	users

    echo "</pre>"
}

# Provide host and network related info
function my_ips() {
    echo "<H3>Network and host IP info:</H3>"
    echo "<pre>"
    #echo -en "\n'$Local'IP Address :$NC" ; /sbin/ifconfig wlan0 | awk /'inet addr/ {print $2}' | sed -e s/addr:/' '/
    echo "Public IP: " && curl ifconfig.me -s
    #echo "Public IP: $(curl http://ipecho.net/plain -s)"
    #echo "Alternative Public IP: $(curl http://ipecho.net/plain)"
    # echo -en "Local IP Address :"; /sbin/ifconfig wlan0 | awk /'inet addr/ {print $2}' | sed -e s/addr:/' '/
    echo ""

    echo /sbin/ifconfig | awk /'inet addr/ {print $2}'
    echo /sbin/ifconfig | awk /'Bcast/ {print $3}'
    echo /sbin/ifconfig | awk /'inet addr/ {print $4}'
    # /sbin/ifconfig | awk /'HWaddr/ {print $4,$5}'
    echo "</pre>"
}

function ports_info() {
	echo "<H3>Port info:</H3"
	#ports
	echo "<pre>"
	echo "$(netstat -tulanp)<br /><br />"
	netstat -tulanp
	echo "$(netstat -tulanp)</pre>"
}

function router_status() {
    echo "<H2>Router info</H2>"
    echo "<pre>"
    echo "Routing Info"
    route
    echo "</pre>"
}

function network_status() {
    echo "<H2>Network Status</H2>"
    echo "<pre>"
    echo "<H3>iwconfig:</H3>"
    iwconfig
    echo "</pre>"
}

function netstat_info() {
    echo "<H3>Netstat:</H3>"
    echo "<pre>"
	netstat -s

    echo "<p>List all open ports and associated programs:</p>"
    sudo netstat -tulpn

    echo "</pre>"
}

function nmap_probe() {
    echo "<H3>Nmap local probe info:</H3"
    echo "<pre>(requires root privilege)</pre>"
    echo "<pre>$(sudo nmap -sT -O localhost )</pre>"
}

function list_connected() {
    echo "<H3>IP addresses connected to.</H3>"
    echo "<pre>$(~/Documents/scripts/collected/ipaddresses.sh)</pre>"
}

function app_info() {
	echo "<H2>Application Versions</H2>"
    # Process the app version info commands one-by-one
	CMDLIST="env_apps.txt"
    while IFS= read -r line; do
        echo "<pre>"
        array="($line)"
        firstword=${array[0]}
        output=$($line 2>/dev/null) # somethings don't show up bc of err

        # output=$($line)
        echo -n "<h3>$firstword</h3><pre>$output</pre><br />"
        echo "</pre>"
    done < "$CMDLIST"
}

function bash_env() {
	echo "<H2>Bash Shell Environment:</H2>"
	echo "<pre>"
	echo "Path: $PATH)"
	#echo "MANDATORY_PATH: $MANDATORY_PATH"
	#echo "DEFAULTS_PATH: $DEFAULTS_PATH"
	#echo "XDG_CONFIG_DIRS: $XDG_CONFIG_DIRS"
	#echo "LIBRARY_PATH: $LIBRARY_PATH"
	echo "XAUTHORITY: $XAUTHORITY"
    #echo "SESSION_MANAGER: $SESSION_MANAGER"
	echo "</pre>"
}


function problem_commands() {
    # These verion-display commands don't seem to work with the loop
	echo "<H2>Other applications</H2>"

    # echo -n "<b></b>"
    # echo "<pre>$()</pre><br /></pre>"

    echo -n "<b>guake</b>"
    # echo "<pre>$(guake -a)</pre><br /></pre>" # Just hangs after the GUI
    echo "<pre>$(guake --help)</pre><br /></pre>" # Workaround

    echo -n "<b>java </b>"
    echo "<pre>$(java -version 2>&1)</pre><br /></pre>"

    echo -n "<b>python </b>"
    echo "<pre>$(python2 --version 2>&1)</pre><br /></pre>"
    echo "<pre>$(python3 --version 2>&1)</pre><br /></pre>"

    echo -n "<b>xclip</b>"
    echo "<pre>$(xclip -version 2>&1)</pre><br /></pre>"
}

function shell_info() {
	echo "<H2>Shells:</H2>";
	echo "<pre>"
 	cat /etc/shells
	echo "<br />"
	echo "<b>Bash:</b>" ; bash --version
	echo "<br />"
	echo "<b>rbash:</b>" ; rbash --version
	echo "<br />"
	echo "<b>dash:</b>" ; apt-cache policy dash
	echo "<br />"
	echo "<b>sh:</b>" ; apt-cache policy sh
	echo "</pre>"
}

cat <<- _EOF_
<HTML>
<HEAD><TITLE>$TITLE</TITLE></HEAD>
<BODY>
	<H1>$TITLE</H1>
	<P>
		$TIME_STAMP<br />
		$(show_uptime)
		$(system_info)
		$(drive_space)
		$(host_info)
		$(my_ips)
		$(network_status)
		$(router_status)
		$(netstat_info)
		$(ports_info)
		$(nmap_probe)
		$(list_connected)
		$(app_info)
		$(bash_env)
		$(problem_commands)
		$(shell_info)
	</P>
	</BODY>
</HTML>
_EOF_
exit


# MIT License

# Copyright (c) [2016] [Erik S. Lunna]

# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:

# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
