#!/usr/bin/python

import re
import math
import sys

# usage: find_offsets.py Gold English
version = sys.argv[1]
region = sys.argv[2]

# replace this with an absolute path
# this can also even be an existing rom hack
# assuming there's no change in any of the
# referenced functions (try prism 2010 beta?)
file_name = f'#roms/{version}_{region}.gb'

# stuff is just binary regexen

# home
RE_DelayFrame = re.compile(b'\\x3e\\x01\\xea..\\x76\\x00', re.DOTALL)
RE_GetScriptByte = re.compile(b'\\xe5\\xc5\\xf0\\x9f\\xf5\\xfa..\\xd7\\x21..\\x4e\\x23', re.DOTALL)
RE_PlayMusic = re.compile(b'\\xe5\\xd5\\xc5\\xf5\\xf0\\x9f\\xf5\\x3e\\x3a\\xe0\\x9f\\xea\\x00\\x20\\x7b\\xa7\\x28.\\xcd..\\x18.\\xcd..\\xf1', re.DOTALL)
RE_PlayMusic2 = re.compile(b'\\xe5\\xd5\\xc5\\xf5\\xf0\\x9f\\xf5\\x3e\\x3a\\xe0\\x9f\\xea\\x00\\x20\\xd5\\x11\\x00\\x00\\xcd..', re.DOTALL)
RE_FadeToMapMusic = re.compile(b'\\xe5\\xd5\\xc5\\xf5\\xcd..\\xfa..\\xbb\\x28.\\x3e\\x08\\xea..\\x7b\\xea..\\x7a\\xea..', re.DOTALL)
RE_MaxVolume = re.compile(b'\\x3e\\x77\\xea..\\xc9', re.DOTALL)

# bank 02
RE_MaskEnFreezePacket = re.compile(b'\\xb9\\x01\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00\\x00', re.DOTALL)
RE_DataSndPacket1     = re.compile(b'\\x79\\x5d\\x08\\x00\\x0b\\x8c\\xd0\\xf4\\x60\\x00\\x00\\x00\\x00\\x00\\x00', re.DOTALL)
RE__PushSGBPals       = re.compile(b'\\x7e\\xe6\\x07\\xc8\\x47\\xc5\\xaf\\xe0\\x00\\x3e\\x30\\xe0\\x00\\x06\\x10\\x1e\\x08', re.DOTALL)
RE__InitSGBBorderPals = re.compile(b'\\x21..\\x0e\\x09\\xc5\\x2a\\xe5\\x66\\x6f\\xcd..\\xe1\\x23\\xc1\\x0d\\x20.\\xc9', re.DOTALL)

# bank 25
RE_Script_playmusic   = re.compile(b'\\x11\\x00\\x00\\xcd..\\xaf\\xea..\\xcd..\\xcd..\\x5f\\xcd..\\x57\\xcd..\\xc9', re.DOTALL)

# bank 3a
RE__InitSound             = re.compile(b'\\xe5\\xd5\\xc5\\xf5\\xcd..\\x21..\\xaf\\x22\\x22\\x3e\\x80\\x22\\x21..\\x1e\\x04\\xaf\\x22\\x22\\x3e\\x08', re.DOTALL)
RE__PlayMusic             = re.compile(b'\\xcd..\\x21..\\x73\\x23\\x72\\x21..\\x19\\x19\\x19\\x2a\\xea..\\x5e\\x23', re.DOTALL)
RE_FadeMusic              = re.compile(b'\\xfa..\\xa7\\xc8\\xfa..\\xa7\\x28\\x05\\x3d\\xea..\\xc9\\xfa..\\x57\\xe6\\x3f\\xea..\\xfa..\\xe6\\x07', re.DOTALL)
RE_FadeMusic_LoadNewSong1 = re.compile(b'\\xfa..\\xa7\\x28\\x08\\x5f\\xfa..\\x57\\xcd..\\xc1\\xaf\\xea..\\xc9', re.DOTALL)
RE_FadeMusic_LoadNewSong2 = re.compile(b'\\xfa..\\x5f\\xfa..\\x57\\xcd..\\xc1\\x21..\\xcb\\xfe\\xc9', re.DOTALL)

RE_FreeSpace = re.compile(b'\\x00{64,}')

RE_WaitSFX = re.compile(b'\\xe5\\x21..\\xcb\\x46\\x20.\\x21..\\xcb\\x46\\x20.\\x21..\\xcb\\x46\\x20.\\x21..\\xcb\\x46\\x20.\\xe1\\xc9')

RE_Music_ToggleSFX = re.compile(b'\\x21\\x03\\x00\\x09\\xcb\\x5e\\x28.\\xcb\\x9e\\xc9')

RE_Home_PlaySFX = re.compile(b'\\xe5\\xd5\\xc5\\xf5\\xcd..\\x30.\\xfa..\\xbb\\x38.\\xf0.\\xf5\\x3e.\\xe0.\\xea\\x00\\x20\\x7b\\xea..\\xcd..\\xf1\\xe0.\\xea\\x00\\x20\\xf1\\xc1\\xd1\\xe1\\xc9')

RE_Home_CheckSFX = re.compile(b'\\xfa..\\xcb\\x47\\x20.\\xfa..\\xcb\\x47\\x20.\\xfa..\\xcb\\x47\\x20.\\xfa..\\xcb\\x47\\x20.\\xa7\\xc9')

RE_Home__PlaySFX = re.compile(b'\\xcd..\\x21..\\xcb\\x46\\x28.\\xcb\\x86\\xaf\\xe0\\x11\\x3e.\\xe0\\x12\\xaf\\xe0\\x13\\x3e.\\xe0\\x14\\xaf\\xea..\\xe0\\x10')

RE_Home_MusicOff = re.compile(b'\\xaf\\xea..\\xc9\\xfa..\\xa7\\xc8\\xaf\\xea..\\xea..')

RE_Script_FindItemInBall = re.compile(b'\\x0e...\\x08..\\x6d\\xfe\\x47')

RE_Home_TextCommand_SOUND = re.compile(b'\\xc5\\x2b\\x2a\\x47\\xe5\\x21..\\x2a\\xfe\\xff')

RE_EvolveAfterBattle_PlayCaughtSFX = re.compile(b'\\xd5\\x11\\x00\\x00\\xcd..\\x11\\x02\\x00\\xcd..\\xcd..\\xd1\\x0e\\x28\\xcd..')

iters_list = {
	"DelayFrame": RE_DelayFrame,
	"GetScriptByte": RE_GetScriptByte,
	"PlayMusic": RE_PlayMusic,
	"PlayMusic2": RE_PlayMusic2,
	"FadeToMapMusic": RE_FadeToMapMusic,
	"MaxVolume": RE_MaxVolume,
	
	"MaskEnFreezePacket": RE_MaskEnFreezePacket,
	"DataSndPacket1": RE_DataSndPacket1,
	"_PushSGBPals": RE__PushSGBPals,
	"_InitSGBBorderPals": RE__InitSGBBorderPals,
	
	"Script_playmusic": RE_Script_playmusic,
	
	"_InitSound": RE__InitSound,
	"_PlayMusic": RE__PlayMusic,
	"FadeMusic": RE_FadeMusic,
	"FadeMusic_LoadNewSong1": RE_FadeMusic_LoadNewSong1,
	"FadeMusic_LoadNewSong2": RE_FadeMusic_LoadNewSong2,
	"WaitSFX": RE_WaitSFX,
	"Music_ToggleSFX": RE_Music_ToggleSFX,
	
	"PlaySFX": RE_Home_PlaySFX,
	"CheckSFX": RE_Home_CheckSFX,
	"_PlaySFX": RE_Home__PlaySFX,
	"MusicOff": RE_Home_MusicOff,
	"FindItemInBallScript": RE_Script_FindItemInBall,
	"TextCommand_SOUND": RE_Home_TextCommand_SOUND,
        "EvolveAfterBattle_PlayCaughtSFX": RE_EvolveAfterBattle_PlayCaughtSFX
	#"Free space": RE_FreeSpace
}

def gb2gb(p):
	offs = int(p, 16)
	bank = math.floor(offs / 0x4000)
	if bank != 0:
		addr = (offs - (bank * 0x4000)) + 0x4000
	else:
		addr = (offs - (bank * 0x4000))
	return f'{hex(bank)[2:].zfill(2)}:{hex(addr)[2:].zfill(4)}'
	
with open(file_name, 'rb') as rom:
	x = rom.read()
	print(f"; Offsets for {file_name}")
	for key, value in iters_list.items():
		print ("; ",end="")
		print (key.ljust(32),end="")
		ctr = 0
		for i in value.finditer(x):
			print('; ', end="")
			if ctr > 0:
				print(' '*34, end="")
			print(f'Possible match: {gb2gb( hex(i.start())[2:] )}')
			ctr += 1
