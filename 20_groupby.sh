i=$1
Data_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/18_TSG/Exclusive"
Working_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/18_TSG/Summary"

cat ${Data_Directory}/${i}.exclusive.txt | sort -k1,1 | bedtools groupby -i - -g 1,2 -c 3,4 -o collapse,collapse | sed 's/NA,NA,NA/NA/g' | sed 's/NA,NA/NA/g' | sed 's/,NA//g' | sed 's/NA,//g' > ${Working_Directory}/${i}.exclusive.summary.txt
echo -e "Sample\tCancer_Type\tDriverMutation\tDriverFusion\tNumberOfMutation\tNumberOfFusion" > ${Working_Directory}/${i}.exclusive.summary.count.txt
cat ${Working_Directory}/${i}.exclusive.summary.txt | awk -F "\t" 'NR>1' | awk -F "\t" '{if ($3!="NA") {split($3, b, ","); count=length(b)} else count="0" }{OFS="\t";print $0, count}' | awk -F "\t" '{if ($4!="NA") {split($4, b, ","); count=length(b)} else count="0" }{OFS="\t";print $0, count}' >> ${Working_Directory}/${i}.exclusive.summary.count.txt

