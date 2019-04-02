Cancer_Type=$1
Working_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/18_TSG/Exclusive"
DriverList="/diskmnt/Projects/Users/wliang/Pancan_Fusion/05_Onco_TSG/tsg.txt"
SampleList="/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3/IntersectSampleList/${Cancer_Type}.sample.txt"

echo -e "Sample\tCancer_Type\tDriverMutation\tDriverFusion" > ${Working_Directory}/${Cancer_Type}.exclusive.txt
while read lines; do 
Driver=$(echo $lines | awk -F " " '{print $1}' )
DriverFusion="/diskmnt/Projects/Users/wliang/Pancan_Fusion/18_TSG/DriverFusion/${Cancer_Type}.${Driver}.fusion.txt"
DriverMutation="/diskmnt/Projects/Users/wliang/Pancan_Fusion/18_TSG/DriverMutation/${Cancer_Type}.${Driver}.txt"

cat ${SampleList} | awk -F "\t" -v x=${Cancer_Type} 'NR==FNR{a[$1]=$3;next}{OFS="\t"; if (substr($1,1,12) in a) print substr($1,1,12), x, a[substr($1,1,12)]; else print substr($1,1,12), x, "NA" }' ${DriverMutation} - | awk -F "\t" 'NR==FNR{a[$1]=$4; next}{OFS="\t"; if ($1 in a) print $0, a[$1]; else print $0, "NA" }' ${DriverFusion} - | awk -F "\t" '($1!="Sample" && $3!=$4)' >> ${Working_Directory}/${Cancer_Type}.exclusive.txt

done < ${DriverList}

