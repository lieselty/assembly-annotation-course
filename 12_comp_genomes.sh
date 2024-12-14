#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=genome_comp
#SBATCH --mail-user=oriane.kopp@unifr.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/okopp/assembly_annotation_course/output_genome_comp_%j.o
#SBATCH --error=/data/users/okopp/assembly_annotation_course/error_genome_comp_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/okopp/assembly_annotation_course"
REF=/data/courses/assembly-annotation-course/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa
FLYE="$WORKDIR/assembly/flye/assembly.fasta"
HIFIASM="$WORKDIR/assembly/hifiasm/Kar-1.fa"
LJA="$WORKDIR/assembly/LJA/assembly.fasta"
RESULTDIR="$WORKDIR/genomes_comparison"
LEZO="/data/users/lwuetschert/assembly-annotation-course/assemblies/hifiasm/ERR11437341.asm.bp.p_ctg.fa"
mkdir -p $RESULTDIR

#nucmer
#apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif nucmer --prefix genome_flye --breaklen 1000 --mincluster 1000 --threads 16 $REF $FLYE 

#apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif nucmer --prefix genome_hifiasm --breaklen 1000 --mincluster 1000 --threads 16 $REF $HIFIASM 

#apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif nucmer --prefix genome_LJA --breaklen 1000 --mincluster 1000 --threads 16 $REF $LJA 

#mummer
#apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $REF -Q $FLYE -breaklen 1000 --filter -t png --large --layout --fat -p $RESULTDIR/flye  genome_flye.delta

#apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $REF -Q $HIFIASM -breaklen 1000 --filter -t png --large --layout --fat -p $RESULTDIR/hifiasm  genome_hifiasm.delta

#apptainer exec --bind $WORKDIR /containers/apptainer/mummer4_gnuplot.sif mummerplot -R $REF -Q $LJA -breaklen 1000 --filter -t png --large --layout --fat -p $RESULTDIR/LJA  genome_LJA.delta


