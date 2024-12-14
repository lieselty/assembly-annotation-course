#!/usr/bin/env bash

#SBATCH --time=2-10:00:00
#SBATCH --mem=80G
#SBATCH --cpus-per-task=24
#SBATCH --job-name=BUSCO
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/okopp/assembly_annotation_course/BUSCO_%j.out
#SBATCH --error=/data/users/okopp/assembly_annotation_course/BUSCO_%j.err

WORKDIR=/data/users/okopp/assembly_annotation_course
TRANSDIR=$WORKDIR/final_annotation/longest_transcript.fasta
PROTDIR=$WORKDIR/final_annotation/longest_proteins.fasta
OUTDIR=$WORKDIR/BUSCO_anno
mkdir -p $OUTDIR

module load BUSCO/5.4.2-foss-2021a
busco -i $TRANSDIR -l brassicales_odb10 -o busco_transcriptom --out_path $OUTDIR -m transcriptome -f --cpu 24

busco -i $PROTDIR -l brassicales_odb10 -o busco_protein --out_path $OUTDIR -m proteins -f --cpu 24