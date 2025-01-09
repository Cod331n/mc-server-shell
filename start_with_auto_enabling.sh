# use for sutiations, when you need to automatically enable your server to be started if it stopped.
# this shell file should be in the same dir with server jar file, or you can cd to it by your own

# change if you have another name
JAR_FILE="paper.jar"

# checking interval of server is enabled or not
CHECK_INTERVAL=10

is_server_running() {
    if screen -list | grep -q "minecraft"; then
        return 0
    else
        return 1
    fi
}

# use start.sh from
# https://github.com/Cod331n/mc-server-shell/blob/main/start.sh
start_server() {
    echo "Server was stopped. Enabling..."
    # chmod +x start.sh
    # it's necessary to have permissions to start this file
    ./start.sh
}

while true; do
    if ! is_server_running; then
        start_server
    fi
    sleep $CHECK_INTERVAL
done
