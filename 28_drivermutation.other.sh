Cancer_Type=$1
Driver_list="/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3/DriverGeneList/Othergene.txt"
MAF="/diskmnt/Datasets/TCGA/MC3/mc3.v0.2.8.PUBLIC.maf"
Working_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3/DriverMutation"
Sample_list="/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3/IntersectSampleList/${Cancer_Type}.sample.txt"

cat ${MAF} | awk -F "\t" 'NR>1{OFS="\t"; if ($9=="Frame_Shift_Del" || $9=="Frame_Shift_Ins" || $9=="In_Frame_Del" || $9=="In_Frame_Ins" || $9=="Missense_Mutation" || $9=="Nonsense_Mutation" || $9=="Nonstop_Mutation" || $9=="Splice_Site" || $9=="Translation_Start_Site") print $0}' | awk -F "\t" 'NR==FNR{a[$1];next}{if (substr($16,1,14) in a) print $0}' ${Sample_list} - | awk -F "\t" 'NR==FNR{a[$1$3]=$60;next}{OFS="\t";if ($1$37 in a) print $1, $9, $16, a[$1$37]; else print $1, $9, $16, "NA"}' /diskmnt/Software/LabCode/aweerasi/PANCAN_newFilteredMaf_DriverPaper/PANCAN_newMAF/Data/score_results_3Dtools_V9_10182017.txt  - > ${Working_Directory}/psudoMAF.${Cancer_Type}.temp

while read lines; do
Driver=$(echo $lines| awk -F " " '{print $1}')
echo -e "Sample\tCancer_Type\tDriverMutation" > ${Working_Directory}/${Cancer_Type}.${Driver}.txt
echo -e "Sample\tCancer_Type\tDriverMutation" > ${Working_Directory}/${Cancer_Type}.${Driver}.driver.txt

cat ${Working_Directory}/psudoMAF.${Cancer_Type}.temp | awk -F "\t" -v x=${Driver} -v y=${Cancer_Type} '{OFS="\t"; if ($1==x && $4 != "1") print substr($3, 1, 12), y, $1}' | sort | uniq >> ${Working_Directory}/${Cancer_Type}.${Driver}.txt

cat ${Working_Directory}/psudoMAF.${Cancer_Type}.temp | awk -F "\t" -v x=${Driver} -v y=${Cancer_Type} '{OFS="\t"; if ($1==x && $4 == "1") print substr($3, 1, 12), y, $1}' | sort | uniq >> ${Working_Directory}/${Cancer_Type}.${Driver}.driver.txt

done < ${Driver_list}


rm ${Working_Directory}/psudoMAF.${Cancer_Type}.temp
