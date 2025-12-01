#!/bin/bash

# conda install -n py27 python=2.7 numpy biopython bowtie

qrsh -q all.q@compute-0-3.local

rm -rf test_out/

mkdir -p test_out/

cleanfq1=tmp/SampleID_Clean_1.fq
cleanfq2=tmp/SampleID_Clean_2.fq
sample=SampleID

runName=test_out/SampleID

##- Class I 与 Class II 同时运行

nohup /share/nas2/genome/biosoft/Python/2.7.13/bin/python2.7 \
  seq2HLA_v2.2/seq2HLA.py \
    -1 $cleanfq1 -2 $cleanfq2 \
    -r $runName -p 12 > ${runName}_test.log 2>&1 &

# 开始： 11:01:47
# 结束： 11:36:36


##- Class I

mkdir -p test_out_ClassI
nohup /share/nas2/genome/biosoft/Python/2.7.13/bin/python2.7 \
  seq2HLA_v2.2/seq2HLA.py \
    -1 $cleanfq1 -2 $cleanfq2 \
    -r test_out_ClassI/SampleID -p 12 -m classI > test_out_ClassI/SampleID_test.log 2>&1 &


##- Class II

mkdir -p test_out_ClassII
nohup /share/nas2/genome/biosoft/Python/2.7.13/bin/python2.7 \
  seq2HLA_v2.2/seq2HLA.py \
    -1 $cleanfq1 -2 $cleanfq2 \
    -r test_out_ClassII/SampleID -p 12 -m classII > test_out_ClassII/SampleID_test.log 2>&1 &
