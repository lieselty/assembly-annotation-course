# Set the working directory
setwd("C:/Users/Orian/OneDrive/Documents/Master/semestre_3/Organization and annotation of eukaryote genomes/Intact full length LTR-RTs")

# Load the necessary libraries
library(tidyverse)
library(data.table)
library(cowplot)

# Load the annotation data
anno_data = read.table("assembly.fasta.mod.LTR.intact.raw.gff3", header = FALSE, sep = "\t")

# Load the classification data
classification = fread("assembly.fasta.mod.LTR.intact.raw.fa.anno.list")

# Rename the first column in the classification data
names(classification)[1] = "TE"

# Split the 'TE' column into 'Name' and 'Classification'
classification = classification %>%
  separate(TE, into = c("Name", "Classification"), sep = "#")

# Filter to only keep relevant LTR-RTs and remove unwanted features
# Check the types of annotations available
print(table(anno_data$V3))

# Remove unnecessary rows
anno_data_filtered = anno_data[!anno_data$V3 %in% c("long_terminal_repeat", "repeat_region", "target_site_duplication"), ]

# Create a list to extract relevant info from column 9
anno_data_filtered$named_lists = lapply(anno_data_filtered$V9, function(line) {
  setNames(
    sapply(strsplit(strsplit(line, ";")[[1]], "="), `[`, 2),
    sapply(strsplit(strsplit(line, ";")[[1]], "="), `[`, 1)
  )
})

# Extract the 'Name' and 'Identity' from the named lists
anno_data_filtered$Name = unlist(lapply(anno_data_filtered$named_lists, function(x) x["Name"]))
anno_data_filtered$Identity = unlist(lapply(anno_data_filtered$named_lists, function(x) x["ltr_identity"]))

# Calculate the length of the LTR-RT
anno_data_filtered$length = anno_data_filtered$V5 - anno_data_filtered$V4

# Select the important columns for the analysis
anno_data_filtered = anno_data_filtered %>%
  select(V1, V4, V5, V3, Name, Identity, length)

# Merge the filtered annotation data with the classification data
anno_data_filtered_classified = merge(anno_data_filtered, classification, by = "Name", all.x = TRUE)

# Print how many clades are present
print(table(anno_data_filtered_classified$Clade))

# Convert Identity to numeric for plotting
anno_data_filtered_classified$Identity = as.numeric(as.character(anno_data_filtered_classified$Identity))

# Convert Clade to factor for easier plotting
anno_data_filtered_classified$Clade = as.factor(anno_data_filtered_classified$Clade)

# Create a list to hold plots for each clade
plots = list()

# Loop over each unique clade and create a histogram for each
for (clade in unique(anno_data_filtered_classified$Clade)) {
  # Filter data for the current clade
  data = anno_data_filtered_classified[anno_data_filtered_classified$Clade == clade, ]
  
  # Only create a plot if there is data for the clade
  if (nrow(data) > 0) {
    plots[[clade]] = ggplot(data, aes(x = Identity)) +
      geom_histogram(binwidth = 0.01, fill = sample(colors(), 1), color = "black", alpha = 0.7) +
      scale_x_continuous(limits = c(0.8, 1), breaks = seq(0.8, 1, 0.05)) +
      ggtitle(clade) +
      theme_minimal()
  }
}

# Display all plots in R
plot_grid(plotlist = plots, ncol = 2)
