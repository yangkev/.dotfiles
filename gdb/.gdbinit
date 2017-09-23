# Reduce tui mode winheight
winheight SRC -10

# Include STL pretty printer
source ~/.gdb/.stl_pretty

set print pretty on
set print array on

# Enable local .gdbinit loading
set auto-load local-gdbinit
set auto-load safe-path ~/
set auto-load safe-path /
add-auto-load-safe-path /usr/um/gcc-5.1.0/lib64/
