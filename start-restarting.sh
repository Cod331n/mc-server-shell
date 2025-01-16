RESTART_PERIOD=3600 # restart time period in seconds

is_server_running() {
    if screen -list | grep -q minecraft; then
        return 0
    else
        return 1
    fi
}

start_server() {
    echo "Enabling server..."
    chmod +x start.sh
    screen -dmS minecraft ./start.sh 
}

stop_server() {
    screen -S minecraft -X stuff "stop\n"
    sleep 5
    screen -S minecraft -X quit
}

while true; do
    if ! is_server_running; then
        start_server
    fi
    
    sleep $RESTART_PERIOD
    stop_server
done
