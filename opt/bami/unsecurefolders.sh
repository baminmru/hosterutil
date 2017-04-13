#!/bin/bash
if  [ "$#" -lt 2 ]  
then
	echo 'Call this script with at least 3 parameters, for example:'
	echo '  unsecurefolders.sh <user> <domain> '
	exit 1
fi
#set -e
echo " OPEN wordpress directory for updates. "
echo " User is '$1',"
echo " Domain is '$2'; "
echo " switch to web directory; " 
cd / 
cd var 
cd www 
cd $1 
cd data 
cd www 
echo " -$2 f666 ;"
find $2 f -exec chmod 666 {} \;
cd $2 
chmod 666 .htaccess
echo " -wp-admin f666 / d666;"
find wp-admin -type f -exec chmod 666 {} \;
find wp-admin -type d -exec chmod -R 666 {} \;
echo " -wp-includes f666 / d666;"
find wp-includes -type f -exec chmod 666 {} \;
find wp-includes -type d -exec chmod -R 666 {} \;
echo " -wp-content f666 / d666;"
find wp-content -type f -exec chmod 666 {} \;
find wp-content -type d -exec chmod 666 -R {} \;
echo " -wp-content/plugins f666 / d666;"
find wp-content/plugins -type f -exec chmod 666 {} \;
find wp-content/plugins -type d -exec chmod -R 666 {} \;
echo " -wp-content/languages f666 / d666;"
find wp-content/languages -type f -exec chmod 666 {} \;
find wp-content/languages -type d -exec chmod -R 666 {} \;
echo " -wp-content/themes f666 / d666;"
find wp-content/themes -type f -exec chmod 666 {} \;
find wp-content/themes -type d -exec chmod -R 666 {} \;

echo " -wp-content/uploads f777 / d777;"
chmod 666 wp-content/uploads/.htaccess
find wp-content/uploads -type f -exec chmod 777 {} \;
find wp-content/uploads -type d -exec chmod -R 777 {} \;
echo " -wp-content/cache f777 / d777;"
find wp-content/cache -type f -exec chmod 777 {} \;
find wp-content/cache -type d -exec chmod -R 777 {} \;
echo " done!"
exit 0
