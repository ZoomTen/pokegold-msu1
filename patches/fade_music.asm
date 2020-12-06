SECTION "Fade Music", ROMX[FadeMusic], BANK[BANK_FadeMusic]
PATCH_FadeMusic::
	jp FadeMusic_CheckFade
	nop
	nop
PATCH_FadeMusic_Continue:

SECTION "Load Audio from Fade 1", ROMX[FadeMusic_LoadNewSong1], BANK[BANK_FadeMusic_LoadNewSong1]
PATCH_FadeMusic_LoadNewSong1::
	call FadeMusic_LoadMusicOnGBC
	pop bc
	xor a
	ld [wMusicFade], a
	ret

SECTION "Load Audio from Fade 2", ROMX[FadeMusic_LoadNewSong2], BANK[BANK_FadeMusic_LoadNewSong2]
PATCH_FadeMusic_LoadNewSong2::
	call FadeMusic_LoadMusicOnGBC
	pop bc
	ld hl, wMusicFade
	set 7, [hl]	; set MUSIC_FADE_IN_F, [hl]
	ret

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
	farcall PATCH_PlayMusic_WithFade	; see patches/bank_02.asm
	jp PATCH_FadeMusic_Continue
	ret
.nofade
	xor a
	ld [wIsInFade], a
	ld [wCheckAndFadeMusicID], a
	ret

FadeMusic_LoadMusicOnGBC:
	ld a, [hSGB]
	and a
	ret nz
	ld a, [wMusicFadeID]
	ld e, a
	ld a, [wMusicFadeID+1]
	ld d, a
	jp _PlayMusic
