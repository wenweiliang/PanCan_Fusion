###
#Date: 2018/2/20
#Author: Wen-Wei Liang @ Wash U (liang.w@wustl.edu)

#Aim: Get expression value from RNA-seq data for each sample. This script is required for the four cancer types that have mixed RNA-seq data
#Usage: bash runjobs_by_tmux.2.sh 03_exp_persample.for_4cancer.sh ${Task} ${Name}
#	${Task}:The genelist you want to use, ex: Oncogene, TSG, PK, or Tcell
#	${Name}:Random name to avoid session redundancy during tmux job running

###

Cancer_Type=$1
Task=$2
Data_Directory="/Projects/Users/qgao/Fusion/Gene_expression"
Working_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/06_GeneExpression/"

prefix="gdac.broadinstitute.org_"
prefix2=".Merge_rnaseqv2__illuminahiseq_rnaseqv2__unc_edu__Level_3__RSEM_genes_normalized__data.Level_3.2016012800.0.0"
RSEM_prefix=".rnaseqv2__illuminahiseq_rnaseqv2__unc_edu__Level_3__RSEM_genes_normalized__data.data.txt"
Sample_List="/diskmnt/Projects/Users/qgao/Fusion/Version1/6.FilterRecurrentBreak/${Cancer_Type}.txt"

Genelist="/diskmnt/Projects/Users/wliang/Pancan_Fusion/05_Onco_TSG/${Task}.txt"


Input=$(ls ${Data_Directory}/${prefix}*${Cancer_Type}*${prefix2}/*${Cancer_Type}*${RSEM_prefix})
Num=`cat ${Input}|awk -F "\t" 'END{print NF}'`

##ONCOGENE
mkdir -p ${Working_Directory}/${Task}/${Cancer_Type}/temp 
cd ${Working_Directory}/${Task}/${Cancer_Type}/temp
for i in $(seq ${Num}); do

cat ${Input} | awk -F "\t" 'FNR==1; NR==FNR{a[$1];next}{OFS="\t"; split($1, b, "|");  if (b[1] in a) print $0}' ${Genelist} - | awk -F "\t" 'NR>1{OFS="\t"; split($1, b, "|"); $1=b[1]; print $0}'| awk -F "\t" -v col=${i} -v OFS="\t" 'NR==1{fName=$(col+1)".exp.txt";next} {print $1,$(col+1) > fName}'

done

##Move files to correct folder
while read lines; do
Sample=$(echo $lines | awk -F " " '{print substr($1,1,12)}')
mv ${Sample}*.exp.txt ${Working_Directory}/${Task}/${Cancer_Type}/

done < ${Sample_List}
rm -rf ${Working_Directory}/${Task}/${Cancer_Type}/temp

