# hosterutil
ISPManager 5  plugin for create new hosting user and  setup  user directories for wordpress

Плугин реализован в виде нескольких файлов. Файлы разложены по различным директориям.
1.	XML  с описанием интерфейса плугина 
/usr/local/mgr5/etc/xml/ispmgr_mod_hosterutils.xml
2.	Тело плугина
/usr/local/mgr5/addon/hosterutils.php
3.	Скрипты 
/opt/bami/global.sh		скрипт подготовки шаблонов хостинга и  настроек php
/opt/bami/newuser.sh			скрипт создания пользователя
/opt/bami/securefolders.sh		скрипт установки прав на  директории пользователя
/opt/bami/unsecurefolders.sh		скрипт снятия прав (полный доступ)
4.	Шаблоны файлов .htaccess
/opt/bami/www.htaccess		Файл используется в качестве шаблона для корневой  директории пользователя
/opt/bami/uploads.htaccess		Файл используется в качестве шаблона для директории  uploads
5.	Директория с плугинами для WordPress
/opt/bami/plugins/			Отсюда копируются  все плугины WordPress 

Работа с плугином
Плугин доступен для пользователей с правами администратора системы
Доступ к плугину из меню Инструменты\Утилиты хостера
Плугин отображает список пользователей и их доменов.
Три кнопки тулбара реализуют операции создания нового пользователя, установки прав на папки и снятие прав с папок.
Для операций с правами  возможен  массовый режим ( выделить строки и нажать кнопку).