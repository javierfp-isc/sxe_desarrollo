#!/bin/bash

#Sustituimos las variables de entorno en el odoo.conf
sed -i "s/db_host = DBHOST/db_host = $DBHOST/" /opt/odoo/odoo.conf
sed -i "s/db_user = DBUSER/db_user = $DBUSER/" /opt/odoo/odoo.conf
sed -i "s/db_password = DBPASS/db_password = $DBPASS/" /opt/odoo/odoo.conf
sed -i "s/admin_passwd = ADMINPASS/admin_passwd = $ADMINPASS/" /opt/odoo/odoo.conf
sed -i "s%logfile = LOGFILE%logfile = $LOGFILE%" /opt/odoo/odoo.conf
sed -i "s/VERSION/$VERSION/" /opt/odoo/odoo.conf
#Sustituimos las variables de entorno en el odoo.sh
sed -i "s/VERSION/$VERSION/" /etc/init.d/odoo.sh

#Arrancamos servicios
service ssh start
service postgresql start

#Creamos el archivo de log y cambiamos propietario
touch $LOGFILE
chown $ODOOUSER $LOGFILE

#Crea el usuario odoo en postgres
su - postgres -c "createuser --createdb $DBUSER" && su - postgres -c "psql -c \"alter role $DBUSER with password '$DBPASS'\""

#Escribe en /etc/hosts para que resuelva postgres al localhost
echo "127.0.0.1 postgres" >> /etc/hosts

#Arranca odoo (while: la primera vez no arranca bien)
while [[ ! $(service odoo.sh start) ]];do continue;done

#Uso exec para lanzar un proceso independiente de bucle infinito
exec bash -c "while true;do sleep 10;done"

