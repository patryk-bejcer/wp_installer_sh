#!/bin/bash

# Created new database on mysql in Ubuntu 16.04
#
# Author: Patryk Bejcer
# Created: 10.05.2018
# Last Update: 10.05.2018

##### Functions #####

# Create new mysql database

# if [ which apache2 ] ; then
#   echo "Masz plik .bashrc"
# fi


# !!!!!!!!!!!! INFO DLA MATEUSZA  !!!!!!!!!!!!!
# jescze nie ma sprawdzania apache/php/ itp
# no i nie konifuguruje jescze plikow wp-config itp.
# jak cos to jescze dorobimy powiedz instalacje pluginow ktorych zazwyczaj uzywamy 
# to by bylo fajne calkiem no i np. tworzenie htaccess skonifgurowanego bo tego tez nie ma domyslnie

function createNewDatabase {

    # User interaction
    echo -n "Podaj login do MySQL: "
    read  rootLogin
    echo -n "Podaj hasło do MySQL: "
    read -s rootPassword
    echo ""
    echo -n "Podaj nazwę bazy danych którą chcesz utworzyć: "
    read  nameDB
    echo ""

    # Login to mysql and execute create database command
    mysql -v -u$rootLogin -p$rootPassword -e "CREATE DATABASE $nameDB;" 

}

function downloadCMS {

    #Read path to execute wordpress archive with lasted version
    echo -n "Podaj ścieżkę w której ma być zainstalowany CMS (np. /var/www/html/mynewwebsite): "
    echo ""
    echo -n "Pamiętaj aby katalog w którym CMS zostanie zainstalowany był wcześniej utworzony (skrypt nie tworzy nowego katalogu) "
    read  installPath

    # Check if is tar.gz is download
    if test -f /tmp/latest.tar.gz 
    then
        echo "Twój CMS jest już pobrany"
    # Download files for the first time by wget in temp folder 
    else
        echo "Trwa pobieranie plików CMS do instalacji"
        cd /tmp/ && wget "http://wordpress.org/latest.tar.gz"
    fi

}

function unpackCMS {
    echo "Sciezka: $installPath"
    # Extract the installation archive
    tar -C $installPath -zxf /tmp/latest.tar.gz --strip-components=1
}

# Main 
createNewDatabase
downloadCMS
unpackCMS

echo -n "Koniec programu!"
echo ""