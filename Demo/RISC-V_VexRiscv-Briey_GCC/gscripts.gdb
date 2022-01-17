define connect
    target remote :3333
    monitor reset halt
    load
end

define reload
    monitor reset halt
    load
end

connect
