; macros taken from pokered's data/sgb_packets.asm
; names taken from pandocs
; http://gbdev.gg8.se/wiki/articles/SGB_Functions#SGB_Palette_Commands
	const_def
	const SGB_PAL01
	const SGB_PAL23
	const SGB_PAL03
	const SGB_PAL12
	const SGB_ATTR_BLK
	const SGB_ATTR_LIN
	const SGB_ATTR_DIV
	const SGB_ATTR_CHR
	const SGB_SOUND
	const SGB_SOU_TRN
	const SGB_PAL_SET
	const SGB_PAL_TRN
	const SGB_ATRC_EN
	const SGB_TEST_EN
	const SGB_ICON_EN
	const SGB_DATA_SND
	const SGB_DATA_TRN
	const SGB_MLT_REG
	const SGB_JUMP
	const SGB_CHR_TRN
	const SGB_PCT_TRN
	const SGB_ATTR_TRN
	const SGB_ATTR_SET
	const SGB_MASK_EN
	const SGB_OBJ_TRN

sgb_pal_trn: MACRO
	db (SGB_PAL_TRN << 3) + 1
	ds 15
ENDM

sgb_mlt_req: MACRO
	db (SGB_MLT_REG << 3) + 1
	db \1 - 1
	ds 14
ENDM

sgb_chr_trn: MACRO
	db (SGB_CHR_TRN << 3) + 1
	db \1 + (\2 << 1)
	ds 14
ENDM

sgb_pct_trn: MACRO
	db (SGB_PCT_TRN << 3) + 1
	ds 15
ENDM

sgb_mask_en: MACRO
	db (SGB_MASK_EN << 3) + 1
	db \1
	ds 14
ENDM

sgb_data_snd: MACRO
	db (SGB_DATA_SND << 3) + 1
	dw \1 ; address
	db \2 ; bank
	db \3 ; length (1-11)
ENDM

sgb_sound: MACRO
	db (SGB_SOUND << 3) + 1
	db \1 ; Sound Effect A (Port 1) Decrescendo 8bit Sound Code
	db \2 ; Sound Effect B (Port 2) Sustain     8bit Sound Code
	db \3 ; Sound Effect Attributes
	db \4 ; Music Score Code
	ds 11, 0
ENDM

sgb_jump: MACRO
	db (SGB_JUMP << 3) + 1
	dw \1 ; set program counter
	db \2 ; bank
	dw \3 ; set interrupt handler
	db \4 ; bank
	ds 9, 0
ENDM
