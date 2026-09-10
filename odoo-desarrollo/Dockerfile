FROM odoo:19-auto

COPY ./odoo.sh /etc/init.d/odoo.sh
RUN chmod +x /etc/init.d/odoo.sh

#Instalamos el módulo debugpy de python
RUN pip3 install debugpy --break-system-packages

CMD ["python3", "/opt/odoo/src/OCB/odoo-bin", "-c", "/opt/odoo/odoo.conf"]
