# Load required libraries
library(ggplot2)

# Create the dataframe
data <- data.frame(
  AED = c(0.000, 0.025, 0.050, 0.075, 0.100, 0.125, 0.150, 0.175, 0.200, 0.225, 
          0.250, 0.275, 0.300, 0.325, 0.350, 0.375, 0.400, 0.425, 0.450, 0.475, 
          0.500, 0.525, 0.550, 0.575, 0.600, 0.625, 0.650, 0.675, 0.700, 0.725, 
          0.750, 0.775, 0.800, 0.825, 0.850, 0.875, 0.900, 0.925, 0.950, 0.975, 1.000),
  assembly_all_maker = c(0.084, 0.162, 0.248, 0.310, 0.401, 0.453, 0.516, 0.546, 0.581, 0.601, 
                         0.638, 0.665, 0.708, 0.736, 0.781, 0.818, 0.863, 0.892, 0.932, 0.954, 
                         0.972, 0.979, 0.982, 0.986, 0.988, 0.990, 0.992, 0.993, 0.995, 0.995, 
                         0.996, 0.997, 0.998, 0.998, 0.999, 0.999, 0.999, 1.000, 1.000, 1.000, 1.000)
)

# Plot the data
ggplot(data, aes(x = AED, y = assembly_all_maker)) +
  geom_line(color = "darkolivegreen1") +
  geom_point(color = "deeppink") +
  geom_vline(xintercept = 0.5, linetype = "dashed", color = "lightsteelblue", size = 1) +
  labs(title = "Distribution of assembly.all.maker with AED", x = "AED", y = "assembly.all.maker.noseq.gff") +
  theme_minimal()
