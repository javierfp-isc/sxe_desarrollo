FROM javierfpisc/odoo:v13conpostgres

MAINTAINER javierfp <javierfp@iessanclemente.net>

#Copiamos el entrypoint.sh al container
COPY entrypoint.sh /usr/bin/entrypoint.sh

#Damos permiso al entrypoint
RUN set -x; \
	chmod +x /usr/bin/entrypoint.sh

#Copiamos el archivo odoo.conf
COPY odoo.conf /opt/odoo/odoo.conf

#Cambiamos la ruta del service para que tome los fuentes de la v12 de odoo
RUN set -x; \
	sed -i "s%/opt/odoo/src/OCB/odoo-bin%/opt/odoo/src/OCB12/odoo-bin%" /etc/init.d/odoo.sh

#Comando para arrancar ssh y entrar en bucle de espera
ENTRYPOINT ["/usr/bin/entrypoint.sh"]
