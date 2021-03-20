; Main fading routine inside the audio engine

SECTION "Fade Music", ROMX[FadeMusic], BANK[BANK_FadeMusic]
PATCH_FadeMusic::
	jp FadeMusic_CheckFade
	nop
	nop
PATCH_FadeMusic_Continue:

; Fires when a new song is loaded

SECTION "Load Audio from Fade 1", ROMX[FadeMusic_LoadNewSong1], BANK[BANK_FadeMusic_LoadNewSong1]
PATCH_FadeMusic_LoadNewSong1::
	call FadeMusic_LoadMusicOnGBC
	pop bc
	xor a
	ld [wMusicFade], a
	ret

; Fires when a new song is ABOUT to be loaded

SECTION "Load Audio from Fade 2", ROMX[FadeMusic_LoadNewSong2], BANK[BANK_FadeMusic_LoadNewSong2]
PATCH_FadeMusic_LoadNewSong2::
	call FadeMusic_LoadMusicOnGBC
	pop bc
	ld hl, wMusicFade
	set 7, [hl]	; set MUSIC_FADE_IN_F, [hl]
	ret

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

FadeMusic_LoadMusicOnGBC:
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
	

SECTION "Fade Music Hometo", ROM0[Bank00_FreeSpace]
Home_PlayMusicFadeTo:
	homecall PATCH_PlayMusic_WithFade
	ret

SECTION "Fade Music ForceNewTune", ROM0[HOME_MSU1TuneScratch]
Home_ForceNewMSU1Tune:
	homecall ForceNewMSU1Tune
	ret
