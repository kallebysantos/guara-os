#!/bin/bash

mkdir -p dist

# FILE='src/boot/loader.asm '
FILE='tmp/guessing_game.asm '
IMG='guara-os.img'

# Bootloader
nasm $FILE -f bin -o dist/loader.bin || exit
cp dist/loader.bin dist/$IMG
truncate -s 1440k dist/$IMG

# Inspect
xxd dist/loader.bin
