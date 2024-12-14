#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=busco
#SBATCH --mail-user=oriane.kopp@unifr.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/okopp/assembly_annotation_course/output_busco_%j.o
#SBATCH --error=/data/users/okopp/assembly_annotation_course/error_busco_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/okopp/assembly_annotation_course"
RESULTDIR="$WORKDIR/assemblies_evaluation/busco"
mkdir -p $RESULTDIR

FLYE="$WORKDIR/assembly/flye/assembly.fasta"
HIFIASM="$WORKDIR/assembly/hifiasm/Kar-1.fa"
LJA="$WORKDIR/assembly/LJA/assembly.fasta"
TRINITY="$WORKDIR/assembly/trinity.Trinity.fasta"

module load BUSCO/5.4.2-foss-2021a

#flye
busco --in $FLYE --out busco_flye --out_path $RESULTDIR --mode genome --lineage_dataset brassicales_odb10 --cpu 16 -f 

#hifiasm
busco -i $HIFIASM -o busco_hifiasm --out_path $RESULTDIR --mode genome --lineage_dataset brassicales_odb10 --cpu 16 -f

#lja
busco -i $LJA -o busco_LJA --out_path $RESULTDIR --mode genome --lineage_dataset brassicales_odb10 --cpu 16 -f 

#trinity (transcriptome)
busco -i $TRINITY -o busco_trinity --out_path $RESULTDIR --mode transcriptome --lineage_dataset brassicales_odb10 --cpu 16 -f
