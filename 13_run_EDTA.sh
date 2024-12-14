#!/usr/bin/env bash

#SBATCH --cpus-per-task=21
#SBATCH --mem=80G
#SBATCH --time=2-10:00:00
#SBATCH --job-name=edta
#SBATCH --mail-user=oriane.kopp@unifr.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/okopp/assembly_annotation_course/output_edta_%j.o
#SBATCH --error=/data/users/okopp/assembly_annotation_course/error_edta_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/okopp/assembly_annotation_course"
LJA="$WORKDIR/assembly/LJA/assembly.fasta"
OUTDIR="$WORKDIR/annotation/EDTA"
mkdir -p $OUTDIR

cd $OUTDIR


# run EDTA2 in conda environment (sorry it's on one line)

perl $WORKDIR/scripts/EDTA/EDTA.pl --genome $LJA --species others --step all --cds "/data/courses/assembly-annotation-course/CDS_annotation/data/TAIR10_cds_20110103_representative_gene_model_updated" --anno 1 --threads 21