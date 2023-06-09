#!/bin/bash

YEAR=$(pwd | grep -o '20..-.')
DATA=/home/llpinto/Downloads/CC_Lab03_src_c
IN=$DATA/in
OUT=$DATA/out02_c

EXE=./lab02

for infile in `ls $IN/*.ezl`; do
    base=$(basename $infile)
    outfile=$OUT/${base/.ezl/.out}
    $EXE < $infile > $outfile
done
