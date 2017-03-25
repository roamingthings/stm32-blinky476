define target hookpost-remote
    file "build/blinky476.elf"
    monitor reset
    break main
end