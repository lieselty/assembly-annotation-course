# Load necessary libraries
library(ggplot2)
library(reshape2)

# Data input: You can manually input or read from a file
superfamilies_data <- data.frame(
  Superfamily = c("L1", "Copia", "Gypsy", "unknown_LTR", "unknown_SINE", "CACTA", "Mutator", 
                  "PIF_Harbinger", "Tc1_Mariner", "hAT", "Helitron"),
  bpMasked = c(596560, 1291761, 2828646, 8100638, 34964, 813816, 3038120, 
               363475, 54821, 305246, 4039663),
  percentGenome = c(0.43, 0.92, 2.02, 5.78, 0.02, 0.58, 2.17, 
                    0.26, 0.04, 0.22, 2.88)
)

# Melt the data for easier plotting
melted_data <- melt(superfamilies_data, id.vars = "Superfamily")

# Plot showing only Percent of Genome
ggplot(superfamilies_data, aes(x = Superfamily, y = percentGenome, fill = Superfamily)) + 
  geom_bar(stat = "identity") + 
  labs(title = "Percentage of Genome Occupied by Superfamilies", 
       x = "Superfamily", y = "Percent of Genome (%)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_manual(values = c("L1" = "#E41A1C", "Copia" = "#377EB8", "Gypsy" = "#4DAF4A", 
                               "unknown_LTR" = "#984EA3", "unknown_SINE" = "#FF7F00", 
                               "CACTA" = "#FFFF33", "Mutator" = "#A65628", 
                               "PIF_Harbinger" = "#F781BF", "Tc1_Mariner" = "#999999", 
                               "hAT" = "#66C2A5", "Helitron" = "#FC8D62"))