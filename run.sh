#!/bin/bash
IMG='guara-os.img'

[[ -f dist/$IMG ]] || { echo "Imagem $IMG não encontrada!"; exit 1; }

qemu-system-i386 -drive file=dist/$IMG,format=raw,index=0,if=floppy -boot order=a