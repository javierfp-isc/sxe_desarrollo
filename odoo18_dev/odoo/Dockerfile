FROM javierfpisc/odoo:v18conpostgres

LABEL MAINTAINER=javierfp@iessanclemente.net

#Copiamos el entrypoint.sh al container
COPY entrypoint.sh /usr/bin/entrypoint.sh

#Damos permiso al entrypoint
RUN chmod +x /usr/bin/entrypoint.sh

#Copiamos el archivo odoo.conf
COPY odoo.conf /opt/odoo/odoo.conf

#Copiamos el service odoo.sh
COPY odoo.sh /etc/init.d/odoo.sh

#Instalamos el módulo ptvsd de python
RUN pip3 install ptvsd  --break-system-packages

#Comando para arrancar ssh y entrar en bucle de espera
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
