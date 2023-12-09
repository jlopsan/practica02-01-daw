#!/bin/bash

# Para mostrar los comandos que se van ejecutando
#set -x 
#Actualizamos la lista de repositorios
apt update

# Actualizamos los paquetes del sistema 
apt upgrade -y

# instalamos el servidor web Nginx
apt install nginx -y

# instalamos el mysql server
apt install mysql-server -y

# instalamos php-fpm y el php-mysql
apt install php-fpm  -y
apt install php-mysql   -y
# copiamos el archivo de configuración de nginx
cp /home/ubuntu/practica02-01-daw/conf/000-default.conf /etc/nginx/sites-available/default

## Configuración de la directiva cgi.fix_pathinfo para mejorar la seguridad
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/' /etc/php/8.1/fpm/php.ini

# Reinicio el servicio php8.1-fpm
systemctl restart php8.1-fpm

# reinacioamos el el servicio de nginx
systemctl restart nginx

#Copiamos el archivo de prueba de PHP
cp /home/ubuntu/practica02-01-daw/php/index.php /var/www/html

# cambiamos el usaurio y el prpopietario de la directorio de /var/www/html
chown -R www-data:www-data /var/www/html