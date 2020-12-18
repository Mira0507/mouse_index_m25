## Generation of mouse indexing files for Salmon, STAR, and HISAT2 

### 1. Reference files from [GENCODE](https://www.gencodegenes.org/mouse)

#### 1-2. Version of files 

- Version: GENCODE GRCm38 version M25
- Genome: Genome sequence, primary assembly (GRCm38)
- Transcriptome: Transcript sequences
- GTF: Transcript sequences (PRI)

#### 1-1. Downloading reference files 

- reference_download.sh


```bash
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
```

### 2. Conda environment 

- Same as [this project](https://github.com/Mira0507/seqc_comparison/blob/cda16e3e2684c921dc571f658b0ff5972a73ba8b/README.md)

```yml
name: mapping 
channels:
  - conda-forge
  - bioconda 
  - defaults 
dependencies:
  - hisat2=2.2.1
  - samtools=1.11
  - salmon=1.4.0
  - bedtools=2.29.2 
  - gawk=5.1.0 
  - star=2.7.6a
```


### 3. Salmon indexing 

- Salmon doc: https://salmon.readthedocs.io/en/latest
- Reference: https://combine-lab.github.io/alevin-tutorial/2019/selective-alignment


#### 3-1. Generating Decoys 

- salmon_decoy_txt.sh

```bash
#!/bin/bash

indir=salmon_index

mkdir $indir


# Save reference names into decoys.txt
grep "^>" < *.genome.fa | cut -d " " -f 1 > $indir/decoys.txt

# Replace ">" to "" in the decoys.txt file
sed -i.bak -e 's/>//g' $indir/decoys.txt

cd .. 
```

#### 3-2. Generating Gentrome 

- salmon_decoy_gentrome.sh

```bash
#!/bin/bash


indir=salmon_index

# Assign location of transcripts and genome reference files 
transcripts=*transcripts.fa 
genome=*genome.fa

# Concatenate them and save as.gentrome.fa
cat $transcripts $genome > $indir/gentrome.fa
```

#### 3-3. Indexing

- salmon_index.sh

```bash
#!/bin/bash

indir=salmon_index

cd $indir

salmon index -t gentrome.fa -d decoys.txt -p 16 -i gencode_index --gencode

cd ..
```

### 4. STAR indexing 

- STAR doc: https://github.com/alexdobin/STAR
- star_index.sh

```bash
#!/bin/bash 


# Define output directory
index=star_index


# Define reference file names
genome=*genome.fa
gtf=*.gtf

mkdir $index  

STAR --runThreadN 16 --runMode genomeGenerate --genomeDir $index --genomeFastaFiles $genome --sjdbGTFfile $gtf 
```

### HISAT2 indexing 

- HISAT2 doc: http://daehwankimlab.github.io/hisat2
- hisat2_index.sh

```bash

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
```
