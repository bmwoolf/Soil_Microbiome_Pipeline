#!/usr/bin/env nextflow

params.data_dir = './data'
params.results_dir = './results'
params.reports_dir = './reports'
params.kraken2_db = null

// Hardcoded paired-end input for one sample
fastq_pairs = Channel.of(
  ['SRR12416849', [file("${params.data_dir}/SRR12416849_1.fastq"), file("${params.data_dir}/SRR12416849_2.fastq")]]
)

fastq_pairs.view()

process Kraken2 {
    publishDir params.results_dir, mode: 'copy'
    input:
        tuple val(sample_id), path(reads)
    output:
        path "${sample_id}.kraken2"
    script:
    """
    kraken2 --db ${params.kraken2_db} --paired --output ${sample_id}.kraken2 ${reads[0]} ${reads[1]}
    """
}

process MultiQC {
    publishDir params.reports_dir, mode: 'copy'
    container 'ewels/multiqc:1.14'
    input:
        path kraken2_reports
    output:
        path 'multiqc_report.html'
    script:
    """
    multiqc .
    """
}

workflow {
    kraken2_results = Kraken2(fastq_pairs)
    MultiQC(kraken2_results)
} 