
# Harvest Moon GB

A disassembly of Harvest Moon GB. I do have plans to also decompile and examine Harvest Moon GBC, but we'll see if they actually share enough code base to be included here.

Macros are only being used when a piece of code is repeated *SO* much that is makes it easier to read.

## Progress
NOTE: Numbers are based on a direct comparison between the outputted file and the original. Actual code and documentation is a different story.

[1602 / 450231] | ~[.3558173400%] Similarity as of 2025/2/15.

## Building
NOTE: A step in the build script is comparing the output ROM to a backup copy of the released game, and that file is not included for obvious reasons. While I *currently* have no plans to switch over to a special build system, I will be working on improving this as I go forward.

Just run:

``` bash
.\build.sh
```

No fancy build system, just compiles into target/ using, in order:

- rgbasm
- rgblink
- rgbfix

Finally it compares the output ROM with an original *backup* located at \ROM\HarvestMoonGB.gb and outputs the result into compared.txt.

