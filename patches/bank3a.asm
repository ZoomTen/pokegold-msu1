; Redirected routine to set the fading flags

SECTION "Fade Music Redirect", ROMX[Bank3a_FreeSpace], BANK[$3a]
FadeMusic_CheckFade::
	ld a, [wMusicFade]
	and a
	jr z, .nofade
	ld a, [hSGB]
	and a
	jr z, .gbc_fade
	ld a, [wMusicFade]
	bit 7, a
	jp nz, PATCH_FadeMusic_Continue	; don't fade in for SGB
.gbc_fade
	ld a, %00000010
	ld [wCheckAndFadeMusicID], a
	call Home_PlayMusicFadeTo	; see patches/msu1_play.asm
	jp PATCH_FadeMusic_Continue
.nofade
	xor a
	ld [wIsInFade], a
	ld [wCheckAndFadeMusicID], a
	ret

FadeMusic_LoadMusicOnGBC::
	ld a, [hSGB]
	and a
	jr nz, .load_sgb
	ld a, [wMusicFadeID]
	ld e, a
	ld a, [wMusicFadeID+1]
	ld d, a
	jp _PlayMusic
.load_sgb
	ld a, [wMusicFadeID]
	ld e, a
	ld a, [wMusicFadeID+1]
	ld d, a
	call Home_ForceNewMSU1Tune
	ret
