# use for situations, when you need to automatically enable your server to be started if it was stopped.
# this shell file should be in the same dir with server jar file, or you can cd to it by your own

# delay before enabling
ENABLE_DELAY=10

# use start.sh from
# https://github.com/Cod331n/mc-server-shell/blob/main/start.sh
start_server() {
    echo "Enabling server..."
    chmod +x start.sh
    ./start.sh
}

while true; do
    start_server
    echo "Server has been stopped."
    sleep $ENABLE_DELAY
done
