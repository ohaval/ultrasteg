#! /bin/bash
if [ $# -eq 0 ]; then
	echo "usage: ultrasteg.sh <file>"
	exit
fi
filename=$(basename -- "$1")
extension=$(echo $filename | cut -d "." -f2)
filename="${filename%.*}"
zsteg -a $1
exiftool $1
foremost $1 -o foremost
binwalk --extract $1 --directory binwalk
pngcheck $1
stegsnow $1
steghide extract -p $filename -sf $1 -xf steghide_output 2>/dev/null
cat steghide_output 2> /dev/null
if [ $extension == "wav" ]; then
	stegolsb wavsteg -i $1 -r -o stegolsbwav -b 1000 2>/dev/null
fi
echo "{maybe you should try these tools: strings, stegsolve, steghide, stego-lsb-set}"