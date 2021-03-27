SECTION "Fade Music Hometo", ROM0[Bank00_FreeSpace]
Home_PlayMusicFadeTo:
	homecall PATCH_PlayMusic_WithFade
	ret

; This is placed in the scratch space before the GameBoy header

SECTION "ForceNewTune", ROM0[HOME_MSU1TuneScratch]
Home_ForceNewMSU1Tune:
	homecall ForceNewMSU1Tune
	ret

Home_CheckSFXAndMusicOffRedirect:
	homecall _CheckSFXAndMusicOffRedirect
	jp Music_MusicOff

Home_WaitSFX_Cont:
	ld hl, wChannel8Flags1
	bit 0, [hl]
	jp nz, PATCH_WaitSFX.wait
	pop hl
	ldh a, [hSGB]
	and a
	ret z
	homecall _CallRestoreMusicMSU1
	ret
