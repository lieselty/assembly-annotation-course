#!/usr/bin/env bash

#SBATCH --time=1-10:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=blast
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/okopp/assembly_annotation_course/blast_%j.out
#SBATCH --error=/data/users/okopp/assembly_annotation_course/blast_%j.err

WORKDIR=/data/users/okopp/assembly_annotation_course
PROTEINS=$WORKDIR/final_annotation/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
OUTDIR=$WORKDIR/BLAST
mkdir -p $OUTDIR

module load BLAST+/2.15.0-gompi-2021a

blastp -query $PROTEINS -db /data/courses/assembly-annotation-course/CDS_annotation/data/uniprot/uniprot_viridiplantae_reviewed.fa -num_threads 10 -outfmt 6 -evalue 1e-10 -out $OUTDIR/blastp
