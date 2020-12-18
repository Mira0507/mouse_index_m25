
#!/bin/bash

# Define directory path or file 
genome=*genome.fa           # reference genome
outdir=hisat2_index         # ouput directory storing index files

mkdir $outdir

hisat2-build -f -o 4 -p 16 --seed 67 $genome $outdir/index 


# Basic command line: hisat2-build [options] <reference_in> <ht2_base>
# -f ~ --seed: options
# "reference_GENCODE/*genome.fa": <reference_in> 
# "index": <ht2_base> 
