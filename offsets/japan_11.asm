; free space
	define_home Bank00_FreeSpace,  $3f0f
IF DEF(_GOLD)
	define_location Bank01_FreeSpace,  $7f9f
ELIF DEF(_SILVER)
	define_location Bank01_FreeSpace,  $7f64
ENDC
	define_location Bank02_FreeSpace,  $bbc0
	define_location Bank3a_FreeSpace, $ebfb7

; constants
; ram locations
	define_location wMusicFade,    0, $c1a7
	define_location wMusicFadeID,  0, $c1a9
	define_location wChannel5Flags1,  0, $c0cc
	define_location wChannel6Flags1,  0, $c0fe
	define_location wChannel7Flags1,  0, $c130
	define_location wChannel8Flags1,  0, $c162
	
; stuff to patch
; home bank
	define_home DelayFrame,       $32e
	define_home GetScriptByte,   $27a4
	define_home PlayMusic,       $3cb9
	define_home PlayMusic2,      $3cde
	define_home FadeToMapMusic,  $3dbb
	define_home MaxVolume,       $3d96
	
; bank 02
	define_location MaskEnFreezePacket, $02, $614b
; $10 bytes each
	define_location DataSndPacket1, $02, $616b
	define_location DataSndPacket2, $02, $617b
	define_location DataSndPacket3, $02, $618b
	define_location DataSndPacket4, $02, $619b
	define_location DataSndPacket5, $02, $61ab
	define_location DataSndPacket6, $02, $61bb
	define_location DataSndPacket7, $02, $61cb
	define_location DataSndPacket8, $02, $61db
	define_location _PushSGBPals,           $02, $5c1d
	define_location _InitSGBBorderPals,     $02, $5ce0

; bank 25
	define_location Script_playmusic,       $25, $706c

; bank 3a
	define_location _InitSound,             $3a, $4000
	define_location _PlayMusic,             $3a, $4b30
	define_location FadeMusic,              $3a, $4358
	define_location FadeMusic_LoadNewSong1, $3a, $438f
	define_location FadeMusic_LoadNewSong2, $3a, $43ab

	define_home     WaitSFX,              $3d77
	define_location Music_PlaySFX,        $3a, $4c04
	define_location Music_MusicOff,       $3a, $4057
