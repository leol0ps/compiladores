#!/bin/bash

YEAR=$(pwd | grep -o '20..-.')
DATA=/home/llpinto/compiladores/chapter_4/
IN=$DATA/in
OUT=$DATA/out02_c

EXE=./lab02

for infile in `ls $IN/*.ezl`; do
    base=$(basename $infile)
    outfile=$OUT/${base/.ezl/.out}
    echo $infile
    $EXE < $infile | diff -w $outfile -
done
