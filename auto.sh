#!/bin/bash
#Instalação php 5, php 7, apache2, mysql, phpmyadmin, git, vim, testado em servidores ubuntu


echo
echo "Script para ubuntu"
echo
echo "Aguarde 2 segundos..."
sleep 2
clear
echo "------Facilitando sua vida no Linux!----------"
echo
####MENU DE PROGRAMAS#####
echo "::Digite o numero e tecle enter ou para cancelar feche no (X)::

1-Update e upgrade
2-Instalar apache2
3-Instalar mysql
4-Instalar phpmyadmin 
5-Instalar php5
6-Instalar php7.0 - (servidores ubuntu 16.04)
7-Instalar git
8-Instalar vim
9-Instalar composer
10-Instalar Laravel -(servidores ubuntu 14.04 e 16.04)
11-Reiniciar o apache2
"

echo 

####INSTALAÇÃO DE PROGRAMAS#####
read programas

if [ "$programas" = "1" ];
then 
    echo "--- Iniciando update ---"
    sleep 3
	sudo apt-get update 

    echo "--- Iniciando upgrade ---"
    sleep 3
	sudo apt-get -y upgrade    
    echo "--- Fim da Atualização---"

elif [ "$programas" = "2" ];
then
    echo "--- Iniciando Instalação apache ---"
    sleep 3
    sudo apt-get -y install apache2  
    echo "--- Fim da intalação apache ---"  

elif [ "$programas" = "3" ];
then
    echo "--- Instalando MySQL  ---"
    sleep 3
    read -p "Entre com a senha Mysql somente uma vez e tecle Enter para continuar::" senha
    sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $senha"
	sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $senha"
    sudo apt-get -y install mysql-server    
    echo "--- Fim da instalação MySQL ---"   

elif [ "$programas" = "4" ];
then
    echo "--- Instalando Phpmyadmin  ---"
    sleep 3
    read -p "Entre com a senha PHPmyadmin somente uma vez e tecle Enter para continuar::" senha
    sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
    sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password $senha"
    sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password $senha"
    sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password $senha"
    sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
    sudo apt-get -y install phpmyadmin
    echo "--- Fim da Instalação Phpmyadmin ---" 

elif [ "$programas" = "5" ];
then
    echo "--- Instalando PHP 5  ---"
    sudo apt-get -y install php5 libapache2-mod-php5 php5-mcrypt

    echo "<?php phpinfo(); ?>" > /var/www/html/index.php

    echo "Permisão na pasta de desenvolvimento"
    sleep 3
    sudo chmod -R 777 /var/www/html

    echo "Reniciando Apache"
    sleep 3
    sudo /etc/init.d/apache2 restart

    echo "--- Fim da instalação PHP 5 ---"
    php -v  

elif [ "$programas" = "6" ];
then
    echo "--- instalando php 7.0  ---"
    sleep 3
    sudo apt-get -y install php libapache2-mod-php 

    echo "--- instalar cURL and Mcrypt ---"
    sleep 3
    sudo apt-get -y install php-curl
    sudo apt-get -y install php-mcrypt

    echo "<?php phpinfo(); ?>" > /var/www/html/index.php

    echo "Permisão na pasta de desenvolvimento"
    sleep 3
    sudo chmod -R 777 /var/www/html

    echo "Reniciando Apache"
    sleep 3
    sudo /etc/init.d/apache2 restart

    echo "--- Fim da instalação PHP 7 ---" 
    php -v

elif [ "$programas" = "7" ];
then
    echo "--- Instalando GIT  ---"
    sudo apt-get -y install git
	read -p "Entre com seu nome::" name
	git config --global user.name "$name"
	read -p "Entre com seu email::" email
	git config --global user.email "$email"
	git config --list
    echo "--- Fim da instalação do GIT  ---"

elif [ "$programas" = "8" ];
then 
   echo "Instalando vim" 
   sudo apt-get -y install vim
   echo "Fim da instalação vim" 

elif [ "$programas" = "9" ];
then 
   echo "Instalando composer" 
   sleep 3 
   curl -s https://getcomposer.org/installer | php
   sudo mv composer.phar /usr/local/bin/composer
   sudo chmod +x /usr/local/bin/composer
   echo "Fim da instalação composer" 

elif [ "$programas" = "10" ];
then 
    echo "instalação Laravel" 
    sleep 3 
    composer global require "laravel/installer"
    echo "Inserir nome do projeto laravel" 
    sleep 3 
    read -p "Entre com o nome do projeto::" projeto
    composer create-project laravel/laravel "$projeto" "5.1.*"
    echo "Inserido permição na pasta" 
    sleep 3 
    sudo chmod -R 777 /var/www/html/"$projeto"

echo "--- configurar arquivo host ---"
sleep 3 
read -p "Entre com o hostname::" hostname
sudo touch "$hostname" /etc/apache2/sites-available/

echo "Editando arquivo host" 
sleep 3 
VHOST=$(cat <<EOF
<VirtualHost *:80>
    ServerAdmin wesleysilva.ti@gmail.comsleep 3 
    ServerName  laravel.dev
    ServerAlias laravel.dev
    DocumentRoot "/var/www/html/${projeto}/public"
    <Directory "/var/www/html/${projeto}/public">
        AllowOverride All
        Require all granted
    </Directory>
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-available/"$hostname" 

echo "--- habilitar mod-rewrite do apache ---"
sleep 3 
sudo a2enmod rewrite
echo "--- habilitar hostname ---"
sleep 3 
sudo a2ensite "$hostname" 
echo "--- habilitar mod-rewrite do apache ---"
sleep 3 
sudo service apache2 reload
echo "--- Configurando host no ubuntu ---"
sleep 3 
sudo echo 127.0.1.7 laravel.dev >>/etc/hosts
#composer show laravel/framework


elif [ "$programas" = "11" ];
then 
   echo "Reniciando Apache"
   sleep 3 
   sudo /etc/init.d/apache2 restart
fi

####LOOP E VOLTA AO MENU#####
echo "Deseja instalar outro programa? [s/n]"
 read programas2

if [ "$programas2" = "s" ];
then 
 ./auto.sh
 
else
 exit
fi

