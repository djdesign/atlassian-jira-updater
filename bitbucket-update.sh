#!/bin/bash
# Sunday, 01/31/16 11:56 AM
# Daniel Willitzer daniel@thedjdesign.com
# Created to update bitbucket automatically
UPDATELINK=$1

# JIRAHOME="/var/opt/atlassian-jira/"
BITBUCKETHOME="/var/opt/atlassian-bitbucket/"

# check atlassian.com if new update is available
# download into /tmp/;
wget -P /tmp/ $UPDATELINK
cd /tmp;
# tar -zxvf atlassian*.tar.gz
chmod a+x atlassian*.bin
cp /var/opt/atlassian-bitbucket/.install4j/response.varfile /tmp
# stop bitbucket service & remove old files
service atlbitbucket stop;
rm -rf /var/opt/atlassian-bitbucket/*
# run installer
/tmp/atlassian*.bin -q -varfile response.varfile
service atlbitbucket stop

# copy in necessary assets
# TODO:not needed?
# cp /var/opt/atlassian-jira/lib/ojdbc6-11.2.0.2.0.jar $BITBUCKETHOME/lib/

# Restarting Bitbucket
service atlbitbucket start;
# Cleanup Files
rm /tmp/atlassian*.bin response.varfile;
clear; echo "all done with bitbucket update";