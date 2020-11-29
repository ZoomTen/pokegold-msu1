; free space
	define_home Bank00_FreeSpace,  $3fee
IF DEF(_GOLD)
	define_location Bank01_FreeSpace,  $754e
ELIF DEF(_SILVER)
	define_location Bank01_FreeSpace,  $7514
ENDC
	define_location Bank02_FreeSpace,  $bc3e
	define_location Bank3a_FreeSpace, $ebfb7

; constants
; ram locations
	define_location wMusicFade,    0, $c1a7
	define_location wMusicFadeID,  0, $c1a9

; stuff to patch
; home bank
	define_home DelayFrame,       $32e
	; E5 D5 C5 F5 F0 9F F5 3E 3A E0 9F EA 00 20 7B A7 28 05 CD ?? ?? 18 03 CD 00 40 F1 E0 9F EA 00 20 F1 C1 D1 E1 C9
	define_home PlayMusic,       $3d98
	; E5 D5 C5 F5 F0 9F F5 3E 3A E0 9F EA 00 20 D5 11 00 00 CD ?? ?? CD ?? ?? D1 CD ?? ?? F1 E0 9F EA 00 20 F1 C1 D1 E1 C9
	define_home PlayMusic2,      $3dbd
	; E5 D5 C5 F5 CD ?? ?? FA ?? ?? BB 28 11 3E 08 EA ?? ?? 7B EA ?? ?? 7A EA ?? ?? 7B EA ?? ?? F1 C1 D1 E1 C9
	define_home FadeToMapMusic,  $3e9a

; bank 02
	define_location MaskEnFreezePacket, $02, $61c5
; these "default data" should be $10 bytes each :)
	define_location DataSndPacket1, $02, $61e5
	define_location DataSndPacket2, $02, $61f5
	define_location DataSndPacket3, $02, $6205
	define_location DataSndPacket4, $02, $6215
	define_location DataSndPacket5, $02, $6225
	define_location DataSndPacket6, $02, $6235
	define_location DataSndPacket7, $02, $6245
	define_location DataSndPacket8, $02, $6255

	define_location _PushSGBPals, $9c87
	define_location _InitSGBBorderPals, $9d4a

; bank 3a
	define_location _InitSound,      $e8000
	; CD ?? ?? 21 ?? ?? 73 23 72 21 ?? ?? 19 19 19 2A ...
	define_location _PlayMusic,      $e8b30
	define_location FadeMusic,  $3a, $4358
