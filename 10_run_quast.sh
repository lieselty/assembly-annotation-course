#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=quast
#SBATCH --mail-user=oriane.kopp@unifr.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/okopp/assembly_annotation_course/output_quast_%j.o
#SBATCH --error=/data/users/okopp/assembly_annotation_course/error_quast_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/okopp/assembly_annotation_course"

FLYE="$WORKDIR/assembly/flye/assembly.fasta"
FLYERESULTS="$WORKDIR/assemblies_evaluation/quast/flye"
FLYERESULTSNO="$WORKDIR/assemblies_evaluation/quast/flye_noref"

mkdir -p $FLYERESULTS $FLYERESULTSNO

HIFIASM="$WORKDIR/assembly/hifiasm/Kar-1.fa"
HIFIASMRESULTS="$WORKDIR/assemblies_evaluation/quast/hifiasm"
HIFIASMRESULTSNO="$WORKDIR/assemblies_evaluation/quast/hifiasm_noref"
mkdir -p $HIFIASMRESULTS $HIFIASMRESULTSNO

LJA="$WORKDIR/assembly/LJA/assembly.fasta"
LJARESULTS="$WORKDIR/assemblies_evaluation/quast/LJA"
LJARESULTSNO="$WORKDIR/assemblies_evaluation/quast/LJA_noref"
mkdir -p $LJARESULTS $LJARESULTSNO

ALL="$WORKDIR/assemblies_evaluation/quast/all"
ALLNO="$WORKDIR/assemblies_evaluation/quast/all_noref"
mkdir -p $ALL $ALLNO

REF_FEATURE=/data/courses/assembly-annotation-course/references/TAIR10_GFF3_genes.gff
REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa



# with ref
#flye
apptainer exec --bind $WORKDIR /containers/apptainer/quast_5.2.0.sif\
 quast.py -o $FLYERESULTS --labels Kar1_flye -r $REF --features $REF_FEATURE --threads 16 --eukaryote $FLYE

#hifiasm
apptainer exec --bind $WORKDIR /containers/apptainer/quast_5.2.0.sif\
 quast.py -o $HIFIASMRESULTS --labels Kar1_hifiasm -r $REF --features $REF_FEATURE --threads 16 --eukaryote $HIFIASM

#lja
apptainer exec --bind $WORKDIR /containers/apptainer/quast_5.2.0.sif\
 quast.py -o $LJARESULTS --labels Kar1_LJA -r $REF --features $REF_FEATURE --threads 16 --eukaryote $LJA

#all
apptainer exec --bind $WORKDIR /containers/apptainer/quast_5.2.0.sif\
 quast.py -o $ALL --labels Kar1_LJA,Kar1_hifi,Kar1_flye -r $REF --features $REF_FEATURE --threads 16 --eukaryote $LJA $HIFIASM $FLYE


# without ref
#flye
apptainer exec --bind $WORKDIR /containers/apptainer/quast_5.2.0.sif\
 quast.py -o $FLYERESULTSNO --labels Kar1_flye --threads 16 --eukaryote --est-ref-size 130000000 $FLYE

#hifiasm
apptainer exec --bind $WORKDIR /containers/apptainer/quast_5.2.0.sif\
 quast.py -o $HIFIASMRESULTSNO --labels Kar1_hifiasm --threads 16 --eukaryote --est-ref-size 130000000 $HIFIASM

#lja
apptainer exec --bind $WORKDIR /containers/apptainer/quast_5.2.0.sif\
 quast.py -o $LJARESULTSNO --labels Kar1_LJA  --threads 16 --eukaryote --est-ref-size 130000000 $LJA

#all
apptainer exec --bind $WORKDIR /containers/apptainer/quast_5.2.0.sif\
 quast.py -o $ALLNO --labels Kar1_LJA,Kar1_hifi,Kar1_flye  --threads 16 --eukaryote --est-ref-size 130000000 $LJA $HIFIASM $FLYE