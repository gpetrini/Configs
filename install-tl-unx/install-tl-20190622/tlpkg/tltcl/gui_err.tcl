#!/usr/bin/env wish

# fonts
# no bold text for messages; `userDefault' indicates priority
catch {option add *Dialog.msg.font TkDefaultFont userDefault}
# width of '0', as a rough estimate of average character width
set ::cw 8
catch {set ::cw [font measure TkDefaultFont "0"]}

wm title . "Warning/Error"
label .l -text $::env(RUNSCRIPT_ERROR_MESSAGE) -wraplength [expr {60*$::cw}]
pack .l -padx 6 -pady 3
pack [button .q -text "Ok" -command exit] -ipadx 3 -pady 3
