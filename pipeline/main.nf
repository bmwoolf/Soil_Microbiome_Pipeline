#!/usr/bin/env nextflow

params.data_dir = '../data'
params.results_dir = '../results'
params.reports_dir = '../reports'

process Kraken2 {
    publishDir params.results_dir, mode: 'copy'
    container 'biocontainers/kraken2:v2.1.2_cv1'
    input:
        path fastq_file from Channel.fromPath("${params.data_dir}/*.fastq")
    output:
        path "${fastq_file.simpleName}.kraken2"
    script:
    """
    kraken2 --db /kraken2-db --output ${fastq_file.simpleName}.kraken2 $fastq_file
    """
}

process MultiQC {
    publishDir params.reports_dir, mode: 'copy'
    container 'ewels/multiqc:1.14'
    input:
        path kraken2_reports from Kraken2.out.collect()
    output:
        path 'multiqc_report.html'
    script:
    """
    multiqc .
    """
}

workflow {
    kraken2_results = Kraken2()
    MultiQC(kraken2_results)
} 