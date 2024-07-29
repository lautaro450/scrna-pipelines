#!/bin/bash

# Directory containing the files
dir="/mnt/faster/GSE100344"

# Output CSV file
output_file="samplesheet.csv"

# Create the header for the CSV file
echo "sample,fastq_1,fastq_2" > $output_file

# Find all unique SRR* prefixes and generate the samplesheet
for sample_prefix in $(ls $dir/SRR*_{1,2}.fastq.gz 2>/dev/null | sed -E 's/(.*)_([12]).fastq.gz/\1/' | sort | uniq); do
    fastq_1=$(basename "${sample_prefix}_1.fastq.gz")
    fastq_2=$(basename "${sample_prefix}_2.fastq.gz")
    sample=$(basename $sample_prefix)
    echo "$sample,$fastq_1,$fastq_2" >> $output_file
done


