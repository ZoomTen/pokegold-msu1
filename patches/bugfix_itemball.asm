SECTION "Find Item in Ball", ROMX[FindItemInBallScript+$10], BANK[BANK_FindItemInBallScript]
PATCH_FindItemInBallScript::
	db $03	; script jumpto
	dw PATCH_REDIRECT_FindItemInBallScript

SECTION "Find Item in Ball 2", ROMX[Bank04_FreeSpace], BANK[$4]
PATCH_REDIRECT_FindItemInBallScript::
	db $0f, $3a, $00 ; special WaitSFX
	db $45 ; itemnotify
	db $49 ; closetext
	db $90 ; end
