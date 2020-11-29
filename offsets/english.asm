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

; stuff to patch
; home bank
	; E5 D5 C5 F5 F0 9F F5 3E 3A E0 9F EA 00 20 7B A7 28 05 CD ?? ?? 18 03 CD 00 40 F1 E0 9F EA 00 20 F1 C1 D1 E1 C9
	define_home PlayMusic,       $3d98
	; E5 D5 C5 F5 F0 9F F5 3E 3A E0 9F EA 00 20 D5 11 00 00 CD ?? ?? CD ?? ?? D1 CD ?? ?? F1 E0 9F EA 00 20 F1 C1 D1 E1 C9
	define_home PlayMusic2,      $3dbd
	; E5 D5 C5 F5 CD ?? ?? FA ?? ?? BB 28 11 3E 08 EA ?? ?? 7B EA ?? ?? 7A EA ?? ?? 7B EA ?? ?? F1 C1 D1 E1 C9
	define_home FadeToMapMusic,  $3e9a

; bank 02
	; EA EA EA EA EA 60 EA EA FF 7F 36 4F B0 7A 00 00
	define_location	DataSndPacket1,  $a1e5

; bank 3a
	define_location _InitSound,      $e8000
	; CD ?? ?? 21 ?? ?? 73 23 72 21 ?? ?? 19 19 19 2A ...
	define_location _PlayMusic,      $e8b30
