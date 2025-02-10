#!/bin/bash

clear


rgbasm  -o target/harvestmoon_gb.o   src/entry.asm
rgblink -o target/harvestmoon_gb.gb target/harvestmoon_gb.o
rgbfix     target/harvestmoon_gb.gb -j -k E9 -l 0x33 -m 0x03 -r 0x02 -s -t "HARVEST-MOON GB" -v -p 0xFF

filesize=$(cat rom/HarvestMoonGB.gb | wc -c)
diffs=$(radiff2 -c rom/HarvestMoonGB.gb target/harvestmoon_gb.gb)
echo $diffs / $filesize
perc=$(bc <<< "scale = 10; ($diffs / $filesize) * 100")
echo Similarity: $perc%

#sha256sum rom/HarvestMoonGB.gb
#sha256sum target/harvestmoon_gb.gb


rm compared.txt
cmp -l rom/HarvestMoonGB.gb target/harvestmoon_gb.gb | gawk '{printf "%08X %02X %02X\n", $1-1, strtonum(0$2), strtonum(0$3)}' > compared.txt
