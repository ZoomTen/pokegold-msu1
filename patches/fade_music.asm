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
