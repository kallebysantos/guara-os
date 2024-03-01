#!/bin/bash

mkdir -p dist

IMG='guara-os.img'

# Bootloader
nasm src/boot/loader.asm -f bin -o dist/loader.bin || exit
cp dist/loader.bin dist/$IMG
truncate -s 1440k dist/$IMG

# Inspect
xxd dist/loader.bin