; Redirect WaitSFX

SECTION "WaitSFX", ROM0[WaitSFX]
PATCH_WaitSFX::
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
	jp Home_WaitSFX_Cont
