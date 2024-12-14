#!/usr/bin/env bash

#SBATCH --time=1-10:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=interesting
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/okopp/assembly_annotation_course/interesting_%j.out
#SBATCH --error=/data/users/okopp/assembly_annotation_course/interesting_%j.err

WORKDIR=/data/users/okopp/assembly_annotation_course
COURSEDIR=/data/courses/assembly-annotation-course/CDS_annotation

MAKERBIN="$COURSEDIR/softwares/Maker_v3.01.03/src/bin"
UNIPROT=$COURSEDIR/data/uniprot/uniprot_viridiplantae_reviewed.fa
BLAST=$WORKDIR/BLAST/blastp
PROTEINS=$WORKDIR/final_annotation/assembly.all.maker.proteins.fasta.renamed.filtered.fasta
FILTERED=$WORKDIR/final_annotation/filtered.genes.renamed.final.gff3

cp $PROTEINS $WORKDIR/final_annotation/maker_proteins.fasta.Uniprot
cp $FILTERED $WORKDIR/final_annotation/filtered.maker.gff3.Uniprot

$MAKERBIN/maker_functional_fasta $UNIPROT $BLAST $PROTEINS > $WORKDIR/final_annotation/maker_proteins.fasta.Uniprot
$MAKERBIN/maker_functional_gff $UNIPROT $BLAST $FILTERED > $WORKDIR/final_annotation/filtered.maker.gff3.Uniprot