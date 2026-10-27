![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04-E95420?logo=ubuntu&logoColor=white) ![Ubuntu Build](https://github.com/djipi/LZSS/actions/workflows/LZSS.build.yml/badge.svg?label=Ubuntu)

# LZSS
LZSS compression tool and library.

## Tool
Compress and decompress a file.

### Docker
Build the image from the repository root:

```sh
docker build -t lzss .
```

Mount the directory containing your files and pass the usual LZSS arguments:

```sh
docker run --rm -v "$PWD:/data" lzss e input.bin compressed.lzss
docker run --rm -v "$PWD:/data" lzss d compressed.lzss output.bin
```

## Library
Compress only functions.

## Platforms
Windows 10.<br>
MSYS2/MinGW 32 & 64 bits.<br>
MinGW32.<br>
Cygwin64.<br>
Linux.

## Projects
Makefile<br>
Visual Studio 2022
