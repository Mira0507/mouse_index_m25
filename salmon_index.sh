#!/bin/bash

indir=salmon_index

cd $indir

salmon index -t gentrome.fa -d decoys.txt -p 16 -i gencode_index --gencode

cd ..
