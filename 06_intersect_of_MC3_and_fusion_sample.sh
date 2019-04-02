####
#Aim: Find out the sample overlap between MC3 MAF and Fusion calls
#Usage: bash runjobs_by_tmux.sh 06_intersect_of_MC3_and_fusion_sample.sh
#Author: Wen-Wen Liang @ Wash U (liang.w@wustl.edu)
####

Cancer_Type=$1
Working_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3/IntersectSampleList/"
SampleList="/diskmnt/Projects/Users/qgao/Fusion/FinalCalls/${Cancer_Type}.txt"
MC3="/diskmnt/Datasets/TCGA/MC3/mc3.v0.2.8.PUBLIC.PASSorWGA_only.maf"
MC3output="/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3/IntersectSampleList/MC3SampleList.txt"

#cat ${MC3} | cut -f16 | sort | uniq | awk -F "\t" '{print (substr($1,1,15))}' > ${MC3output}

cat ${SampleList} | awk -F "\t" '{OFS="\t"; print substr($1, 1, 15)}' | awk -F "\t" 'NR==FNR{a[$1];next}{OFS="\t"; if ($1 in a) print substr($1, 1, 14), $1}' - ${MC3output} > ${Working_Directory}/${Cancer_Type}.sample.txt
