// Using DSL-2
nextflow.enable.dsl=2

def print_help(){
    log.info"""
    Required parameter: gene_tpm
    Use this parameter to indicate the path to a tab-delimited
    text file containing the gene expression profiles for a collection
    of samples.
    Gene symbols must be present in the first column and sample IDs must
    be listed on the first row. Expression data must be on non-log scale.

    Any columns containing non-numeric values will be removed.
    """

    exit 1
}

process parse_tsv {

    container "${params.container__pandas}"
    label "io_limited"

    input:
        path "input.tsv"

    output:
        path "parsed.tsv"

    script:
        template "parse_tsv.py"

}

workflow ingest {

    // If the user did not provide a path to a file with gene expression
    if ( params.gene_tpm == false ){
        print_help()
    }

    // Convert the input table from CSV to TSV
    parse_tsv(
        Channel
            .fromPath("${params.gene_tpm}")
    )

    emit:
        parse_tsv.out

}