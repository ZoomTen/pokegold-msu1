SECTION "Play Music", ROM0[PlayMusic]
PATCH_PlayMusic:
	push hl
	push de
	push bc
	push af
	homecall PATCH_PlayMusic_Redirect
	pop af
	pop bc
	pop de
	pop hl
	ret

SECTION "Play Music with Silence", ROM0[PlayMusic2]
PATCH_PlayMusic2:
	push hl


SECTION "Bank 2 Code", ROMX[Bank02_FreeSpace], BANK[$02]
PATCH_PlayMusic_Redirect:
	ldh a, [hSGB]
	and a
	jr nz, .on_sgb
; do GBC code
	ld a, e
	and a
	jr z, .gbc_no_music
	farcall BANK__PlayMusic, _PlayMusic
	ret
.gbc_no_music
	farcall BANK__InitSound, _InitSound
	ret
; SGB code goes here
.on_sgb
	ret
