#!/bin/bash
# Download and extract MiniKraken2 database for testing
# Usage: Activate the conda environment first: conda activate soil-microbiome-pipeline
#        Then run: ./scripts/download_kraken2_db.sh

set -e

DB_DIR="$(dirname "$0")/../data/kraken2-db"
MINIKRAKEN_URL="https://genome-idx.s3.amazonaws.com/kraken/minikraken2%5Fv2%5F8GB%5F201904.tgz"

mkdir -p "$DB_DIR"
cd "$DB_DIR"

# Download and extract MiniKraken2 (small test DB)
if [ ! -f minikraken2_v2_8GB_201904.tgz ]; then
    echo "Downloading MiniKraken2 test database..."
    curl -L -o minikraken2_v2_8GB_201904.tgz "$MINIKRAKEN_URL"
fi

echo "Extracting MiniKraken2..."
tar -xzf minikraken2_v2_8GB_201904.tgz

echo "MiniKraken2 database ready at $DB_DIR" 