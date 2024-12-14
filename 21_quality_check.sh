# I run it on the command line!

#nb genes
grep -P '\tgene\t' /data/users/okopp/assembly_annotation_course/final_annotation/filtered.genes.renamed.final.gff3 | wc -l
# 28206 --> good

#nb genes before filtering
grep -P '\tgene\t' /data/users/okopp/assembly_annotation_course/gene_annotation/assembly.all.maker.gff | wc -l

#nb mRNA
grep -P '\tmRNA\t' /data/users/okopp/assembly_annotation_course/final_annotation/filtered.genes.renamed.final.gff3 | wc -l
# 31757

#nb annotated genes
grep -P '\tgene\t' /data/users/okopp/assembly_annotation_course/final_annotation/filtered.genes.renamed.final.gff3 | grep 'InterPro' | wc -l
# 22245

#gene length
grep -P '\tgene\t' /data/users/okopp/assembly_annotation_course/final_annotation/filtered.genes.renamed.final.gff3 | awk '{diff = $5 - $4; sum += diff; if (NR == 1) {min = max = diff} else {if (diff < min) min = diff; if (diff > max) max = diff}} END {print "Min:", min, "Max:", max, "Mean:", sum / NR}'
# Min: 5 Max: 114055 Mean: 2178.49

# mRNA length
grep -P '\tmRNA\t' /data/users/okopp/assembly_annotation_course/final_annotation/filtered.genes.renamed.final.gff3 | awk '{diff = $5 - $4; sum += diff; if (NR == 1) {min = max = diff} else {if (diff < min) min = diff; if (diff > max) max = diff}} END {print "Min:", min, "Max:", max, "Mean:", sum / NR}'
# Min: 5 Max: 114055 Mean: 2216.78

# genes without blast hit
grep -P 'Protein of unknown function' maker_proteins.fasta.Uniprot | wc -l
# 23244

# genes with blast hit
grep -P 'Similar to' maker_proteins.fasta.Uniprot | wc -l
#8513