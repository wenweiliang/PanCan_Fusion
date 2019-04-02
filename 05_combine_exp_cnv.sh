###
#Date: 2018/2/20
#Author: Wen-Wei Liang @ Wash U (liang.w@wustl.edu)

#Aim: Combine CNV and expression data
#Usage: bash runjobs_by_tmux.sh 05_combine_exp_cnv.sh ${Task} ${Name}
#       ${Task}:The genelist you want to use, ex: Oncogene, TSG, PK, or Tcell
#       ${Name}:Random name to avoid session redundancy during tmux job running

###

Cancer_Type=$1
Task=$2
CNV_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/08_CNV/${Task}"

EXP_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/06_GeneExpression/${Task}"

Working_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/09_Exp_CNV/${Task}"


##ONCOGENE
mkdir -p ${Working_Directory}/${Cancer_Type} 
cd ${Working_Directory}/${Cancer_Type}
for i in `ls ${EXP_Directory}/${Cancer_Type}/*.exp.txt|awk -F "[/.]" '{print $10}'`; do
sample=$(echo ${i} | awk '{print substr($1,1,14)}')

if [ -e ${CNV_Directory}/${sample}*.cnv.txt ]
then
cat ${EXP_Directory}/${Cancer_Type}/${i}.exp.txt | awk -F "\t" 'NR==FNR{a[$1]=$2;next}{OFS="\t"; if ($1 in a) print $0, a[$1]; else print $0, "No_CNV_data"}' ${CNV_Directory}/${sample}*.cnv.txt - > ${Working_Directory}/${Cancer_Type}/${i}.exp.cnv.txt
else
cat ${EXP_Directory}/${Cancer_Type}/${i}.exp.txt | awk -F "\t" '{OFS="\t"; print $0, "NA"}' > ${Working_Directory}/${Cancer_Type}/${i}.exp.cnv.txt
fi
done
