library(tidyverse)
library(data.table)
setwd("C:/Users/Orian/OneDrive/Documents/Master/semestre_3/Organization and annotation of eukaryote genomes/1. Intact full length LTR-RTs")

# Load the data
anno_data=read.table("assembly.fasta.mod.LTR.intact.raw.gff3",header=F,sep="\t")
head(anno_data)
# Get the classification table
classification=fread("assembly.fasta.mod.LTR.intact.raw.fa.anno.list")

## NOTE:
# Or get the file by running the following command in bash:
# TEsorter assembly.fasta.mod.EDTA.raw/assembly.fasta.mod.LTR.intact.fa -db rexdb-plant
# It will be named as assembly.fasta.mod.LTR.intact.fa.rexdb-plant.cls.tsv
# Then run the following command in R:
# classification=fread("assembly.fasta.mod.EDTA.raw/assembly.fasta.mod.LTR.intact.fa.rexdb-plant.cls.tsv")

head(classification)
# Separate first column into two columns at "#", name the columns "Name" and "Classification"
names(classification)[1]="TE"
classification=classification%>%separate(TE,into=c("Name","Classification"),sep="#")


# Check the superfamilies present in the GFF3 file, and their counts
anno_data$V3 %>% table()

# Filter the data to select only TE superfamilies, (long_terminal_repeat, repeat_region and target_site_duplication are features of TE)
anno_data_filtered <- anno_data[!anno_data$V3 %in% c("long_terminal_repeat","repeat_region","target_site_duplication"), ]
nrow(anno_data_filtered)
# QUESTION: How Many TEs are there in the annotation file?

# Check the Clades present in the GFF3 file, and their counts
# select the feature column V9 and get the Name and Identity of the TE
anno_data_filtered$named_lists <- lapply(anno_data_filtered$V9, function(line) {
  setNames(
    sapply(strsplit(strsplit(line, ";")[[1]], "="), `[`, 2),
    sapply(strsplit(strsplit(line, ";")[[1]], "="), `[`, 1)
  )
})

anno_data_filtered$Name <- unlist(lapply(anno_data_filtered$named_lists, function(x) {
  x["Name"]
}))

anno_data_filtered$Identity <-unlist(lapply(anno_data_filtered$named_lists, function(x) {
  x["ltr_identity"]
}) )

anno_data_filtered$length <- anno_data_filtered$V5 - anno_data_filtered$V4

anno_data_filtered =anno_data_filtered %>%select(V1,V4,V5,V3,Name,Identity,length) 
head(anno_data_filtered)

# Merge the classification table with the annotation data
anno_data_filtered_classified=merge(anno_data_filtered,classification,by="Name",all.x=T)

table(anno_data_filtered_classified$Superfamily)
# QUESTION: Most abundant superfamilies are?

table(anno_data_filtered_classified$Clade)
# QUESTION: Most abundant clades are?

for(clade in c("Alesia", "Angela", "CRM", "SIRE", "TAR", "Tekay", "Retand")) {
  anno_data_filtered_classified <- anno_data_filtered_classified[anno_data_filtered_classified$Clade != clade, ]
}

# Create plots for each clade
plot_cl= ggplot(anno_data_filtered_classified[anno_data_filtered_classified$Superfamily!="unknown",], aes(x = Identity)) +
        geom_histogram(color="black", fill="#FC8D62")+
        facet_grid(Clade ~ Superfamily) +  
        cowplot::theme_cowplot()


pdf("01_full-length-LTR-RT-clades.pdf",height=20)
plot(plot_cl)
dev.off()

