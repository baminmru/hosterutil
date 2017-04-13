#!/bin/bash

#yum -y install wget
#yum -y install unzip
#---- OK


echo "global php settings"
/usr/local/mgr5/sbin/mgrctl -m ispmgr phpversions
/usr/local/mgr5/sbin/mgrctl -m ispmgr phpconf.resume plid=native sok=ok value=no elid=display_errors
/usr/local/mgr5/sbin/mgrctl -m ispmgr phpconf.resume plid=native sok=ok value=no elid=error_reporting
/usr/local/mgr5/sbin/mgrctl -m ispmgr phpconf.resume plid=native sok=ok value=no elid=session.save_path
/usr/local/mgr5/sbin/mgrctl -m ispmgr phpconf.resume plid=native sok=ok value=no elid=mail.log
/usr/local/mgr5/sbin/mgrctl -m ispmgr phpconf.resume plid=native sok=ok value=no elid=sendmail_from
/usr/local/mgr5/sbin/mgrctl -m ispmgr phpconf.resume plid=native sok=ok value=no elid=sendmail_path
/usr/local/mgr5/sbin/mgrctl -m ispmgr phpconf.resume plid=native sok=ok value=no elid=mail.force_extra_parameters
/usr/local/mgr5/sbin/mgrctl -m ispmgr phpconf.resume plid=native sok=ok value=no elid=mail.add_x_header

echo "preset"
/usr/local/mgr5/sbin/mgrctl -m ispmgr preset.edit sok=yes name='Hosting WP' level=16 limit_db=2 limit_db_enabled=on limit_db_users=2 limit_db_users_enabled=on limit_ftp_users=1 limit_ftp_users_enabled=on limit_domains=5 limit_domains_enabled=on limit_webdomains=5 limit_webdomains_enabled=on limit_ssl=off limit_cgi=on limit_cgi_enabled=on limit_php_mode_mod=off limit_php_mode_fcgi_apache=on limit_php_mode_fcgi_apache_enabled=on limit_emaildomains=1 limit_emaildomains_enabled=on limit_emails=1 limit_emails_enabled=on limit_shell=off limit_quota=300  limit_quota_enabled=on limit_php_mode_fcgi_nginxfpm=off limit_charset_enabled=on limit_php_mode_enabled=on limit_php_cgi_version_enabled=on limit_dirindex='index.html index.php' limit_dirindex_enabled=on limit_php_cgi_enable=on php_enable=on limit_php_fpm_version=native limit_charset=UTF-8  limit_php_mode=php_mode_fcgi_apache limit_php_cgi_version=native
/usr/local/mgr5/sbin/mgrctl -m ispmgr preset.edit sok=yes name='1GB'        level=16 limit_db=2 limit_db_enabled=on limit_db_users=2 limit_db_users_enabled=on limit_ftp_users=1 limit_ftp_users_enabled=on limit_domains=5 limit_domains_enabled=on limit_webdomains=5 limit_webdomains_enabled=on limit_ssl=off limit_cgi=on limit_cgi_enabled=on limit_php_mode_mod=off limit_php_mode_fcgi_apache=on limit_php_mode_fcgi_apache_enabled=on limit_emaildomains=1 limit_emaildomains_enabled=on limit_emails=1 limit_emails_enabled=on limit_shell=off limit_quota=1024 limit_quota_enabled=on limit_php_mode_fcgi_nginxfpm=off limit_charset_enabled=on limit_php_mode_enabled=on limit_php_cgi_version_enabled=on limit_dirindex='index.html index.php' limit_dirindex_enabled=on limit_php_cgi_enable=on php_enable=on limit_php_fpm_version=native limit_charset=UTF-8  limit_php_mode=php_mode_fcgi_apache limit_php_cgi_version=native
/usr/local/mgr5/sbin/mgrctl -m ispmgr preset.edit sok=yes name='2GB'        level=16 limit_db=2 limit_db_enabled=on limit_db_users=2 limit_db_users_enabled=on limit_ftp_users=1 limit_ftp_users_enabled=on limit_domains=5 limit_domains_enabled=on limit_webdomains=5 limit_webdomains_enabled=on limit_ssl=off limit_cgi=on limit_cgi_enabled=on limit_php_mode_mod=off limit_php_mode_fcgi_apache=on limit_php_mode_fcgi_apache_enabled=on limit_emaildomains=1 limit_emaildomains_enabled=on limit_emails=1 limit_emails_enabled=on limit_shell=off limit_quota=2048 limit_quota_enabled=on limit_php_mode_fcgi_nginxfpm=off limit_charset_enabled=on limit_php_mode_enabled=on limit_php_cgi_version_enabled=on limit_dirindex='index.html index.php' limit_dirindex_enabled=on limit_php_cgi_enable=on php_enable=on limit_php_fpm_version=native limit_charset=UTF-8  limit_php_mode=php_mode_fcgi_apache limit_php_cgi_version=native
/usr/local/mgr5/sbin/mgrctl -m ispmgr preset.edit sok=yes name='3GB'        level=16 limit_db=2 limit_db_enabled=on limit_db_users=2 limit_db_users_enabled=on limit_ftp_users=1 limit_ftp_users_enabled=on limit_domains=5 limit_domains_enabled=on limit_webdomains=5 limit_webdomains_enabled=on limit_ssl=off limit_cgi=on limit_cgi_enabled=on limit_php_mode_mod=off limit_php_mode_fcgi_apache=on limit_php_mode_fcgi_apache_enabled=on limit_emaildomains=1 limit_emaildomains_enabled=on limit_emails=1 limit_emails_enabled=on limit_shell=off limit_quota=3072 limit_quota_enabled=on limit_php_mode_fcgi_nginxfpm=off limit_charset_enabled=on limit_php_mode_enabled=on limit_php_cgi_version_enabled=on limit_dirindex='index.html index.php' limit_dirindex_enabled=on limit_php_cgi_enable=on php_enable=on limit_php_fpm_version=native limit_charset=UTF-8  limit_php_mode=php_mode_fcgi_apache limit_php_cgi_version=native

