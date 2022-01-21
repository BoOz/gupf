# Détail install apache / mysql / php sur Mac OS

Vérifier qu'apache est là : `apachectl configtest`

Config des modules apache : `sudo vim /etc/apache2/httpd.conf`

Décommenter
```
LoadModule rewrite_module libexec/apache2/mod_rewrite.so
LoadModule php5_module libexec/apache2/libphp5.so
ou si plus récent ajouter
LoadModule php_module /opt/homebrew/opt/php/lib/httpd/modules/libphp.so "nom du certificat auto signé"
```

Sur les macs > 12 il faut créer un certificat pour signer php : https://www.simplified.guide/macos/apache-php-homebrew-codesign

```
<FilesMatch \.php$>
        SetHandler application/x-httpd-php
    </FilesMatch>
```

et aussi :

`chmod +a "_www allow execute" ~`



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

**Maj php**

Sur un mac, installer php 7.4 en cli.

```
brew update
brew install php@7.4
brew unlink php@7.3 && brew link php@7.4
```

Et aussi


```
To enable PHP in Apache add the following to httpd.conf and restart Apache:
    LoadModule php7_module /usr/local/opt/php@7.4/lib/httpd/modules/libphp7.so

    <FilesMatch \.php$>
        SetHandler application/x-httpd-php
    </FilesMatch>
```

Relancer apache `sudo apachectl graceful`


```

Finally, check DirectoryIndex includes index.php
    DirectoryIndex index.php index.html

The php.ini and php-fpm.ini file can be found in:
    /usr/local/etc/php/7.4/

Eventuellement.

php@7.4 is keg-only, which means it was not symlinked into /usr/local,
because this is an alternate version of another formula.

If you need to have php@7.4 first in your PATH, run:
  echo 'export PATH="/usr/local/opt/php@7.4/bin:$PATH"' >> /Users/vincent/.bash_profile
  echo 'export PATH="/usr/local/opt/php@7.4/sbin:$PATH"' >> /Users/vincent/.bash_profile
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

```

# débloquer l'identification Mysql 8

```
mysqld_safe --skip-grant-tables &
mysql
USE mysql;
FLUSH PRIVILEGES;
ALTER USER 'root'@'localhost' IDENTIFIED BY 'root';
exit
brew services restart mysql
```

Conf mysql `vim ~/.my.cnf`

Ajouter
```
[client]
user=root
password=root
default-character-set=utf8mb4
[mysqld]
default_authentication_plugin= mysql_native_password
```


# Régler un bug avec les vielles versions

```
sudo mkdir /var/mysql
sudo ln -s /tmp/mysql.sock /var/mysql/mysql.sock
brew services restart mysql

# reset login root pass root
mysqladmin -u root -p password
enter / root / root
(mysql_secure_installation)?

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



