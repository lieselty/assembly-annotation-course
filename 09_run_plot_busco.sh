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
ASSEMBLY_HIFIASM=$WORKDIR/assemblies_evaluation/busco/busco_hifiasm/short_summary.specific.brassicales_odb10.busco_hifiasm.txt
ASSEMBLY_LJA=$WORKDIR/assemblies_evaluation/busco/busco_LJA/short_summary.specific.brassicales_odb10.busco_LJA.txt
ASSEMBLY_FLYE=$WORKDIR/assemblies_evaluation/busco/busco_flye/short_summary.specific.brassicales_odb10.busco_flye.txt
ASSEMBLY_TRINITY=$WORKDIR/assemblies_evaluation/busco/busco_trinity/short_summary.specific.brassicales_odb10.busco_trinity.txt
OUT_DIR=$WORKDIR/assemblies_evaluation/busco/plot
CONTAINER_SIF=/containers/apptainer/busco_5.7.1.sif

# create directory if not available
mkdir -p $OUT_DIR && cd $OUT_DIR

# copy all summaries into my output directory 
cp $ASSEMBLY_FLYE .
cp $ASSEMBLY_LJA .
cp $ASSEMBLY_HIFIASM .
cp $ASSEMBLY_TRINITY .

# generate plots
apptainer exec\
 --bind $OUT_DIR\
  $CONTAINER_SIF\
  generate_plot.py -wd $OUT_DIR