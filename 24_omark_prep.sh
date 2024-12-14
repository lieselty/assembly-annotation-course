#! /bin/bash
#!/usr/bin/env bash

#SBATCH --time=01:00:00
#SBATCH --mem=64G
#SBATCH --cpus-per-task=10
#SBATCH --job-name=prep
#SBATCH --partition=pibu_el8
#SBATCH --output=/data/users/okopp/assembly_annotation_course/prep_%j.out
#SBATCH --error=/data/users/okopp/assembly_annotation_course/prep_%j.err

# Check if the input file is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <input_file>"
    exit 1
fi

input_file=$1

# Read the file and process isoforms
awk '{
    # Split the first column by "-"
    split($1, arr, "-");
    prefix = arr[1];

    # Append the full identifier to the list for this prefix
    isoforms[prefix] = (isoforms[prefix] ? isoforms[prefix] ";" $1 : $1);
} END {
    # Print each prefix and its associated isoforms
    for (p in isoforms) {
        print isoforms[p];
    }
}' "$input_file"
