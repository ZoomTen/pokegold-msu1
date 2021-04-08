SECTION "Fade Music Hometo", ROM0[Bank00_FreeSpace]
Home_PlayMusicFadeTo::
	homecall PATCH_PlayMusic_WithFade
	ret

SECTION "Sound Text Commands", ROM0[TextCommand_SOUND]
PATCH_TextCommand_SOUND::
	jp PATCH_TextCommand_SOUND_Redirect
PATCH_TextCommand_SOUND_Continue::

; This is placed in the scratch space before the GameBoy header

SECTION "ForceNewTune", ROM0[HOME_MSU1TuneScratch]
Home_ForceNewMSU1Tune::
	homecall ForceNewMSU1Tune
	ret

Home_CheckSFXAndMusicOffRedirect::
	homecall _CheckSFXAndMusicOffRedirect
	ld a, [wSFXNoRun]
	and a
	jr nz, .clr_no_run
	call Music_MusicOff
	jp PATCH_PlaySFX_Cont
.clr_no_run
	xor a
	ld [wSFXNoRun], a
	ret

Home_WaitSFX_Cont::
	ld hl, wChannel8Flags1
	bit 0, [hl]
	jp nz, PATCH_WaitSFX.wait
	pop hl
	ldh a, [hSGB]
	and a
	ret z
	push de
	homecall _CallRestoreMusicMSU1
	pop de
	ret

PATCH_TextCommand_SOUND_Redirect::
; bc = pointer to screen buffer
; hl = pointer to text data
; de = pointer to routine
	push bc
	dec hl	; get txsound byte

	ldh a, [hSGB]
	and a
	jr z, .gbc

	ld a, [hl+]
	cp $10 ; is caught mon SFX?
	jp nz, PATCH_TextCommand_SOUND_Continue
	push hl
	homecall _PlayCaughtMonFanfare
	push de
	pop de
	pop hl
	pop bc
	ret

.gbc
	ld a, [hl+]
	jp PATCH_TextCommand_SOUND_Continue
	
