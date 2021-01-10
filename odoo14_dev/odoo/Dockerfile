FROM javierfpisc/odoo:v13conpostgres

MAINTAINER javierfp <javierfp@iessanclemente.net>

#Copiamos el entrypoint.sh al container
COPY entrypoint.sh /usr/bin/entrypoint.sh

#Damos permiso al entrypoint
RUN set -x; \
	chmod +x /usr/bin/entrypoint.sh

#Copiamos el archivo odoo.conf
COPY odoo.conf /opt/odoo/odoo.conf

#Copiamos el service odoo.sh
COPY odoo.sh /etc/init.d/odoo.sh

#Instalamos el módulo ptvsd de python
RUN set -x; \
	pip3 install ptvsd

#Comando para arrancar ssh y entrar en bucle de espera
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
