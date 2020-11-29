.SUFFIXES:
.SECONDEXPANSION:
.PRECIOUS: %.gbc
.SECONDARY:
.PHONY: all clean


# tools
FLIPS ?= tools/flips/flips

RGBDS ?= /usr/bin
ASM   ?= $(RGBDS)/rgbasm
LINK  ?= $(RGBDS)/rgblink
FIX   ?= $(RGBDS)/rgbfix

ASM_FLAGS := -h -L -Weverything


# object files
pokegold_msu1-obj   := gold_patch.o
pokesilver_msu1-obj := silver_patch.o


# base ROMs
pokegold_msu1-baserom   ?= \#roms/Gold_English.gb
pokesilver_msu1-baserom ?= \#roms/Silver_English.gb


# pseudo targets
patches := pokegold_msu1.bps pokesilver_msu1.bps
all: $(patches)
gold: pokegold_msu1.bps
silver: pokesilver_msu1.bps
clean:
	rm -f $(patches) $(patches:.bps=.gbc) $(patches:.bps=.map) $(patches:.bps=.sym) $(pokegold_msu1-obj) $(pokesilver_msu1-obj)
	$(MAKE) clean -C patches/msu1/


# individual rules
$(pokegold_msu1-obj):	ASM_FLAGS += -D _GOLD
$(pokesilver_msu1-obj):	ASM_FLAGS += -D _SILVER


# general rules
%.o: patches/msu1/_bootstrap.asm patches.asm patches/* offsets/*
	$(ASM) $(ASM_FLAGS) -o $@ patches.asm

%.gbc: $$(%-obj)
	$(LINK) -m $*.map -n $*.sym -O "$($*-baserom)" -o $@ $^
	$(FIX) -v $@

%.bps: %.gbc
	$(FLIPS) --create --bps-delta "$($*-baserom)" $^ $@

patches/msu1/_bootstrap.asm:
	$(MAKE) -C patches/msu1/
