# use export if need System.getEnv()
# information from https://aikar.co/2018/07/02/tuning-the-jvm-g1gc-garbage-collector-flags-for-minecraft/

java -Xms256M -Xmx256M \ # you should never run your server with the case that -Xmx can run the system completely out of memory
    -XX:+UseG1GC \ # use G1 garbage collector because it operates better with the more memory it’s given
    -XX:+ParallelRefProcEnabled \ # optimizes the GC process to use multiple threads for weak reference checking
    -XX:G1NewSizePercent=40 \ # with these settings, we tell G1 to not use its default 5% for new gen, and instead give it 40%
    -XX:MaxGCPauseMillis=200 \ # controls how much memory is used in between the Minimum and Maximum ranges specified. 200 is aiming for at most loss of 4 ticks. This will result in a short TPS drop
    -XX:+UnlockExperimentalVMOptions \ # enable experemental options
    -XX:+DisableExplicitGC \ # many plugins think they know how to control memory, and try to invoke garbage collection. Plugins that do this trigger a full garbage collection, triggering a massive lags.
    -XX:+AlwaysPreTouch \ # gets the memory setup and reserved at process start ensuring it is contiguous, improving the efficiency of it more. This improves the operating systems memory access speed
    -XX:G1MaxNewSizePercent=40 \
    -XX:G1HeapRegionSize=8M \ # default is auto calculated. SUPER important for Minecraft, especially 1.15, as with low memory situations, the default calculation will in most times be too low
    -XX:G1ReservePercent=20 \ # this ensures more memory is waiting to be used for this operation
    -XX:G1HeapWastePercent=5 \
    -XX:G1MixedGCCountTarget=4 \ # default is 8. Because we are aiming to collect slower, with less old gen usage, try to reclaim old gen memory faster to avoid running out of old.
    -XX:InitiatingHeapOccupancyPercent=15 \
    -XX:G1MixedGCLiveThresholdPercent=90 \ # default is 65 to 85 depending on Java Version, we are setting to 90 to ensure we reclaim garbage in old gen as fast as possible to retain as much free regions as we can
    -XX:G1RSetUpdatingPauseTimePercent=5 \ # default is 10% of time spent during pause updating Rsets, reduce this to 5% to make more of it concurrent to reduce pause durations
    -XX:SurvivorRatio=32 \ # Because we drastically reduced MaxTenuringThreshold, we will be reducing use of survivor space drastically. This frees up more regions to be used by Eden instead
    -XX:+PerfDisableSharedMem \ # causes GC to write to file system which can cause major latency if disk IO is high
    -XX:MaxTenuringThreshold=1 \ # ensures that we do not promote transient data to old generation, but anything that survives 2 passes of Garbage Collection is just going to be assumed as longer-lived
    -Dusing.aikars.flags=https://mcflags.emc.gs \
    -Daikars.new.flags=true \
    -jar papper.jar # CHANGE NAME IF NEEDEED
