#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=1
#SBATCH --job-name=maker_out
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/okopp/assembly_annotation_course/maker_out_%j.out
#SBATCH --error=/data/users/okopp/assembly_annotation_course/maker_out_%j.err

WORKDIR=/data/users/okopp/assembly_annotation_course
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation
MAKERRES=$WORKDIR/gene_annotation

cd $MAKERRES

MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
$MAKERBIN/gff3_merge -s -d assembly.maker.output/assembly_master_datastore_index.log > assembly.all.maker.gff
$MAKERBIN/gff3_merge -n -s -d assembly.maker.output/assembly_master_datastore_index.log > assembly.all.maker.noseq.gff
$MAKERBIN/fasta_merge -d assembly.maker.output/assembly_master_datastore_index.log -o assembly