#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastp
#SBATCH --mail-user=oriane.kopp@unifr.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/okopp/assembly_annotation_course/output_fastp_%j.o
#SBATCH --error=/data/users/okopp/assembly_annotation_course/error_fastp_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/okopp/assembly_annotation_course"
RESULTDIR="$WORKDIR/trimming"
mkdir -p $RESULTDIR
READDIR="$WORKDIR/Kar-1/*"
RNADIR="$WORKDIR/RNAseq_Sha"

module load fastp/0.23.4-GCC-10.3.0

# for Kar-1 
#fastp -i $READDIR -o $RESULTDIR/kar1.trimm.fastq.gz -h kar1fastp.html --disable_quality_filtering --disable_length_filtering --disable_trim_poly_g --disable_adapter_trimming 

# for RNA
fastp -i $RNADIR/ERR754081_1.fastq.gz -o $RESULTDIR/RNA_1.trimm.fastq.gz -I $RNADIR/ERR754081_2.fastq.gz -O $RESULTDIR/RNA_2.trimm.fastq.gz  -h $RESULTDIR/RNA_fastp.html