#!/bin/bash
Script=$1
Task=$2
Name=$3

for i in ACC BLCA BRCA CESC CHOL COAD DLBC ESCA GBM HNSC KICH KIRC KIRP LAML LGG LIHC LUAD LUSC MESO OV PAAD PCPG PRAD READ SARC SKCM STAD TGCT THCA THYM UCEC UCS UVM;
do tmux new-session -d -s $i$3 "bash ${Script} $i $2"
echo "bash ${Script} $i $2"
done
