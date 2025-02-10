
# Harvest Moon GB

A disassembly of Harvest Moon GB. I do have plans to also decompile and examine Harvest Moon GBC, but we'll see if they actually share enough code base to be included here.

Macros are only being used when a peice of code is repeated *SO* much that is makes it easier to read.

## Progress
NOTE: Numbers are based on a direct comparison between the outputted file and the original. Actual code and documentation is a different story.

[75,529 / 524,288] | ~[0.144%] Similarity as of 2022/10/18.

## Building
NOTE: A step in the build script is comparing the output ROM to a backup copy of the released game, and that file is not included for obvious reasons. While I *currently* have no plans to switch over to a special build system, I will be working on improving this as I go forward.

### Building on Windows
Using a cli in the main folder type in the command:

`.\build.bat`

No fancy build system, It just simply creates a directory named /target/debug/%CurrentDate%, copies the src files into it.

It then runs, in this order:
- rgbasm
- rgblink
- rgbfix

Finally it compares the output ROM with an original *backup* located at \ROM\HarvestMoonGB.gb and outputs the result into compared.txt.

### Building on Linux
TODO:

### Building on Mac
I'm going to need someone else for this. I don't have any apple products to test on and I don't plan on getting any.