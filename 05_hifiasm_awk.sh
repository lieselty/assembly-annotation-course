#!/usr/bin/env bash

#SBATCH --cpus-per-task=1
#SBATCH --mem=100M
#SBATCH --time=00:10:00
#SBATCH --job-name=awk
#SBATCH --output=/data/users/okopp/assembly_annotation_course/output_awk_%j.o
#SBATCH --error=/data/users/okopp/assembly_annotation_course/error_awk_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/okopp/assembly_annotation_course"
RESULTDIR="$WORKDIR/assembly/hifiasm"

awk '/^S/{print ">"$2;print $3}' $RESULTDIR/Kar-1.gfa.bp.p_ctg.gfa > $RESULTDIR/Kar-1.fa