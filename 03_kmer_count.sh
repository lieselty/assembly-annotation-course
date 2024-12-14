#!/usr/bin/env bash

#SBATCH --cpus-per-task=4
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=jellyfish
#SBATCH --mail-user=oriane.kopp@unifr.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/okopp/assembly_annotation_course/output_jellyfish_%j.o
#SBATCH --error=/data/users/okopp/assembly_annotation_course/error_jellyfish_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/okopp/assembly_annotation_course"
RESULTDIR="$WORKDIR/read_QC/kmer_counting"
mkdir -p $RESULTDIR
READDIR="$WORKDIR/Kar-1"

module load Jellyfish/2.3.0-GCC-10.3.0

jellyfish count -C -m 21 -s 5G -t 4 <(zcat "$READDIR/ERR11437325.fastq.gz") -o "$RESULTDIR/reads.jf"

jellyfish histo -t 4 "$RESULTDIR/reads.jf" > "$RESULTDIR/reads.histo"