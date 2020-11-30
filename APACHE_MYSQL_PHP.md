# Détail install apache / mysql / php sur Mac OS

Vérifier qu'apache est là : `apachectl configtest`

Config des modules apache : `sudo vim /etc/apache2/httpd.conf`

Décommenter
```
LoadModule rewrite_module libexec/apache2/mod_rewrite.so
LoadModule php5_module libexec/apache2/libphp5.so
```

Modifier
```
DocumentRoot "/Users/VOTRE_USER/Sites" 
<Directory "/Users/VOTRE_USER/Sites"> 


# Virtual hosts
Include /Users/VOTRE_USER/Sites/httpd-vhosts.conf

```

Déclarer les vhosts persos dans `/Users/USER/Sites/httpd-vhosts.conf`

Ajouter
```
<Directory "/Users/USER/Sites/">
AllowOverride All
Options Indexes MultiViews FollowSymLinks
Require all granted
</Directory>

<VirtualHost *:80>
    ServerName localhost
    ServerAlias local.dev
    DocumentRoot "/Users/USER/Sites"
</VirtualHost>

<VirtualHost *:80>
    ServerName spip
    ServerAlias spip.local
    DocumentRoot "/Users/USER/Sites/spip"
</VirtualHost>


```

Brancher le tout sur l'internet local : `sudo vim /etc/hosts`

Ajouter
```
127.0.0.1       localhost
127.0.0.1 spip spip.local
```

Voir comment apache comprend sa conf : `httpd -S `

Régler php : 

```
cd /etc
sudo cp php.ini.default php.ini
sudo chmod ug+w php.ini
sudo chgrp staff php.ini
```

Configurer php `sudo vim /etc/php.ini`

```
[Date]
; Defines the default timezone used by the date functions
; http://php.net/date.timezone
date.timezone = Europe/Paris 
```

Si vous avez un accès à un disque avec votre user et votre groupe, mais pas apache, vous pouvez donner à apache votre user et votre group

`sudo vim /etc/apache2/httpd.conf`

```
#User _www
#Group _www

User vincent
Group staff
```

Voir : https://coolestguidesontheplanet.com/set-virtual-hosts-apache-mac-osx-10-10-yosemite/

Sur Big : https://tobschall.de/2020/11/01/big-sur-mamp/

Attention à la version d'apache pour déclarer le fichier  : https://coolestguidesontheplanet.com/forbidden-403-you-dont-have-permission-to-access-username-on-this-server/


# Mysql

```
brew install mysql
brew services list # pour démarrer mysql

# Régler un bug
sudo mkdir /var/mysql
sudo ln -s /tmp/mysql.sock /var/mysql/mysql.sock
brew services restart mysql

# reset login root pass root
mysqladmin -u root -p password
enter / root / root
(mysql_secure_installation)?

```
Conf mysql `vim ~/.my.cnf`

Ajouter
```
[client]
user=root
password=root
default-character-set=utf8mb4
```

# reboot
Relancer mysql
```
brew services restart mysql
```

Relancer apache
```
sudo apachectl graceful
```

# Logs

Apache / php
```
tail -F /var/log/apache2/error.log
```

Mysql
```
# ps auxww|grep [m]ysqld
# tail -F /usr/local/var/mysql/XXX.local.err
tail -F /usr/local/var/mysql/Bongo.local.err
```

Parfois aussi sous debian
```
tail -F /var/log/mysql/mysql-slow.log
```



