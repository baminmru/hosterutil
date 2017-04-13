#!/bin/bash

#echo $#

if  [ "$#" -lt 2 ]  
then
	echo 'Call this script with at least 3 parameters, for example:'
	echo '  securefolders.sh <user> <domain> '
	exit 1
fi
#set -e
echo " SECURE wordpress files and folders "
echo "User is '$1', "

echo " Domain is '$2';"
	

echo " switch to web directory; " 
cd / 
cd var 
cd www 
cd $1 
cd data 
cd www 

echo " set www/$2 ownership to $1; "
chown -R $1:$1 ./$2
echo "  -$2 f444 ;"
find $2 -type f -exec chmod 444 {} \;
cd $2 
chmod 444 .htaccess
echo " -wp-admin f444 / d555;"
find wp-admin -type f -exec chmod 444 {} \;
find wp-admin -type d -exec chmod -R 555 {} \;
echo " -wp-includes f444/ d555;"
find wp-includes -type f -exec chmod 444 {} \;
find wp-includes -type d -exec chmod -R 555 {} \;
echo " -wp-content f444 / d555;"
find wp-content -type f -exec chmod 444 {} \;
find wp-content -type d -exec chmod -R 555 {} \;
echo " -wp-content/plugins f444 / d555;"
find wp-content/plugins -type f -exec chmod 444 {} \;
find wp-content/plugins -type d -exec chmod -R 555 {} \;
echo " -wp-content/languages f444 / d555;"
find wp-content/languages -type f -exec chmod 444 {} \;
find wp-content/languages -type d -exec chmod -R 555 {} \;
echo " -wp-content/themes f444 / d555;"
find wp-content/themes -type f -exec chmod 444 {} \;
find wp-content/themes -type d -exec chmod -R 555 {} \;
echo " -wp-content/uploads f644 / d755;"
chmod 444 wp-content/uploads/.htaccess
find wp-content/uploads -type f -exec chmod 644 {} \;
find wp-content/uploads -type d -exec chmod -R 755 {} \;
echo " -wp-content/cache f644 / d755;"
find wp-content/cache -type f -exec chmod 644 {} \;
find wp-content/cache -type d -exec chmod -R 755 {} \;
echo " done!"
exit 0
