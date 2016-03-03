#!/bin/bash
# Saturday, 01/30/16 11:29 PM
# Daniel Willitzer daniel@thedjdesign.com
# Created to update jira automatically
UPDATELINK=$1

JIRAHOME="/var/opt/atlassian-jira/"

# check atlassian.com if new update is available
# download into /tmp/;
wget -P /tmp/ $UPDATELINK
cd /tmp;
# tar -zxvf atlassian*.tar.gz
chmod a+x atlassian*.bin
cp /var/opt/atlassian-jira/.install4j/response.varfile /tmp
/tmp/atlassian*.bin -q -varfile response.varfile

# update @path="/jira" server.xml
xmlstarlet ed -L -u "/Server/Service/Engine/Host/Context/@path" -v '/jira' $JIRAHOME/conf/server.xml
echo 'Restarting Service';
service jira stop; service jira start; echo 'Cleaning up';
rm -rf /tmp/atlassian*.* /tmp/response.varfile;
clear; echo 'all done!';