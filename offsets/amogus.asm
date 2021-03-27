; proof of concept: MSU-1 pokegold rom hacks
; Amogus: Sus Version

; free space
	define_home Bank00_FreeSpace,  $3fec
	define_location Bank01_FreeSpace,  $7546
	define_location Bank02_FreeSpace,  $bc60
	define_location Bank3a_FreeSpace, $eb310

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
	define_home GetScriptByte,   $27f5
	define_home PlayMusic,       $3d96
	define_home PlayMusic2,      $3dbb
	define_home FadeToMapMusic,  $3e98
	define_home MaxVolume,       $3e73
	
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
	define_location Script_playmusic,       $25, $7048

; bank 3a
	define_location _InitSound,             $3a, $4000
	define_location _PlayMusic,             $3a, $4b30
	define_location FadeMusic,              $3a, $4358
	define_location FadeMusic_LoadNewSong1, $3a, $438f
	define_location FadeMusic_LoadNewSong2, $3a, $43ab

	define_home     WaitSFX,              $3e54
	define_location Music_PlaySFX,        $3a, $4c04
	define_location Music_MusicOff,       $3a, $4057
