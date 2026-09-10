FROM odoo:19-auto

#Instalamos el módulo ptvsd de python
RUN pip3 install ptvsd  --break-system-packages

CMD ["python3", "/opt/odoo/src/OCB/odoo-bin", "-c", "/opt/odoo/odoo.conf"]
