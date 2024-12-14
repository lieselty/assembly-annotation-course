#!/usr/bin/env bash

#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=1-00:00:00
#SBATCH --job-name=merqury
#SBATCH --mail-user=oriane.kopp@unifr.ch
#SBATCH --mail-type=end
#SBATCH --output=/data/users/okopp/assembly_annotation_course/output_merqury_%j.o
#SBATCH --error=/data/users/okopp/assembly_annotation_course/error_merqury_%j.e
#SBATCH --partition=pibu_el8

WORKDIR="/data/users/okopp/assembly_annotation_course"

FLYE="$WORKDIR/assembly/flye/assembly.fasta"
HIFIASM="$WORKDIR/assembly/hifiasm/Kar-1.fa"
LJA="$WORKDIR/assembly/LJA/assembly.fasta"
READDIR="$WORKDIR/Kar-1/ERR11437325.fastq.gz"
RESULTDIR="$WORKDIR/assemblies_evaluation/merqury"
MERYL="$RESULTDIR/meryl.meryl"
FLYERES="$RESULTDIR/flye"
HIFIRES="$RESULTDIR/hifiasm"
LJARES="$RESULTDIR/LJA"

mkdir -p $RESULTDIR $FLYERES $HIFIRES $LJARES

export MERQURY="/usr/local/share/merqury"

# find best kmer size
#apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif\
# $MERQURY/best_k.sh 130000000 
#k = 18.4591 --> go with 18
k=18

# build kmer dbs
#apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif\
# meryl k=$k count $READDIR output $MERYL.meryl
#done

#run merqury
#flye
cd /data/users/okopp/assembly_annotation_course/assemblies_evaluation/merqury/flye
apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif\
 merqury.sh $MERYL $FLYE eval_flye  

#hifiasm
cd /data/users/okopp/assembly_annotation_course/assemblies_evaluation/merqury/hifiasm
apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif\
 merqury.sh $MERYL $HIFIASM eval_hifiasm  

#lja
cd /data/users/okopp/assembly_annotation_course/assemblies_evaluation/merqury/LJA
apptainer exec --bind /data /containers/apptainer/merqury_1.3.sif\
 merqury.sh $MERYL $LJA eval_lja  