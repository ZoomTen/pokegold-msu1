; free space
IF DEF(_GOLD)
	define_location 00_FreeSpace,  $3f0f
ELIF DEF(_SILVER)
	define_location 00_FreeSpace,  $3fc0
ENDC
IF DEF(_GOLD)
	define_location 01_FreeSpace,  $7f9f
ELIF DEF(_SILVER)
	define_location 01_FreeSpace,  $7fce
ENDC
	define_location 02_FreeSpace,  $bbc4
	define_location 3a_FreeSpace, $ebfb7
