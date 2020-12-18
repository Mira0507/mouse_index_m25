#!/bin/bash 




# Define output directory
index=star_index


# Define reference file names
genome=*genome.fa
gtf=*.gtf

mkdir $index  

STAR --runThreadN 16 --runMode genomeGenerate --genomeDir $index --genomeFastaFiles $genome --sjdbGTFfile $gtf 
