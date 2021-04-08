SECTION "Play After-Evolve Fanfare", ROMX[EvolveAfterBattle_PlayCaughtSFX], BANK[BANK_EvolveAfterBattle_PlayCaughtSFX]
PATCH_EvolveAfterBattle_PlayCaughtSFX::
	push de
	ld de, 0
	call PlayMusic
	push hl
	call PlayCaughtMonFanfare
	pop hl
	nop
	nop
	nop
	nop
