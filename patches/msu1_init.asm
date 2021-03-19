SECTION "SGB and MSU1 Bootstrap", ROMX[_InitSGBBorderPals], BANK[BANK__InitSGBBorderPals]	; replace engine/gfx/color/_InitSGBBorderPals

; Initialize MSU-1 interrupts from here

PATCH_InitSGBBorderPals:
	ld hl, .pointers
	ld c, 9		; original data snd stuff
.loop
	push bc
	ld a, [hli]
	push hl
	ld h, [hl]
	ld l, a
	call _PushSGBPals
	pop hl
	inc hl
	pop bc
	dec c
	jr nz, .loop
; UpdateSGBBorder, the function after this, is unreferenced. Clobber over it.
.bootstrap_msu1
	ld hl, Packets_bootstrap	; see patches/bank_02.asm
	ld c, [hl]	; amount of packets to send
	inc hl
.push_bootstrap
	call _PushSGBPals
	dec c
	jr nz, .push_bootstrap
	ld hl, JumpToMSU1EntryPoint	; execute MSU1 init
	call _PushSGBPals
	ret
.pointers
	dw MaskEnFreezePacket
	dw DataSndPacket1
	dw DataSndPacket2
	dw DataSndPacket3
	dw DataSndPacket4
	dw DataSndPacket5
	dw DataSndPacket6
	dw DataSndPacket7
	dw DataSndPacket8
