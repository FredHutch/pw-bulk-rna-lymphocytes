#!/bin/bash

set -euo pipefail

# Stage the input file as expected by this script
mkdir -p /opt/quantiseq/Input/
cp input.tsv /opt/quantiseq/Input/inputfile.txt

/opt/quantiseq/quanTIseq.sh \
    --outputdir="./" \
    --inputfile=/opt/quantiseq/Input/inputfile.txt \
    --pipelinestart="decon" \
    --tumor="${params.tumor ? 'TRUE' : 'FALSE'}" \
    --method="${params.method}" \
    --threads=${task.cpus}

# Get the outputs
cp /opt/quantiseq/user_output/* ./