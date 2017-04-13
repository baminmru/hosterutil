#!/usr/bin/php 
<?php
error_reporting(E_ERROR  | E_PARSE);

$debug=true;
$passwd="";
$newname="";
$newowner="";
$sendto="";
$usertemplate="";
$newowner="";
$name="";
$owner="";
$sok="";
$elid="";
$ip="127.0.0.1";
	
function StartsWith($Haystack, $Needle){
    return strpos($Haystack, $Needle) === 0;
}
	
	
if($debug===true) file_put_contents('/opt/bami/_debug.txt', "START-------------------------------------\r\n", FILE_APPEND);


$host=gethostname();
$ip=gethostbyname($host);	

// Get Parameters
foreach ( $_SERVER as $key => $value ) {
	
	if($debug===true){
		if (StartsWith($key,"PARAM_")) file_put_contents('/opt/bami/_debug.txt', $key.' = '.$value."\r\n", FILE_APPEND);
	}
	if($key==='PARAM_passwd'){
		$passwd=$value;
	}

	if($key==='PARAM_newname'){
		$newname=$value;
	}
	
	if($key==='PARAM_name'){
		$name=$value;
	}
	
	if($key==='PARAM_newowner'){
		$newowner=$value;
	}
	if($key==='PARAM_owner'){
		$owner=$value;
	}
	if($key==='PARAM_sendto'){
		$sendto=$value;
	}
	if($key==='PARAM_usertemplate'){
		$usertemplate=$value;
	}
	if($key==='PARAM_sok'){
		$sok='ok';
	}
	if($key==='PARAM_func'){
		$func=$value;
	}
	if($key==='PARAM_elid'){
		$elid=$value;
	}
}
	
	
$out='';	


function GetList(){
  
  $s=shell_exec ('/usr/local/mgr5/sbin/mgrctl -m ispmgr webdomain out=xml');
  $s=str_replace('webdomain','hosterutils',$s);
  return $s;
 
}


function GetItem($elid,$func){
    
	$s=shell_exec ('/usr/local/mgr5/sbin/mgrctl -m ispmgr webdomain.edit elid='.$elid.' out=xml');
	$s=str_replace('webdomain.edit',$func,$s);
	return $s;
}

if($func==="hosterutils"){
	if($elid==''){
		$out=GetList();
		echo $out;
		
	}else{
		$out=GetItem($elid,$func);
		echo $out;
	}
}

if($func==="hosterutils.new"){
	if($sok==="ok" ){
		
		$nu='/opt/bami/global.sh';
		
		if($debug===true) file_put_contents('/opt/bami/_debug.txt','exec: = '.$nu."\r\n", FILE_APPEND);
		$s=shell_exec ( $nu);
		
		$nu='/opt/bami/newuser.sh "'.$newowner.'" "'.$passwd.'" "'.$newname.'" "'.$ip.'" "'.$sendto.'" "'.$usertemplate.'"';
		
		if($debug===true) file_put_contents('/opt/bami/_debug.txt','exec: = '.$nu."\r\n", FILE_APPEND);
		$s=shell_exec ( $nu);
		
		if($debug===true) file_put_contents('/opt/bami/_debug.txt','newsh: = '.$s."\r\n", FILE_APPEND);
		
		$out='<?xml version="1.0" encoding="UTF-8"?>';
		$out.='<doc>';	
		
		if( stripos($s,'error')!==false ){
			$out.='<banner id="create_new_user_'.$key.'" status="1">';
		}else{
			$out.='<banner id="create_new_user_'.$key.'" status="3">';
		}
		
		
		if (strlen($s) >1024){
		$out.='<msg>'.htmlentities(substr($s,0,1024).' ...', ENT_QUOTES, "UTF-8").'</msg>';
		}else{
			$out.='<msg>'.htmlentities($s, ENT_QUOTES, "UTF-8").'</msg>';
		}
		$out.='</banner>';
		$out.='<ok/>';
		$out.='</doc>';
	}else{
		$out='<?xml version="1.0" encoding="UTF-8"?>';
		$out.='<doc>';	
		$out.='<slist name="usertemplate">';
		$out.='  <val key="Hosting WP">WordPress</val>';
		$out.='  <val key="1GB">1 GB</val>';
		$out.='  <val key="2GB">2 GB</val>';
		$out.='  <val key="3GB">3 GB</val>';
		$out.='</slist>	';
		$out.='<sendto>';
		$out.='default@mail.ru';
		$out.='</sendto>';
		$out.='</doc>';
	
	}
	echo $out;
}

if($func==="hosterutils.lock"){
	
	if($sok==="ok" ){
		
		$nu='/opt/bami/securefolders.sh "'.$owner.'" "'.$name.'"';
		if($debug===true) file_put_contents('/opt/bami/_debug.txt','exec: = '.$nu."\r\n", FILE_APPEND);
		$s=shell_exec ( $nu);
		if($debug===true) file_put_contents('/opt/bami/_debug.txt','sf: = '.$s."\r\n", FILE_APPEND);
		
		$out='<?xml version="1.0" encoding="UTF-8"?>';
		$out.='<doc>';	
		$out.='<banner id="lock_'.$name.'" status="3">';
		if (strlen($s) >1024){
		$out.='<msg>'.htmlentities(substr($s,0,1024).' ...', ENT_QUOTES, "UTF-8").'</msg>';
		}else{
			$out.='<msg>'.htmlentities($s, ENT_QUOTES, "UTF-8").'</msg>';
		}
		$out.='</banner>';
		$out.='<ok/>';
		$out.='</doc>';
	}else{
		$out=GetItem($elid,$func);
	}
	echo $out;
}

if($func==="hosterutils.unlock"){
	if($sok==="ok" ){
		
		$nu='/opt/bami/unsecurefolders.sh "'.$owner.'" "'.$name.'"';
		if($debug===true) file_put_contents('/opt/bami/_debug.txt','exec: = '.$nu."\r\n", FILE_APPEND);
		$s=shell_exec ( $nu);
		if($debug===true) file_put_contents('/opt/bami/_debug.txt','usf: = '.$s."\r\n", FILE_APPEND);
		
		$out='<?xml version="1.0" encoding="UTF-8"?>';
		$out.='<doc>';	
		$out.='<banner id="unlock_'.$name.'" status="3">';
		if (strlen($s) >1024){
		$out.='<msg>'.htmlentities(substr($s,0,1024).' ...', ENT_QUOTES, "UTF-8").'</msg>';
		}else{
			$out.='<msg>'.htmlentities($s, ENT_QUOTES, "UTF-8").'</msg>';
		}
		$out.='</banner>';
		$out.='<ok/>';
		$out.='</doc>';
	}else{
		$out=GetItem($elid,$func);
	}
	echo $out;
	
}

if($debug===true) file_put_contents('/opt/bami/_debug.txt', 'out: '.$out."\r\n", FILE_APPEND);
