#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=hifiasm
#SBATCH --mail-user=oriane.kopp@unifr.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/okopp/assembly_annotation_course/output_hifiasm_%j.o
#SBATCH --error=/data/users/okopp/assembly_annotation_course/error_hifiasm_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/okopp/assembly_annotation_course"
RESULTDIR="$WORKDIR/assembly/hifiasm"
mkdir -p $RESULTDIR
READDIR="$WORKDIR/Kar-1"

apptainer exec --bind $WORKDIR /containers/apptainer/hifiasm_0.19.8.sif hifiasm -o $RESULTDIR/Kar-1.gfa -t 16 $READDIR/ERR11437325.fastq.gz
