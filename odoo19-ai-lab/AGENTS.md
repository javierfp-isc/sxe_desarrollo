
# Instrucciones para el agente de desarrollo

## Entorno

El proyecto utiliza Odoo 19.

El entorno de ejecución se despliega mediante Docker Compose.

El IDE utilizado es Visual Studio Code.

## Fuentes OCB y OCA

Los repositorios de fuentes están disponibles en el host:

`~/odoo/src`

Dentro del contenedor Odoo se encuentran montados en:

`/opt/odoo/src`

La estructura incluye:

- `/opt/odoo/src/OCB`
- `/opt/odoo/src/extra-addons`
- Otros repositorios OCA.

## Addons del alumno

Los módulos desarrollados se almacenan en:

`./addons`

Dentro del contenedor están disponibles en:

`/opt/odoo/src/extra-addons`

## Restricciones

- No modificar los fuentes originales de OCB.
- No modificar los repositorios originales de OCA.
- No copiar módulos completos de OCA sin analizar previamente su funcionamiento y licencia.
- Utilizar los repositorios como referencia técnica.
- No inventar métodos, campos, modelos ni identificadores XML.
- Comprobar las implementaciones existentes antes de utilizar una API.
- Trabajar exclusivamente sobre los módulos del alumno.

## Procedimiento de trabajo

Antes de modificar código:

1. Analizar los requisitos.
2. Localizar funcionalidades equivalentes en OCB/OCA.
3. Identificar modelos, campos, métodos y vistas relevantes.
4. Proponer una arquitectura.
5. Presentar un plan de implementación.

Realizar cambios pequeños y verificables.

No afirmar que una prueba ha superado la ejecución si no se ha ejecutado realmente.
