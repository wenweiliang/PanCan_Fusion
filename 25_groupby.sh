i=$1
Data_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3/Exclusive"
Working_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3/Summary"

cat ${Data_Directory}/${i}.exclusive.txt | sort -k1,1 | bedtools groupby -i - -g 1,2 -c 3,4,5 -o collapse,collapse,collapse | sed 's/NA,NA,NA/NA/g' | sed 's/NA,NA/NA/g' | sed 's/,NA//g' | sed 's/NA,//g' | awk -F "\t" '{OFS="\t"; split($4,b,","); if (b[1]==b[2]) print $1, $2, $3, b[1], $5; else print $0}' > ${Working_Directory}/${i}.exclusive.summary.txt
echo -e "Sample\tCancer_Type\tMutationInDriverGene\tFusionInDriverGene\tDriverMutation\tNumberOfMutation\tNumberOfFusion\tNumberOfDriverMutation" > ${Working_Directory}/${i}.exclusive.summary.count.txt
cat ${Working_Directory}/${i}.exclusive.summary.txt | awk -F "\t" 'NR>1' | awk -F "\t" '{if ($3!="NA") {split($3, b, ","); count=length(b)} else count="0" }{OFS="\t";print $0, count}' | awk -F "\t" '{if ($4!="NA") {split($4, b, ","); count=length(b)} else count="0" }{OFS="\t";print $0, count}' | awk -F "\t" '{if ($5!="NA") {split($4, b, ","); count=length(b)} else count="0" }{OFS="\t";print $0, count}' >> ${Working_Directory}/${i}.exclusive.summary.count.txt

