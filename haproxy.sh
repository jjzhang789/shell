# !/bin/sh
# config:      /usr/local/haproxy/conf/haproxy.cfg
# pidfile:     /usr/local/haproxy/logs/haproxy.pid
# Source function library.
. /etc/rc.d/init.d/functions
# Source networking configuration.
. /etc/sysconfig/network
# Check that networking is up.
[ "$NETWORKING" = "no" ] && exit 0

config="/usr/local/haproxy/conf/haproxy.cfg"
exec="/usr/local/haproxy/sbin/haproxy"

prog=$(basename $exec)

[ -e /etc/sysconfig/$prog ] && . /etc/sysconfig/$prog

lockfile=/var/lock/subsys/haproxy

check() {
    $exec -c -V -f $config
}

start() {
    $exec -c -q -f $config
    if [ $? -ne 0 ]; then
        echo "Errors in configuration file, check with $prog check."
        return 1
    fi
     echo -n $"Starting $prog: "
    # start it up here, usually something like "daemon $exec"
    daemon $exec -D -f $config -p /usr/local/haproxy/logs/$prog.pid
    retval=$?
    echo
    [ $retval -eq 0 ] && touch $lockfile
    return $retval
}

stop() {
    echo -n $"Stopping $prog: "
    # stop it here, often "killproc $prog"
    killproc $prog 
    retval=$?
    echo
    [ $retval -eq 0 ] && rm -f $lockfile
    return $retval
}

restart() {
    $exec -c -q -f $config
    if [ $? -ne 0 ]; then
        echo "Errors in configuration file, check with $prog check."
        return 1
    fi
    stop
    start
}

reload() {
    $exec -c -q -f $config
    if [ $? -ne 0 ]; then
        echo "Errors in configuration file, check with $prog check."
        return 1
    fi
    echo -n $"Reloading $prog: "
    $exec -D -f $config -p /usr/local/haproxy/logs/$prog.pid -sf $(cat /usr/local/
    haproxy/logs/$prog.pid)
    retval=$?
    echo
    return $retval
}

force_reload() {
    restart
}

fdr_status() {
    status $prog
}

case "$1" in
    start|stop|restart|reload)
        $1
        ;;

    force-reload)
        force_reload
        ;;

    checkconfig)
        check
        ;;

    status)
        fdr_status
        ;;

    condrestart|try-restart)
        [ ! -f $lockfile ] || restart
        ;;

    *)
echo $"Usage: $0 {start|stop|status|checkconfig|restart|try-restart|reload|force-reload}"
        exit 2
esac