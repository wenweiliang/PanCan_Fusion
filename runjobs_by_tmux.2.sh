#!/bin/bash
Script=$1
Task=$2
Name=$3

for i in COAD GBM LGG READ;
do tmux new-session -d -s $i $3 "bash ${Script} $i $2"
echo "bash ${Script} $i $2"
done
