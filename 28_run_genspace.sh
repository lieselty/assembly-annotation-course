#!/bin/bash

#SBATCH --time=01:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=25
#SBATCH --job-name=genespace
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/okopp/assembly_annotation_course/genespace_%j.out
#SBATCH --error=/data/users/okopp/assembly_annotation_course/genespace_%j.err

COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
WORKDIR="/data/users/okopp/assembly_annotation_course"
GENESPACE=/data/users/okopp/assembly_annotation_course/genespace

apptainer exec --bind $COURSEDIR --bind "$WORKDIR" --bind "$SCRATCH:/temp" "$COURSEDIR/containers/genespace_latest.sif" Rscript "$WORKDIR/scripts/27_genspace.R" $GENESPACE 

