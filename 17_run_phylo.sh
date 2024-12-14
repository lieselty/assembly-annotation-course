#!/usr/bin/env bash
#SBATCH --time=06:00:00
#SBATCH --mem=50G
#SBATCH --cpus-per-task=8
#SBATCH --job-name=phylo
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/okopp/assembly_annotation_course/phylo_%j.out
#SBATCH --error=/data/users/okopp/assembly_annotation_course/phylo_%j.err

# Set up working directories and files
WORKDIR=/data/users/okopp/assembly_annotation_course
FASTA_FILE=$WORKDIR/annotation/EDTA/assembly.fasta.mod.EDTA.TElib.fa
BRASSICADB=/data/courses/assembly-annotation-course/CDS_annotation/data/Brassicaceae_repbase_all_march2019.fasta
OUTDIR=$WORKDIR/results_TEsorter
RESULTDIR=$WORKDIR/phylogenetic_analysis
mkdir -p $OUTDIR $RESULTDIR

# Load necessary modules
module load SeqKit/2.6.1
module load Clustal-Omega/1.2.4-GCC-10.3.0
module load FastTree/2.1.11-GCCcore-10.3.0

# Step 1: Extract Copia and Gypsy sequences and run TEsorter
cd $OUTDIR
seqkit grep -r -p "Copia" $FASTA_FILE > Copia_sequences.fa
seqkit grep -r -p "Gypsy" $FASTA_FILE > Gypsy_sequences.fa

apptainer exec --bind /data --writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter Copia_sequences.fa -db rexdb-plant
apptainer exec --bind /data --writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter Gypsy_sequences.fa -db rexdb-plant
apptainer exec --bind /data --writable-tmpfs -u /data/courses/assembly-annotation-course/CDS_annotation/containers/TEsorter_1.3.0.sif TEsorter $BRASSICADB -db rexdb-plant

# Step 2: Extract RT protein sequences for phylogenetic analysis
COPIA=$OUTDIR/Copia_sequences.fa.rexdb-plant.dom.faa
GYPSY=$OUTDIR/Gypsy_sequences.fa.rexdb-plant.dom.faa
BRASSICA=$OUTDIR/Brassicaceae_repbase_all_march2019.fasta.rexdb-plant.dom.faa

# Generate lists and extract sequences for Gypsy, Copia, and Brassica
grep Ty3-RT $GYPSY > $RESULTDIR/listG.txt
sed -i 's/>//' $RESULTDIR/listG.txt
sed -i 's/ .\+//' $RESULTDIR/listG.txt
seqkit grep -f $RESULTDIR/listG.txt $GYPSY -o $RESULTDIR/Gypsy_RT.fasta

grep Ty1-RT $COPIA > $RESULTDIR/listC.txt
sed -i 's/>//' $RESULTDIR/listC.txt
sed -i 's/ .\+//' $RESULTDIR/listC.txt
seqkit grep -f $RESULTDIR/listC.txt $COPIA -o $RESULTDIR/Copia_RT.fasta

grep Ty3-RT $BRASSICA > $RESULTDIR/list1.txt
sed -i 's/>//' $RESULTDIR/list1.txt
sed -i 's/ .\+//' $RESULTDIR/list1.txt
seqkit grep -f $RESULTDIR/list1.txt $BRASSICA -o $RESULTDIR/Brassica_Ty3_RT.fasta

grep Ty1-RT $BRASSICA > $RESULTDIR/list2.txt
sed -i 's/>//' $RESULTDIR/list2.txt
sed -i 's/ .\+//' $RESULTDIR/list2.txt
seqkit grep -f $RESULTDIR/list2.txt $BRASSICA -o $RESULTDIR/Brassica_Ty1-RT.fasta

# Step 3: Perform sequence alignment with Clustal Omega
COPIA_RT_ALL=$RESULTDIR/Copia_RT_all.fasta
GYPSY_RT_ALL=$RESULTDIR/Gypsy_RT_all.fasta

clustalo -i $COPIA_RT_ALL -o $RESULTDIR/copia_prot_align.fasta
clustalo -i $GYPSY_RT_ALL -o $RESULTDIR/gypsy_prot_align.fasta

# Step 4: Generate phylogenetic trees with FastTree
FastTree -out $RESULTDIR/tree_copia $RESULTDIR/copia_prot_align.fasta
FastTree -out $RESULTDIR/tree_gypsy $RESULTDIR/gypsy_prot_align.fasta
