SECTION "Play Music", ROM0[PlayMusic]
PATCH_PlayMusic:
	push hl
	push de
	push bc
	push af
	call PlayMusic_Common
	pop af
	pop bc
	pop de
	pop hl
	ret
PlayMusic_Common:
	homecall PATCH_PlayMusic_Redirect	; see patches/bank_02.asm
	ret

SECTION "Play Music with Silence", ROM0[PlayMusic2]
PATCH_PlayMusic2:
	push hl
	push de
	push bc
	push af

	push de
	ld de, 0
	call PlayMusic_Common

	call DelayFrame

	pop de
	call PlayMusic_Common

	pop af
	pop bc
	pop de
	pop hl
	ret
