#!/bin/sh

########################################################
# Odoo init script - Docker/Debian
# Odoo + Python + debugpy
########################################################

PATH=/bin:/sbin:/usr/bin:/usr/sbin

NAME="odoo"
DESC="ODOO-SERVER"

# ------------------------------------------------------
# Configuración
# ------------------------------------------------------

DAEMON="/usr/bin/python3"
DAEMON_SCRIPT="/opt/odoo/src/OCB/odoo-bin"
CONFIGFILE="/opt/odoo/odoo.conf"

USER="odoo"
PIDFILE="/var/run/${NAME}.pid"

# Debugger
DEBUG_HOST="0.0.0.0"
DEBUG_PORT="5678"

DAEMON_ARGS="-m debugpy --listen ${DEBUG_HOST}:${DEBUG_PORT} ${DAEMON_SCRIPT} -c ${CONFIGFILE}"


# ------------------------------------------------------
# Comprobaciones iniciales
# ------------------------------------------------------

if [ ! -x "$DAEMON" ]; then
    echo "ERROR: Python no existe o no es ejecutable:"
    echo "       $DAEMON"
    exit 1
fi

if [ ! -x "$DAEMON_SCRIPT" ]; then
    echo "ERROR: Odoo daemon no existe o no es ejecutable:"
    echo "       $DAEMON_SCRIPT"
    exit 1
fi

if [ ! -r "$CONFIGFILE" ]; then
    echo "ERROR: Odoo config no existe o no es legible:"
    echo "       $CONFIGFILE"
    exit 1
fi


# ------------------------------------------------------
# Obtener PIDs de Odoo
# ------------------------------------------------------

get_pids()
{
    ps -Ao pid=,args= |
        grep -F -- "$DAEMON_SCRIPT" |
        grep -v "grep" |
        awk '{print $1}'
}


# ------------------------------------------------------
# Comprobar estado
# ------------------------------------------------------

check_status()
{
    PIDS=$(get_pids)

    if [ -z "$PIDS" ]; then
        return 0
    fi

    return 1
}


# ------------------------------------------------------
# Iniciar Odoo
# ------------------------------------------------------

do_start()
{
    echo "Starting ${DESC}..."

    PIDS=$(get_pids)

    if [ -n "$PIDS" ]; then
        echo "ERROR: ${DESC} ya está ejecutándose."
        echo "PID(s): $PIDS"
        return 1
    fi

    # Aseguramos que /var/run existe
    mkdir -p "$(dirname "$PIDFILE")"

    # Eliminar PID antiguo si existe
    if [ -f "$PIDFILE" ]; then
        rm -f "$PIDFILE"
    fi

    start-stop-daemon \
        --start \
        --quiet \
        --pidfile "$PIDFILE" \
        --chuid "$USER" \
        --background \
        --make-pidfile \
        --exec "$DAEMON" \
        -- $DAEMON_ARGS

    RESULT=$?

    if [ "$RESULT" -ne 0 ]; then
        echo "ERROR: no se pudo iniciar ${DESC}."
        return "$RESULT"
    fi

    # Dar un pequeño margen para que arranque
    sleep 2

    PIDS=$(get_pids)

    if [ -n "$PIDS" ]; then
        echo "${DESC} iniciado correctamente."
        echo "PID(s): $PIDS"
        echo "Debugpy: ${DEBUG_HOST}:${DEBUG_PORT}"

        if [ -f "$PIDFILE" ]; then
            echo "PIDFILE: $PIDFILE"
        fi

        return 0
    fi

    echo "ERROR: ${DESC} no aparece ejecutándose después del arranque."

    # Intentamos mostrar información útil si el proceso murió
    if [ -f "$PIDFILE" ]; then
        echo "PIDFILE contents:"
        cat "$PIDFILE"
    fi

    return 1
}


# ------------------------------------------------------
# Detener Odoo
# ------------------------------------------------------

do_stop()
{
    echo "Stopping ${DESC}..."

    PIDS=$(get_pids)

    if [ -z "$PIDS" ]; then
        echo "${DESC} ya está detenido."
        rm -f "$PIDFILE"
        return 0
    fi

    start-stop-daemon \
        --stop \
        --quiet \
        --pidfile "$PIDFILE"

    RESULT=$?

    sleep 1

    PIDS=$(get_pids)

    if [ -n "$PIDS" ]; then
        echo "ERROR: ${DESC} sigue ejecutándose."
        echo "PID(s): $PIDS"
        return 1
    fi

    rm -f "$PIDFILE"

    echo "${DESC} detenido correctamente."

    return "$RESULT"
}


# ------------------------------------------------------
# Detención forzada
# ------------------------------------------------------

force_stop()
{
    echo "Forcely stopping ${DESC}..."

    PIDS=$(get_pids)

    if [ -z "$PIDS" ]; then
        echo "${DESC} ya está detenido."
        rm -f "$PIDFILE"
        return 0
    fi

    echo "Matando PID(s): $PIDS"

    kill -9 $PIDS 2>/dev/null

    sleep 1

    PIDS=$(get_pids)

    if [ -n "$PIDS" ]; then
        echo "ERROR: no se pudieron detener todos los procesos."
        echo "PID(s): $PIDS"
        return 1
    fi

    rm -f "$PIDFILE"

    echo "${DESC} detenido."

    return 0
}


# ------------------------------------------------------
# Información detallada
# ------------------------------------------------------

show_status()
{
    PIDS=$(get_pids)

    if [ -z "$PIDS" ]; then
        echo "${DESC}: STOPPED"
        return 3
    fi

    echo "${DESC}: RUNNING"
    echo
    echo "Process ID(s):"
    echo "$PIDS"
    echo

    for PID in $PIDS
    do
        echo "PID: $PID"
        ps -p "$PID" -o pid,ppid,user,etime,args=
        echo
    done

    if [ -f "$PIDFILE" ]; then
        echo "PIDFILE: $PIDFILE"
        echo "PIDFILE contents: $(cat "$PIDFILE")"
    fi

    echo
    echo "Debugpy: ${DEBUG_HOST}:${DEBUG_PORT}"

    return 0
}


# ------------------------------------------------------
# Reinicio
# ------------------------------------------------------

do_restart()
{
    echo "Restarting ${DESC}..."

    do_stop

    RESULT=$?

    if [ "$RESULT" -ne 0 ]; then
        echo "ERROR: no se pudo detener ${DESC}."
        return "$RESULT"
    fi

    sleep 1

    do_start

    return $?
}


# ------------------------------------------------------
# Main
# ------------------------------------------------------

case "$1" in

    start)
        do_start
        exit $?
        ;;

    stop)
        do_stop
        exit $?
        ;;

    restart|reload)
        do_restart
        exit $?
        ;;

    force-restart)
        force_stop
        sleep 1
        do_start
        exit $?
        ;;

    force-stop)
        force_stop
        exit $?
        ;;

    status)
        show_status
        exit $?
        ;;

    cs)
        PIDS=$(get_pids)

        if [ -z "$PIDS" ]; then
            echo "0"
        else
            echo "$PIDS" | wc -w
        fi

        exit 0
        ;;

    *)
        echo "Usage: $0 {start|stop|restart|reload|force-restart|force-stop|status|cs}"
        exit 1
        ;;

esac

