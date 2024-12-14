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
TRANSCRIPT=$WORKDIR/BUSCO_anno/busco_transcriptom/short_summary.specific.brassicales_odb10.busco_transcriptom.txt
PROTEIN=$WORKDIR/BUSCO_anno/busco_protein/short_summary.specific.brassicales_odb10.busco_protein.txt

OUT_DIR=$WORKDIR/BUSCO_anno/plot
# create directory if not available
mkdir -p $OUT_DIR && cd $OUT_DIR

CONTAINER_SIF=/containers/apptainer/busco_5.7.1.sif

# copy all summaries into my output directory 
cp $TRANSCRIPT .
cp $PROTEIN .

# generate plots
apptainer exec\
 --bind $OUT_DIR\
  $CONTAINER_SIF\
  generate_plot.py -wd $OUT_DIR