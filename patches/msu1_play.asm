SECTION "Bank 2 Code", ROMX[Bank02_FreeSpace], BANK[$02]

; These are the routines that actually handle the MSU-1
; music play

; play music with fading in
PATCH_PlayMusic_WithFade::
	ld a, [wIsInFade]
	and a
	ret nz
	ldh a, [hSGB]
	and a
	ret z
	
	push de
	  xor a
	  ld d, a
	  ld e, a
	  call SGB_PlayMusic_Common
	pop de
	
	ld a, 1
	ld [wIsInFade], a
	ret
	
; force no fade
; see patches/play_music.asm
PATCH_PlayMusic_Redirect::
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
	
; If SGB, go here
.on_sgb
	xor a
	ld [wCheckAndFadeMusicID], a
	; fallback here

SGB_PlayMusic_Common::
; de = music id
	ld a, e
	and a
	jr z, .stop_music

	ld c, $10	; SGB packet size

; copy MSU1 call template to RAM
	push de
	  ld hl, MSU1SoundTemplate
	  ld de, wMSU1PacketSend
.copy_template
	  ld a, [hl+]
	  ld [de], a
	  inc de
	  dec c
	  jr nz, .copy_template
	pop de
	ld a, [wCheckAndFadeMusicID]
	and a, %00000010		; grab just the fade bit
	or a, 1				; enable restart
	ld hl, wMSU1PacketSend + 5
	ld [hli], a			; ask for a restart
					; wMSU1PacketSend + 6
	ld a, e
	ld [hli], a			; set new track ID
					; wMSU1PacketSend + 7
	inc hl				; wMSU1PacketSend + 8
	inc hl				; wMSU1PacketSend + 9
; determine looping mode
	push hl
	ld hl, MSU1_LoopingModes
	add hl, de
	ld a, [hl]
	pop hl
	ld [hl], a			; set looping mode

; send the built packet over
	ld hl, wMSU1PacketSend
	jp _PushSGBPals

.stop_music
	ld a, [wCheckAndFadeMusicID]
	and a, %00000010		; grab just the fade bit
	jr z, .stop_nofade
	ld hl, FadeToSilenceMusicPacket
	jr .push_stop_packet
	
.stop_nofade
	ld hl, StopMusicPacket
	
.push_stop_packet
	jp _PushSGBPals

; see patches/msu1_init.asm
include "patches/msu1/_bootstrap.asm"	; generated by makefile

JumpToMSU1EntryPoint:: sgb_jump $1810, 0, 0, 0

MSU1SoundTemplate:: sgb_data_snd $1800, $0, 5
	;   R #l #h  V    M
	db  1, 0, 0, $FF, 0
	ds 6, 0
	
UpdateVolumePacket:: sgb_data_snd $1800, $0, 1
	db  %01000000
	ds 10, 0
	
StopMusicPacket:: sgb_data_snd $1800, $0, 1
	db  %00100000
	ds 10, 0
	
DuckMusicPacket:: sgb_data_snd $1807, $0, 1
	db  255/3
	ds 10, 0
	
UnduckMusicPacket:: sgb_data_snd $1807, $0, 1
	db  0
	ds 10, 0
	
FadeToSilenceMusicPacket:: sgb_data_snd $1800, $0, 1
	db  %00000010
	ds 10, 0

include "patches/msu1_looping_modes.asm"

ForceNewMSU1Tune: ; cringe
	ld a, 1
	ld hl, wMSU1PacketSend + 5
	ld [hli], a			; ask for a restart
					; wMSU1PacketSend + 6
	ld a, e
	ld [hli], a			; set new track ID
					; wMSU1PacketSend + 7
	inc hl				; wMSU1PacketSend + 8
	inc hl				; wMSU1PacketSend + 9
; determine looping mode
	push hl
	ld hl, MSU1_LoopingModes
	add hl, de
	ld a, [hl]
	pop hl
	ld [hl], a			; set looping mode
	jr ForceNewMSU1Tune_SendPacket

ForceNewMSU1Tune_ForceNoLoop: ; cringe x2
	ld a, 1
	ld hl, wMSU1PacketSend + 5
	ld [hli], a			; ask for a restart
					; wMSU1PacketSend + 6
	ld a, e
	ld [hli], a			; set new track ID
					; wMSU1PacketSend + 7
	inc hl				; wMSU1PacketSend + 8
	inc hl				; wMSU1PacketSend + 9
; determine looping mode
	ld a, 1
	ld [hl], a			; set looping mode

ForceNewMSU1Tune_SendPacket:
; send the built packet over
	ld hl, wMSU1PacketSend
	jp _PushSGBPals

_CheckSFXAndMusicOffRedirect::
; check SGB first
	ldh a, [hSGB]
	and a
	ret z

	push de
.check_ducked_sfx
; Use a LUT with hardcoded SFX
; PlaySFX @de
	ld hl, SFX_LUT

.loop
	ld a, [hl+]
	cp -1
	jr z, .done
	cp e
	jr z, .duck
	jr .loop

.duck
	ld hl, DuckMusicPacket
	call _PushSGBPals
	ld hl, UpdateVolumePacket
	call _PushSGBPals

.done
	pop de
	ret

_PlayCaughtMonFanfare::
	ld de, 93
	call ForceNewMSU1Tune_ForceNoLoop
	ld a, 1
	ld [wSFXNoRun], a
	ld c, MUL(3.5, 60) ; 3 and a half seconds
	call DelayFrames
	ret
	
_CallRestoreMusicMSU1:
	ld hl, UnduckMusicPacket
	call _PushSGBPals
	ld hl, UpdateVolumePacket
	jp _PushSGBPals

SFX_LUT:
	db 1	; sfx_item
	db 2	; caught mon
	db 10	; dex 80-109
	db 45	; unused fanfare 1
	db 146	; unused fanfare 2
	db 145	; key item
	db 147	; phone number
	db 149	; get egg 1
	db 150	; get egg 2
	db 151	; deleted
	db 148	; 3rd place
	db 152	; 2nd place
	db 153	; 1st place
	db 154	; choose card
	db 155	; tm
	db 156	; badge
	db 157	; slot quit
	db 159	; dex fanfare <20
	db 9	; dex fanfare 20-49
	db 0	; dex fanfare 50-79
	db 160	; dex fanfare 140-169
	db 161	; dex fanfare 170-199
	db 162	; dex fanfare 200-229
	db 163	; dex fanfare >229
; end ----------------------------
	db -1
