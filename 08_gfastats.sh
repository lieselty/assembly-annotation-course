#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=100M
#SBATCH --time=1-00:00:00
#SBATCH --job-name=stats
#SBATCH --mail-user=oriane.kopp@unifr.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/okopp/assembly_annotation_course/output_stats_%j.o
#SBATCH --error=/data/users/okopp/assembly_annotation_course/error_stats_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/okopp/assembly_annotation_course"
RESULTDIR="$WORKDIR/evaluation"
mkdir -p $RESULTDIR
ASSEMBLYDIR="$WORKDIR/assembly"

#apptainer exec --bind $WORKDIR /containers/apptainer/gfastats_1.3.7.sif gfastats $ASSEMBLYDIR/hifiasm/Kar-1.fa > $RESULTDIR/hifiasm_stats.txt

#apptainer exec --bind $WORKDIR /containers/apptainer/gfastats_1.3.7.sif gfastats $ASSEMBLYDIR/flye/assembly.fasta > $RESULTDIR/flye_stats.txt

#apptainer exec --bind $WORKDIR /containers/apptainer/gfastats_1.3.7.sif gfastats $ASSEMBLYDIR/LJA/assembly.fasta > $RESULTDIR/LJA_stats.txt

apptainer exec --bind $WORKDIR /containers/apptainer/gfastats_1.3.7.sif gfastats $ASSEMBLYDIR/LJA/assembly.fasta > $RESULTDIR/LJA_stats.txt
