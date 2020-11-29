SECTION "Fade Music", ROMX[FadeMusic], BANK[BANK_FadeMusic]
PATCH_FadeMusic::
	jp PATCH_FadeMusic_CheckFade
	nop
	nop
PATCH_FadeMusic_Continue:

SECTION "Fade Music (Home)", ROMX[Bank3a_FreeSpace], BANK[$3a]
PATCH_FadeMusic_CheckFade::
	ld a, [wMusicFade]
	and a
	jr z, .nofade
	ld a, %00000010
	ld [wCheckAndFadeMusicID], a
	farcall PATCH_PlayMusic_WithFade	; see patches/bank_02.asm
	jp PATCH_FadeMusic_Continue
	ret
.nofade
	xor a
	ld [wIsInFade], a
	ld [wCheckAndFadeMusicID], a
	ret
