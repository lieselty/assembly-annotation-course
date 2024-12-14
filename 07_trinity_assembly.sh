#!/usr/bin/env bash

#SBATCH --cpus-per-task=20
#SBATCH --mem=90G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=trinity
#SBATCH --mail-user=oriane.kopp@unifr.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/okopp/assembly_annotation_course/output_trinity_%j.o
#SBATCH --error=/data/users/okopp/assembly_annotation_course/error_trinity_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/okopp/assembly_annotation_course"
RESULTDIR="$WORKDIR/assembly/trinity"
mkdir -p $RESULTDIR
READDIR="$WORKDIR/trimming"

module load Trinity/2.15.1-foss-2021a

Trinity --seqType fq --max_memory 85G --left $READDIR/RNA_1.trimm.fastq.gz --right $READDIR/RNA_2.trimm.fastq.gz --CPU 20 --output $RESULTDIR