#! /bin/bash
#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=OMArk
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/okopp/assembly_annotation_course/OMArk_%j.out
#SBATCH --error=/data/users/okopp/assembly_annotation_course/OMArk_%j.err


COURSEDIR="/data/courses/assembly-annotation-course/CDS_annotation"
WORKDIR="/data/users/okopp/assembly_annotation_course"

protein="$WORKDIR/final_annotation/assembly.all.maker.proteins.fasta.renamed.filtered.fasta"
splice="$WORKDIR/final_annotation/isoform_list.txt"

OMArk="/data/courses/assembly-annotation-course/CDS_annotation/softwares/OMArk-0.3.0/"

OMArk="/data/courses/assembly-annotation-course/CDS_annotation/softwares/OMArk-0.3.0/"

wget https://omabrowser.org/All/LUCA.h5
omamer search --db  LUCA.h5 --query ${protein} --out ${protein}.omamer

omark -f ${protein}.omamer -of ${protein} -i $splice -d LUCA.h5 -o omark_output