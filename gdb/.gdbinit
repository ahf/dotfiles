# Use intel assembly syntax instead of AT&T syntax.
set disassembly-flavor intel

# Disable annoying pagination
set pagination off
set height 0
set width 0

# Disable confirmation and verbose output.
set confirm off
set verbose off

# Fancy prompt.
set prompt \033[32m(gdb) \033[0m

# Enable pretty-printing of certain objects.
set print pretty on
set print array on
set print asm-demangle on
set print demangle on
set print object on
set print static-members off
set print vtbl on
