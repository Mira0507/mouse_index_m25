#!/bin/bash

# Version: GENCODE GRCm38 version M25
# Genome: Genome sequence, primary assembly (GRCm38)
# Transcriptome: Transcript sequences
# GTF: Transcript sequences (PRI)
#
#
# Assign location of transcriptome file
transcriptome=ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M25/gencode.vM25.transcripts.fa.gz
genome=ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M25/GRCm38.primary_assembly.genome.fa.gz
gtf=ftp://ftp.ebi.ac.uk/pub/databases/gencode/Gencode_mouse/release_M25/gencode.vM25.primary_assembly.annotation.gtf.gz


# Download human transcriptome and genome files 
wget -c $transcriptome -O gencode.m25.transcripts.fa.gz
wget -c $genome -O GRCm38.m25.genome.fa.gz
wget -c $gtf -O gencode.m25.primary_assembly.annotation.gtf.gz

# Unzip the reference files manually!!!
