#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=40G
#SBATCH --time=01:00:00
#SBATCH --job-name=fastqc
#SBATCH --mail-user=oriane.kopp@unifr.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/okopp/assembly_annotation_course/output_fastqc_%j.o
#SBATCH --error=/data/users/okopp/assembly_annotation_course/error_fastqc_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/okopp/assembly_annotation_course"
RESULTDIR="$WORKDIR/read_QC/fastqc"
mkdir -p $RESULTDIR
READDIR="$WORKDIR/RNAseq_Sha"

# use container to run fastqc :)
apptainer exec --bind $WORKDIR /containers/apptainer/fastqc-0.12.1.sif fastqc -o $RESULTDIR $READDIR/*
