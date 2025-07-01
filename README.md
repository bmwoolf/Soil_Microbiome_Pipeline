# Soil Microbiome Pipeline (Cloud + Nextflow)

## Overview
This project is a practice pipeline for analyzing soil microbiome 16S rRNA data using Nextflow, Docker, Kraken2, and MultiQC. The goal is to build a reproducible workflow that can run locally or on the cloud, and generate an HTML/PDF report summarizing the results.

## Conda Environment Setup (Required)

All scripts and CLI tools assume you have activated the provided conda environment:

```bash
conda env create -f environment.yml
conda activate soil-microbiome-pipeline
```

With mamba (faster):
```bash
mamba env create -f environment.yml
mamba activate soil-microbiome-pipeline
```

This environment includes: nextflow, sra-tools, kraken2, multiqc, curl, python, jupyter, numpy, pandas, etc.

> Note: The pipeline itself uses Docker for reproducibility, but this environment lets you run all scripts and CLI tools locally, and is ideal for development or downstream analysis.

## Project Structure

```
/data      # Raw and processed data
/pipeline  # Nextflow pipeline scripts
/docker    # Dockerfiles and configs
/results   # Output from pipeline runs
/reports   # MultiQC reports
/scripts   # Helper scripts (e.g., data download)
```

## Workflow Steps

1. **Download a public 16S rRNA soil dataset**
   - Activate the conda environment first!
   - Use the script: `./scripts/download_data.sh`
   - This will download a FASTQ file to `data/`

2. **Manually Download and extract the MiniKraken2 database**
   - Activate the conda environment first!
   - Download from: [MiniKraken2 v2 (5.5GB Archive size, 8GB Index size)](https://genome-idx.s3.amazonaws.com/kraken/minikraken2%5Fv2%5F8GB%5F201904.tgz)
   - Move the file to `data/kraken2-db/` and extract:
     ```bash
     mkdir -p data/kraken2-db
     mv ~/Downloads/minikraken2_v2_8GB_201904.tgz data/kraken2-db/
     cd data/kraken2-db
     tar -xzf minikraken2_v2_8GB_201904.tgz
     cd ../../../
     ```

3. **Run the Nextflow pipeline**
   - Make sure Docker is running.
   - Run:
     ```bash
     nextflow run pipeline/main.nf -c pipeline/nextflow.config \
       --kraken2_db "$PWD/data/kraken2-db/minikraken2_v2_8GB_201904_UPDATE" \
       -with-docker
     ```

4. **Outputs**
   - Kraken2 results: `results/`
   - MultiQC HTML report: `reports/multiqc_report.html`

## Troubleshooting
- **Command not found:** Make sure you have activated the conda environment (`conda activate soil-microbiome-pipeline`).
- **Missing tools:** Recreate the environment with `conda env create -f environment.yml`.
- **Docker errors:** Make sure Docker Desktop is running.
- **Database issues:** Ensure the MiniKraken2 database is fully downloaded and extracted in `data/kraken2-db/minikraken2_v2_8GB_201904_UPDATE/`.

## Requirements
- Docker
- Conda or Mamba
- (Optional) Jupyter, Python for downstream analysis

For more info and alternative databases, see [Ben Langmead's AWS Indexes for Kraken2/Bracken](https://benlangmead.github.io/aws-indexes/k2).

## Getting Started
Instructions will be added as the pipeline is developed.
