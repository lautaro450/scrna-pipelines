#!/bin/bash

# Path to manifest file
manifest="samplesheet.tsv"

# Path to genome directory
genomeDir="../../GRch38_index/"

# Loop through each line in the manifest file
while IFS=$'\t' read -r read1 read2 readGroup; do
    # Extract sample name from read file name (adjust as needed)
    sampleName=$(basename "$read1" | cut -d'_' -f1-4)

    # Create a temporary manifest file for the current sample
    echo -e "${read1}\t${read2}\t${readGroup}" > tmp_manifest.tsv

    # Run STAR for the current sample
    STAR --runThreadN 16 \
         --soloType SmartSeq \
         --soloUMIdedup NoDedup \
         --soloCBwhitelist None \
         --genomeDir "$genomeDir" \
         --readFilesManifest tmp_manifest.tsv \
         --outTmpDir "./tmpdir_${sampleName}" \
         --limitBAMsortRAM 100000000000 \
         --readFilesCommand zcat \
         --genomeLoad LoadAndKeep \
         --quantMode GeneCounts \
         --outSAMtype BAM SortedByCoordinate \
         --outFileNamePrefix "./output/${sampleName}_"
done < "$manifest"

# Remove temporary manifest file
rm tmp_manifest.tsv
