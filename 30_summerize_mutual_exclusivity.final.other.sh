Cancer_Type=$1
Working_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3/OtherExclusive"
Data_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3/Exclusive"
DriverList="/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3/DriverGeneList/Othergene.txt"
SampleList="/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3/IntersectSampleList/${Cancer_Type}.sample.txt"

echo -e "Sample\tCancer_Type\tMutation\tFusion\tDriverMutation" > ${Working_Directory}/${Cancer_Type}.other.exclusive.txt
while read lines; do 
Driver=$(echo $lines | awk -F " " '{print $1}' )
FusionInDriverGene="/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3/DriverFusion/${Cancer_Type}.${Driver}.fusion.txt"
MutationInDriverGene="/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3/DriverMutation/${Cancer_Type}.${Driver}.txt"
DriverMutation="/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3/DriverMutation/${Cancer_Type}.${Driver}.driver.txt"

cat ${SampleList} | awk -F "\t" -v x=${Cancer_Type} 'NR==FNR{a[$1]=$3;next}{OFS="\t"; if (substr($1,1,12) in a) print substr($1,1,12), x, a[substr($1,1,12)]; else print substr($1,1,12), x, "NA" }' ${MutationInDriverGene} - | awk -F "\t" 'NR==FNR{a[$1]=$4; next}{OFS="\t"; if ($1 in a) print $0, a[$1]; else print $0, "NA" }' ${FusionInDriverGene} - |  awk -F "\t" 'NR==FNR{a[$1]=$3; next}{OFS="\t"; if ($1 in a) print $0, a[$1]; else print $0, "NA" }' ${DriverMutation} - | awk -F "\t" '($1!="Sample" && $3$4$5!="NANANA")' >> ${Working_Directory}/${Cancer_Type}.other.exclusive.txt

done < ${DriverList}

cat ${Data_Directory}/${Cancer_Type}.exclusive.txt | awk -F "\t" 'NR>1' >> ${Working_Directory}/${Cancer_Type}.other.exclusive.txt
