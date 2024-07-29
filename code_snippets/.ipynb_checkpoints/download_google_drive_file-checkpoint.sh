#!/bin/bash

# Check if a file ID is provided
if [ $# -eq 0 ]; then
    echo "Please provide a Google Drive file ID as an argument."
    echo "Usage: $0 <file_id>"
    exit 1
fi

# Get the file ID from the command line argument
FILE_ID="$1"

# Set the output directory
OUTPUT_DIR="."

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Download the file using gdown
gdown "https://drive.google.com/uc?id=$FILE_ID" -O "$OUTPUT_DIR/"

# Check if the download was successful
if [ $? -eq 0 ]; then
    echo "File downloaded successfully to $OUTPUT_DIR/"
else
    echo "Failed to download the file."
    exit 1
fi