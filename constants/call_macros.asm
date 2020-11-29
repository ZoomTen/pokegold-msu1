farcall: MACRO ; bank, address
if _NARG >= 2
	ld a, \1
	ld hl, \2
	rst rst_FarCall
else
	ld a, BANK(\1)
	ld hl, \1
	rst rst_FarCall
endc
ENDM

homecall: MACRO
if _NARG >= 2
	ldh a, [hROMBank]
	push af
	ld a, \1
	rst rst_Bankswitch
	call \2
	pop af
	rst rst_Bankswitch
else
	ldh a, [hROMBank]
	push af
	ld a, BANK(\1)
	rst rst_Bankswitch
	call \1
	pop af
	rst rst_Bankswitch
endc
ENDM
