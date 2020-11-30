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
;	define_location wMapMusic,     0, $c1c0

; stuff to patch
; home bank
	define_home DelayFrame,       $32e
	define_home PlayMusic,       $3d98
	define_home PlayMusic2,      $3dbd
	define_home FadeToMapMusic,  $3e9a
;	define_home RestartMapMusic, $3f25

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

; bank 25
	define_location Script_playmusic, $25, $7048
; bank 3a
	define_location _InitSound,      $e8000
	define_location _PlayMusic,      $e8b30
	define_location FadeMusic,  $3a, $4358
; under FadeMusic.novolume
	define_location FadeMusic_LoadNewSong1, $3a, $438f
; under FadeMusic.bicycle
	define_location FadeMusic_LoadNewSong2, $3a, $43ab
