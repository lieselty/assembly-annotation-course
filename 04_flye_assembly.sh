#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=flye
#SBATCH --mail-user=oriane.kopp@unifr.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/okopp/assembly_annotation_course/output_flye_%j.o
#SBATCH --error=/data/users/okopp/assembly_annotation_course/error_flye_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/okopp/assembly_annotation_course"
RESULTDIR="$WORKDIR/assembly/flye"
mkdir -p $RESULTDIR
READDIR="$WORKDIR/Kar-1"

apptainer exec --bind $WORKDIR /containers/apptainer/flye_2.9.5.sif flye --pacbio-hifi $READDIR/ERR11437325.fastq.gz -o $RESULTDIR -t 16
