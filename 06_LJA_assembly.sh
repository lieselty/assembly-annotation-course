#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=LJA
#SBATCH --mail-user=oriane.kopp@unifr.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/okopp/assembly_annotation_course/output_LJA_%j.o
#SBATCH --error=/data/users/okopp/assembly_annotation_course/error_LJA_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/okopp/assembly_annotation_course"
RESULTDIR="$WORKDIR/assembly/LJA"
mkdir -p $RESULTDIR
READDIR="$WORKDIR/Kar-1"

apptainer exec --bind $WORKDIR /containers/apptainer/lja-0.2.sif lja -o $RESULTDIR --reads $READDIR/ERR11437325.fastq.gz -t 16
