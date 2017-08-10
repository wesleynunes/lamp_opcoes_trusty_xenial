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
8-Reiniciar o apache2
9-Instalar vim"

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
    sudo apt-get -y install apache2  
    echo "--- Fim da intalação apache ---"  

elif [ "$programas" = "3" ];
then
    echo "--- Instalando MySQL  ---"
    read -p "Entre com a senha Mysql somente uma vez e tecle Enter para continuar::" senha
    sudo debconf-set-selections <<< "mysql-server mysql-server/root_password password $senha"
	sudo debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $senha"
    sudo apt-get -y install mysql-server    
    echo "--- Fim da instalação MySQL ---"   

elif [ "$programas" = "4" ];
then
    echo "--- Instalando Phpmyadmin  ---"
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
   echo "Reniciando Apache"
   sleep 3 
   sudo /etc/init.d/apache2 restart

elif [ "$programas" = "9" ];
then 
   echo "Instalando vim" 
   sudo apt-get -y install vim
   echo "Fim da instalação vim" 
   
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

