#!/bin/bash

#echo $#

if  [ "$#" -lt 4 ]  
then
	echo 'Call this script with at least 4 parameters, for example:'
	echo '  newuser.sh <user> <password> <domain> <ip> [default_email [template]]'
	exit 1
fi
#set -e
echo "Create NEW user:"
echo " User is '$1',"
echo " Password is '$2',"
echo " Domain is '$3',"
echo " IP is '$4',"

dEmail="selenkov@inbox.ru"
if [ "$#" -lt 5 ]  
then
	dEmail="selenkov@inbox.ru"
else
	dEmail=$5
fi
 
echo " email is '$dEmail',"
 

if [ "$#" -lt 6 ]  
then
	Template="Hosting WP"
else
	Template=$6
fi
echo " template is '$Template'; "
	



echo " user.edit:"
/usr/local/mgr5/sbin/mgrctl -m ispmgr user.edit sok=yes name=$1 fullname=$1 passwd="$2"  preset="$Template" active=on     
echo "; ftp.user.edit:"
/usr/local/mgr5/sbin/mgrctl -m ispmgr ftp.user.edit sok=yes name=$1 owner=$1 home="/var/www/$1/data" active=on passwd="$2" 
echo "; emaildomain.edit:"
/usr/local/mgr5/sbin/mgrctl -m ispmgr emaildomain.edit sok=yes limit_ssl=hide name=$3 dmarc=off owner=$1 ipsrc=auto defaction=error 
echo "; email.edit webmaster:"
 /usr/local/mgr5/sbin/mgrctl -m ispmgr email.edit sok=yes name=webmaster domainname=$3 passwd="$2" confirm="$2" maxsize=5 owner=$1 dontsave=on forward=$dEmail
echo "; webdomain.edit:"
/usr/local/mgr5/sbin/mgrctl -m ispmgr webdomain.edit sok=yes name=$3 owner=$1 docroot="/var/www/$1/data/www/$3" php=on acitve=off  ipaddr=$4 email=webmaster@$3 
echo "; db.edit"
/usr/local/mgr5/sbin/mgrctl -m ispmgr db.edit sok=yes name=$1 owner=$1 type=MySQL charset=utf8 username=$1 password="$2" confirm="$2" 
echo "; scheduler property:"
/usr/local/mgr5/sbin/mgrctl -m ispmgr scheduler.prop  su=$1 sok=yes mailto="webmaster@$3"

echo "; user php settings:"


#/usr/local/mgr5/sbin/mgrctl -m ispmgr phpconf.edit su=$1 plid=native sok=ok value=no elid=sendmail_path
#/usr/local/mgr5/sbin/mgrctl -m ispmgr phpconf.edit su=$1 plid=native sok=ok value=no elid=mail.force_extra_parameters

echo "-sendmail_from: "
/usr/local/mgr5/sbin/mgrctl -m ispmgr phpconf.edit su=$1 plid=native sok=ok value="webmaster@$3" cgi_value="webmaster@$3" elid=sendmail_from
echo "-mail.add_x_header: "
/usr/local/mgr5/sbin/mgrctl -m ispmgr phpconf.edit su=$1 plid=native sok=ok value=On elid=mail.add_x_header
echo "-upload_tmp_dir: "
/usr/local/mgr5/sbin/mgrctl -m ispmgr phpconf.edit su=$1 plid=native sok=ok value="/var/www/$1/data/bin-tmp/" elid=upload_tmp_dir
echo "-usession.save_path: "
/usr/local/mgr5/sbin/mgrctl -m ispmgr phpconf.edit su=$1 plid=native sok=ok value="/var/www/$1/data/bin-tmp/" elid=session.save_path
echo "-mail.log: "
/usr/local/mgr5/sbin/mgrctl -m ispmgr phpconf.edit su=$1 plid=native sok=ok value="/var/www/$1_mail.log" cgi_value="/var/www/$1_mail.log"  elid=mail.log
echo "-php_err: "
/usr/local/mgr5/sbin/mgrctl -m ispmgr phpconf.settings su=$1 plid=native sok=ok all_php_errors=on display_errors=off error_exclude_flags=E_DEPRECATED,E_STRICT error_include_flags=E_COMPILE_ERROR,E_COMPILE_WARNING,E_CORE_ERROR,E_CORE_WARNING,E_ERROR,E_NOTICE,E_PARSE,E_RECOVERABLE_ERROR,E_USER_DEPRECATED,E_USER_ERROR,E_USER_NOTICE,E_USER_WARNING,E_WARNING log_errors=on not_in_e_all=E_STRICT


echo "; switch to web directory" 
cd / 
cd var 
cd www 
cd $1 
cd data 
cd www 
cd $3 
cp /opt/bami/www.htaccess  .htaccess
chmod 444 .htaccess
rm -rf *.*
echo "; load wordpress" 
wget -q https://ru.wordpress.org/latest-ru_RU.zip 

echo "; unpack" 
#tar -xzvf latest-ru_RU.zip
unzip -q latest-ru_RU.zip 

cd wordpress 
cp -R ./ ../ 
cd ..
echo "; erase archive"
rm -rf wordpress 
rm -f latest-ru_RU.zip 

echo "; create directories"
#mkdir wp-content/languages 
mkdir wp-content/upgrade 
mkdir wp-content/uploads 
mkdir wp-content/cache  

echo "; copy plugins"
cp -R /opt/bami/plugins wp-content/

cp /opt/bami/uploads.htaccess  wp-content/uploads/.htaccess

cd ..
echo "; set www/$3 ownership to $1"
chown -R $1:$1 ./$3

echo "; secure wordpress files:"

echo " -$3 f444 ;"
find $3 -type f -exec chmod 444 {} \;
cd $3

echo " -wp-admin f444 / d555;"
find wp-admin -type f -exec chmod 444 {} \;
find wp-admin -type d -exec chmod -R 555 {} \;
echo " -wp-includes f444 / d555;"
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
echo " -wp-content/cache  f644 / d755;"
find wp-content/cache -type f -exec chmod 644 {} \;
find wp-content/cache -type d -exec chmod -R 755 {} \;
echo " done!"
exit 0
