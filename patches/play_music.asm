SECTION "Play Music", ROM0[PlayMusic]
PATCH_PlayMusic:
	push hl
	push de
	push bc
	push af
	homecall PATCH_PlayMusic_Redirect	; see patches/bank_02.asm
	pop af
	pop bc
	pop de
	pop hl
	ret

SECTION "Play Music with Silence", ROM0[PlayMusic2]
PATCH_PlayMusic2:
	push hl
