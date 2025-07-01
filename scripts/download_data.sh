#!/bin/bash
# Download a test 16S rRNA dataset from SRA and save to data/
# Usage: Activate the conda environment first: conda activate soil-microbiome-pipeline
#        Then run: ./scripts/download_data.sh

set -e

# Example SRA accession (public, open-access, soil metagenome)
SRA_ID=SRR12416849
OUTDIR="$(dirname "$0")/../data"

mkdir -p "$OUTDIR"

# Download the data
fasterq-dump $SRA_ID -O "$OUTDIR"

echo "Download complete. Files saved to $OUTDIR" 