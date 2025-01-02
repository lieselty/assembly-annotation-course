library(dplyr)
library(seqinr)

setwd("C:/Users/Orian/OneDrive/Documents/Master/semestre_3/Organization and annotation of eukaryote genomes/7. BUSCO")

# Read the transcript index file
transcript <- read.table("assembly.all.maker.proteins.fasta.renamed.filtered.fasta.fai")
transcript <- transcript[,1:2]

# Create a new column by trimming the last 3 characters from the first column
transcript$V3 <- substr(transcript$V1, 1, nchar(transcript$V1) - 3)

# Filter transcripts based on the maximum length
transcript_filtered <- transcript %>%
  group_by(V3) %>%
  slice_max(order_by = V2, n = 1) %>%
  ungroup() 

transcript_filtered <- transcript_filtered[,1:2]

# Read the fasta file of the transcripts
fasta_transcript <- read.fasta("assembly.all.maker.proteins.fasta.renamed.filtered.fasta")

# Get the target sequence IDs
target_IDs <- transcript_filtered$V1

# Filter sequences based on the target IDs
filtered_sequences <- fasta_transcript[names(fasta_transcript) %in% target_IDs]

# Get the sequence names and convert them to uppercase
seq_names <- names(filtered_sequences)
names(filtered_sequences) <- toupper(seq_names)  # Convert only the sequence names to uppercase

# Write the filtered sequences to a new FASTA file
output_fasta <- "longest_proteins.fasta"
write.fasta(sequences = filtered_sequences, names = names(filtered_sequences), file.out = output_fasta)

# Confirm the output
cat("Filtered fasta file saved as:", output_fasta, "\n")
