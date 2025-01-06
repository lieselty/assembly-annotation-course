# Load necessary libraries
library(ggplot2)
library(reshape2)

# Data input: Main dataset (original data)
superfamilies_data <- data.frame(
  Superfamily = c("LINE", "Copia", "Gypsy", "unknown_LTR", "CACTA", "Mutator", 
                  "PIF_Harbinger", "Tc1_Mariner", "hAT", "Helitron"),
  bpMasked = c(596560, 1291761, 2828646, 8100638, 813816, 3038120, 
               363475, 54821, 305246, 4039663),
  percentGenome = c(0.43, 0.92, 2.02, 5.78, 0.58, 2.17, 
                    0.26, 0.04, 0.22, 2.88),
  Dataset = "My annotation"
)

# Data input: Reference data (Kar-1 data from the paper)
kar1_data <- data.frame(
  Superfamily = c("CACTA", "Copia", "Gypsy", "hAT", "Helitron", "LINE", 
                  "unknown_LTR", "Mutator", "PIF_Harbinger", "Tc1_Mariner"),
  percentGenome = c(0.59, 1.24, 4.55, 0.23, 3.26, 0.07, 1.03, 0.77, 0.16, 0.1),
  Dataset = "Reference"
)

# Combine the two datasets
combined_data <- rbind(
  superfamilies_data[, c("Superfamily", "percentGenome", "Dataset")],
  kar1_data
)

# Melt the data for easier plotting
melted_combined <- melt(combined_data, id.vars = c("Superfamily", "Dataset"))

# Plot the data
ggplot(melted_combined, aes(x = Superfamily, y = value, fill = Dataset)) + 
  geom_bar(stat = "identity", position = "dodge") + 
  labs(title = "Comparison of TE Superfamilies Between Datasets", 
       x = "Superfamily", y = "Percent of Genome (%)") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_manual(values = c("My annotation" = "#984EA3", "Reference" = "#FC8D62"))
