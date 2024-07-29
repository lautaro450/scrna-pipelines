#!/bin/bash

# Set the base directory
BASE_DIR="/mnt/faster/GSE100344/fastq/D8/output"

# Set the output zip file name
OUTPUT_ZIP="BJ_fibroblasts_matrices.zip"

# Create a temporary directory
TEMP_DIR=$(mktemp -d)

# Loop through all 96 samples
for i in {1..96}
do
    # Define the source directory
    SRC_DIR="${BASE_DIR}/BJ_fibroblasts_8_${i}_Solo.out/Gene/filtered"
    
    # Define the destination directory
    DEST_DIR="${TEMP_DIR}/BJ_fibroblasts_8_${i}"
    
    # Check if the source directory exists
    if [ -d "$SRC_DIR" ]; then
        # Create the destination directory
        mkdir -p "$DEST_DIR"
        
        # Copy the matrix.mtx file if it exists
        if [ -f "${SRC_DIR}/matrix.mtx" ]; then
            cp "${SRC_DIR}/matrix.mtx" "$DEST_DIR"
        else
            echo "Warning: matrix.mtx not found in ${SRC_DIR}"
        fi
        
        # Copy the features.tsv file if it exists
        if [ -f "${SRC_DIR}/features.tsv" ]; then
            cp "${SRC_DIR}/features.tsv" "$DEST_DIR"
        else
            echo "Warning: features.tsv not found in ${SRC_DIR}"
        fi
    else
        echo "Warning: Directory not found: ${SRC_DIR}"
    fi
done

# Create the zip file
zip -r "$OUTPUT_ZIP" "$TEMP_DIR"/*

# Clean up the temporary directory
rm -rf "$TEMP_DIR"

echo "Zip file created: $OUTPUT_ZIP"
