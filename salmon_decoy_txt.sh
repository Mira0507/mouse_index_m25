#!/bin/bash

indir=salmon_index

mkdir $indir


# Save reference names into decoys.txt
grep "^>" < *.genome.fa | cut -d " " -f 1 > $indir/decoys.txt

# Replace ">" to "" in the decoys.txt file
sed -i.bak -e 's/>//g' $indir/decoys.txt

cd .. 
