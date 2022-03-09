// Using DSL-2
nextflow.enable.dsl=2

// Import modules
include { ingest } from './modules/ingest'
include { predict } from './modules/predict'

// Main workflow
workflow {

    // Parse the CSV of gene expression data provided by the user
    ingest()

    // Predict the proportional abundances of cell types
    predict(ingest.out)

}