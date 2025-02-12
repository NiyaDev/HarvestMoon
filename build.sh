#!/bin/bash

clear

version=$1
asmflags="-o "
if [ "$version" == "GB" ] || [ "$version" == "" ]; then
	asmflags=$asmflags"-D _GB"
fi
if [ "$version" == "GBC" ]; then
	asmflags=$asmflags"-D _GBC"
fi

rgbasm  -o target/harvestmoon_gb.o   src/entry.asm
rgblink -o target/harvestmoon_gb.gb target/harvestmoon_gb.o
rgbfix     target/harvestmoon_gb.gb -j -k E9 -l 0x33 -m 0x03 -r 0x02 -s -t "HARVEST-MOON GB" -v -p 0xFF

rm compared.txt
cmp -l rom/HarvestMoonGB.gb target/harvestmoon_gb.gb | gawk '{printf "%08X %02X %02X\n", $1-1, strtonum(0$2), strtonum(0$3)}' > compared.txt

# Whitespace
whitespace=74057

# Grab filesize and count how many differences
filesize=$(wc -c <"rom/HarvestMoonGB.gb")
diffcount=$(wc -l < compared.txt)

# Account for whitespace
sim=$(bc <<< "scale = 10; ($filesize - $diffcount - $whitespace)")
filesizewhite=$(bc <<< "scale = 10; ($filesize - $whitespace)")

# Echo Fraction and Percentage
echo $sim / $filesizewhite
percentage=$(bc <<< "scale = 10; ($sim / $filesizewhite) * 100")
echo Similarity: $percentage%

#sha256sum rom/HarvestMoonGB.gb
#sha256sum target/harvestmoon_gb.gb



