// Using DSL-2
nextflow.enable.dsl=2

def print_help(){
    log.info"""
    Required parameter: output_folder
    Use this parameter to indicate the directory where all outputs will be published
    """

    exit 1
}

process quantiseq {

    container "${params.container__quantiseq}"
    publishDir "${params.output_folder}", mode: "copy", overwrite: true

    input:
        path "input.tsv"

    output:
        path "*"

    script:
        template "quantiseq.sh"

}

workflow predict {

    take:
    tsv_ch

    main:

    // If the user did not provide a path for the output
    if ( params.output_folder == false ){
        print_help()
    }

    quantiseq(tsv_ch)

    emit:
    quantiseq.out

}