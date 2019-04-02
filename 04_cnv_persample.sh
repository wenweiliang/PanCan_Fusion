###
#Date: 2018/2/20
#Author: Wen-Wei Liang @ Wash U (liang.w@wustl.edu)

#Aim: Get CNV value from TCGA data for each sample
#Usage: bash 04_cnv_persample.sh ${Task} ${Name}
#        ${Task}:The genelist you want to use, ex: Oncogene, TSG, PK, or Tcell
#        ${Name}:Random name to avoid session redundancy during tmux job running

###

Task=$1
Input="/diskmnt/Datasets/TCGA/CNV/all_thresholded.by_genes_whitelisted.tsv"
Working_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/08_CNV"

Genelist="/diskmnt/Projects/Users/wliang/Pancan_Fusion/05_Onco_TSG/${Task}.txt"


Num=`cat ${Input}|awk -F "\t" 'END{print NF}'`

##ONCOGENE
mkdir -p ${Working_Directory}/${Task}/
cd ${Working_Directory}/${Task}/
for i in $(seq ${Num}); do

cat ${Input} | awk -F "\t" 'FNR==1; NR==FNR{a[$1];next}{OFS="\t"; if ($1 in a) print $0}' ${Genelist} - | awk -F "\t" 'NR>1{OFS="\t"; $2=$3=$4=""; print $0}'| awk -F "\t" -v col=${i} -v OFS="\t" 'NR==1{fName=$(col+1)".cnv.txt";next} {print $1,$(col+1) > fName}'

done

