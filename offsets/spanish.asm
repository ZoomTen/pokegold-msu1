; free space
	define_home Bank00_FreeSpace,  $3f8f
IF DEF(_GOLD)
	define_location Bank01_FreeSpace,  $7595
ELIF DEF(_SILVER)
	define_location Bank01_FreeSpace,  $755d
ENDC
	define_location Bank02_FreeSpace,  $bc40
	define_location Bank3a_FreeSpace, $ebfb7

; constants
; ram locations
	define_location wMusicFade,    0, $c1a7 ; same
	define_location wMusicFadeID,  0, $c1a9 ; same
	define_location wChannel5Flags1,  0, $c0cc
	define_location wChannel6Flags1,  0, $c0fe
	define_location wChannel7Flags1,  0, $c130
	define_location wChannel8Flags1,  0, $c162
	
; stuff to patch
; home bank
	define_home DelayFrame,      $32e
	define_home GetScriptByte,   $281b
	define_home PlayMusic,       $3d39
	define_home PlayMusic2,      $3d5e
	define_home FadeToMapMusic,  $3e3b
	define_home MaxVolume,       $3e16
	
; bank 02
	define_location MaskEnFreezePacket, 2, $61c5
; $10 bytes each
	define_location DataSndPacket1, 2, $61e5
	define_location DataSndPacket2, 2, $61f5
	define_location DataSndPacket3, 2, $6205
	define_location DataSndPacket4, 2, $6215
	define_location DataSndPacket5, 2, $6225
	define_location DataSndPacket6, 2, $6235
	define_location DataSndPacket7, 2, $6245
	define_location DataSndPacket8, 2, $6255
	define_location _PushSGBPals,           2, $5c87
	define_location _InitSGBBorderPals,     2, $5d4a

; bank 25
	define_location Script_playmusic,       $25, $704d

; bank 3a
	define_location _InitSound,             $3a, $4000
	define_location _PlayMusic,             $3a, $4b30
	define_location FadeMusic,              $3a, $4358
	define_location FadeMusic_LoadNewSong1, $3a, $438f
	define_location FadeMusic_LoadNewSong2, $3a, $43ab

	define_home     WaitSFX,              $3df7
	define_location Music_ToggleSFX, $3a, $492d
