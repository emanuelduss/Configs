#
# ~/.gdbconfig
#

set disassembly-flavor intel

define hook-stop
info registers
x/24wx $esp
^x/5i $eip
end
