#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=dyn
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/okopp/assembly_annotation_course/dyn_%j.out
#SBATCH --error=/data/users/okopp/assembly_annotation_course/dyn_%j.err

WORKDIR=/data/users/okopp/assembly_annotation_course
INPUT_FILE=$WORKDIR/annotation/EDTA/assembly.fasta.mod.EDTA.anno/assembly.fasta.mod.out
FASTA_FILE=$WORKDIR/annotation/EDTA/assembly.fasta.mod.EDTA.TElib.fa
parseRM=/data/courses/assembly-annotation-course/CDS_annotation/scripts/04-parseRM.pl

module add BioPerl/1.7.8-GCCcore-10.3.0

perl $parseRM -i $INPUT_FILE -l 50,1 -v