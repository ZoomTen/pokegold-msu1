; Common call used to play BGM

SECTION "Play Music", ROM0[PlayMusic]
PATCH_PlayMusic::
	push hl
	push de
	push bc
	call PlayMusic_Common
	pop bc
	pop de
	pop hl
	ret
PlayMusic_Common:
	homecall PATCH_PlayMusic_Redirect	; see patches/msu1_play.asm
	ret

; Some sequences call this routine which plays BGM 00 beforehand (clearing everything)

SECTION "Play Music with Silence", ROM0[PlayMusic2]
PATCH_PlayMusic2::
	push hl
	push bc
	push de

		ld de, 0
		call PlayMusic_Common

		call DelayFrame

	pop de
	call PlayMusic_Common

	pop bc
	pop hl
	ret

; Redirect WaitSFX
SECTION "WaitSFX", ROM0[WaitSFX]
PATCH_WaitSFX:
	push hl
.wait
	ld hl, wChannel5Flags1
	bit 0, [hl]
	jr nz, .wait
	ld hl, wChannel6Flags1
	bit 0, [hl]
	jr nz, .wait
	ld hl, wChannel7Flags1
	bit 0, [hl]
	jr nz, .wait
	jp PATCH_WaitSFX_Cont	; see fade_music.asm

; This routine is called inside scripts

SECTION "Play Music in Script", ROMX[Script_playmusic], BANK[BANK_Script_playmusic]
PATCH_Script_playmusic::
	call DelayFrame
	call DelayFrame		; delay a few frames to make the SGB happy
	xor a
	ld [wMusicFade], a
	call MaxVolume
	call GetScriptByte
	ld e, a
	call GetScriptByte
	ld d, a
	call PATCH_PlayMusic2	; call music with silence
	ret
