#!/usr/bin/env nextflow
include { refindex } from './processes/refindex.nf'
include { qcontrol } from './processes/qcontrol.nf'
include { align    } from './processes/align.nf'

workflow {
    reads = channel.fromFilePairs(params.reads)
    reference = channel.fromPath(params.reference).collect()
    refindex(reference)
    qcontrol(reads)
    align(reference, qcontrol.out[0], refindex.out)
}