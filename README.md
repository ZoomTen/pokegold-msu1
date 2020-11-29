# Pokémon Gold and Silver MSU1

Set of patches to add MSU1 (Super Game Boy) support to Pokémon Gold and Silver, aiming to do that while letting the music play normally on GB and GBC, as well as keeping compatibility with existing save files.

Although the `pokegold` disassembly has been referenced heavily, it won't make use of it in order to ease porting the patch to many versions of the game - maybe even ROM hacks!

Of course, the music will not play on an SGB without MSU1 support, such as a regular Super Game Boy cartridge or GB emulators (BGB, SameBoy, ...)

## Dependencies
- RGBDS
- Asar (included as a submodule, compile manually)
- Flips (included as a submodule, compile manually)

## Building
- Binary management
  - Ensure the `FLIPS` and `RGBDS` variables in the `Makefile` point to the Flips binary and RGBDS directory (respectively).
  - Ensure the `ASSEMBLER` variable in `patches/msu1/Makefile` points to the Asar standalone binary.
- Localization
  - In `patches.asm` change `include "offsets/english.asm"` to include the available languages in `offsets` (only English is supported for now)
  - Change `pokegold_msu1-baserom` and `pokesilver_msu1-baserom` so that it points to the appropriate ROM (hashes listed below)
- Run `make`

## ROM Hashes
## Gold
* English: `a6924ce1f9ad2228e1c6580779b23878`
* French: `9af19423c5fa3dbe4fdcc78d2bc7d1c0`
* German: `7542ec9b695d4fe38adfdaaa57364d83`
* Italian: `89bb59dc49b59b0cd30b7384d9860bb8`
* Japanese (v1.0): `85be569fe89f58c40f60480313314c67`
* Japanese (v1.1): `79aece8a042e4fa57aba9455c4d21a97`
* Spanish: `9462bc81907e38c59acccd739690e6f9`
## Silver
* English: `2ac166169354e84d0e2d7cf4cb40b312`
* French: `72448fe75f534f70cd90469da95ef76f`
* German: `f1f013cd591bc4ea77305bbc9f8cbb3c`
* Italian: `9357c3dab850692ac8184ccf655d4efd`
* Japanese (v1.0): `9357c3dab850692ac8184ccf655d4efd`
* Japanese (v1.1): `75519c8b57cea3ac91133b3dec7658de`
* Spanish: `2d83fb454dd5687a802425c501854dc2`
