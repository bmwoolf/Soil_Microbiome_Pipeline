#!/bin/bash
# Download a test 16S rRNA dataset from SRA and save to data/
# Usage: ./scripts/download_data.sh

set -e

# Example SRA accession (replace with a real one if needed)
SRA_ID=SRR1234567
OUTDIR="$(dirname "$0")/../data"

# Check if SRA Toolkit is installed
if ! command -v fasterq-dump &> /dev/null; then
    echo "SRA Toolkit not found. Installing via conda (recommended) or Homebrew..."
    if command -v conda &> /dev/null; then
        conda install -y -c bioconda sra-tools
    elif command -v brew &> /dev/null; then
        brew install sratoolkit
    else
        echo "Please install SRA Toolkit manually: https://github.com/ncbi/sra-tools"
        exit 1
    fi
fi

mkdir -p "$OUTDIR"

# Download the data
fasterq-dump $SRA_ID -O "$OUTDIR"

echo "Download complete. Files saved to $OUTDIR" 