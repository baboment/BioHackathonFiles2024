#!/usr/bin/env cwl-runner

class: CommandLineTool
id: vcf-togovar-annotation
label: vcf-togovar-annotation
cwlVersion: v1.2

requirements:
  DockerRequirement:
    dockerPull: ghcr.io/uclahs-cds/bcftools:1.20
  InlineJavascriptRequirement: {}

baseCommand: [bcftools]

arguments:
  - position: 1
    valueFrom: annotate

inputs:
  colname:
    type: string?
    default: TGV,-,CHROM,POS,REF,ALT,-,-,-,-,-,-,-,-
    inputBinding:
      position: 2
      prefix: -c
  annotationfile:
    type: File
    inputBinding:
      position: 3
      prefix: --annotations
  header:
    type: File
    inputBinding:
      position: 4
      prefix: -h
  vcf:
    type: File
    inputBinding:
      position: 5
  output_name:
    type: string
    default: 'togovar.vcf.gz'
    inputBinding:
      position: 6
      prefix: -o
      valueFrom: $(runtime.outdir)/$(inputs.vcf.basename.slice(0, -7))_togovar.vcf.gz

outputs:
  outputfile:
    type:
      type: array
      items:
      - File
      - Directory
    outputBinding:
      glob: "*"
