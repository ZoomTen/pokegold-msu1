; constants
include "constants/constants.asm"

; macros
include "constants/call_macros.asm"
include "constants/const_macros.asm"
include "constants/sgb_macros.asm"

; shim file, used to provide constants
; change for different localization stuff
include "offsets/english.asm"

; patch list
include "patches/play_music.asm"
;include "patches/msu1.asm"
