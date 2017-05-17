Détail install #apache sur Mac Osx

Vérifier que tout va bien : `apachectl configtest`
En cas de soucis voir : https://apple.stackexchange.com/questions/211015/el-capitan-apache-error-message-ah00526

Config des modules apache : `sudo vim /etc/apache2/httpd.conf`

Décommenter
```
LoadModule php5_module libexec/apache2/libphp5.so
LoadModule userdir_module libexec/apache2/mod_userdir.so

Include /private/etc/apache2/extra/httpd-userdir.conf
```

Activer les préférences utilisateurs `sudo vim /etc/apache2/extra/httpd-userdir.conf`

Décommenter 
```
Include /private/etc/apache2/users/*.conf
```

Déclarer un fichier de configuration utilisateur `sudo vim /etc/apache2/users/USERNAME.conf` qui inclut des vhosts persos dans placés dans `/Sites` de manière à les changer facilement.

Ajouter 
```
Include /Users/USER/Sites/httpd-vhosts.conf
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

Note : plutôt que de passer par les `httpd-userdir.conf` peut-être vaut-il mieux passer par `Include /private/etc/apache2/extra/httpd-vhosts.conf` car en fait on a pas vraimment plusieurs utilisateurs sur la machine...

Voir : https://coolestguidesontheplanet.com/set-virtual-hosts-apache-mac-osx-10-10-yosemite/

Attention à la version d'apache pour déclarer le fichier  : https://coolestguidesontheplanet.com/forbidden-403-you-dont-have-permission-to-access-username-on-this-server/

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

# Mysql

```
brew install mysql
brew services list # pour démarrer mysql

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

Régler un bug 

```
sudo mkdir /var/mysql
sudo ln -s /tmp/mysql.sock /var/mysql/mysql.sock
```

en cas de soucis de mot de passe root

```
mysqladmin -u root -p password

When it asks for a password, not not enter anything, just hit enter. It will then ask you to enter new password, then confirm. Finished.
```
