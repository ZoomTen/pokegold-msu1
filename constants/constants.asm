; HRAM
hROMBank	equ	$ff9f
hSGB		equ	$ffe9

; rst vectors
rst_Bankswitch	equ	$10
rst_FarCall	equ	$08

; hardcoded WRAM locations
wIsInFade		equ $df1e
wCheckAndFadeMusicID	equ $df1f
wMSU1PacketSend		equ $df20

; MSU1 playing modes
MSU1_PLAY	equ 1
MSU1_LOOP	equ 3
