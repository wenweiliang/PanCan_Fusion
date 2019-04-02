Data_Directory="/Projects/Users/qgao/Fusion/FinalCalls"
Working_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/19_Validataion_2ndSubmission"
LowBAMPath="/diskmnt/Projects/Users/wliang/Pancan_Fusion/19_Validataion_2ndSubmission/LowPass_WGS_path.txt"
HighBAMPath="/diskmnt/Projects/Users/wliang/Pancan_Fusion/19_Validataion_2ndSubmission/HighPass_WGS_path.txt"

echo -e "Index\tLeftGene\tRightGene\tSample\tCancerType\tRightBreakpoint\tLeftBreakpoint\tKey\tBAMPath\tJunctionReadCount\tSpanningFragCount\tFile" > ${Working_Directory}/allfusion.LowPassBAM.txt

echo -e "Index\tLeftGene\tRightGene\tSample\tCancerType\tRightBreakpoint\tLeftBreakpoint\tKey\tBAMPath\tJunctionReadCount\tSpanningFragCount\tFile" > ${Working_Directory}/allfusion.HighPassBAM.txt

while read lines; do 
Cancer_Type=$(echo $lines|awk -F " " '{print $1}')

cd ${Data_Directory}/${Cancer_Type}
for i in `ls TCGA*.star-fusion.fusion_predictions.abridged.annotated.coding_effect.tsv`; 

do 
Sample=$(echo ${i} | awk -F "." '{print $1}')
echo ${Sample} ${i}
cat ${Data_Directory}/${Cancer_Type}/${i} | awk -F "\t" 'NR>1' | awk -F "\t" -v x=${Sample} -v y=${Cancer_Type} '{OFS="\t";split($1, b, "--"); split($6, c, ":"); split($8, d, ":");print b[1], b[2], substr(x,1,14), y, c[1]":"c[2], d[1]":"d[2], $1"--"substr(x,1,14), $2, $3}' | awk -F "\t" 'NR==FNR{a[$20]=$14; next}{OFS="\t"; if ($3 in a) print $0, a[$3]; else print $0, "No_WGS_BAM"}' ${LowBAMPath} - >> ${Working_Directory}/lowtemp

cat ${Data_Directory}/${Cancer_Type}/${i} | awk -F "\t" 'NR>1' | awk -F "\t" -v x=${Sample} -v y=${Cancer_Type} '{OFS="\t";split($1, b, "--"); split($6, c, ":"); split($8, d, ":");print b[1], b[2], substr(x,1,14), y, c[1]":"c[2], d[1]":"d[2], $1"--"substr(x,1,14), $2, $3}' | awk -F "\t" 'NR==FNR{a[$20]=$14; next}{OFS="\t"; if ($3 in a) print $0, a[$3]; else print $0, "No_WGS_BAM"}' ${HighBAMPath} - >> ${Working_Directory}/hightemp

done
done < /diskmnt/Projects/Users/wliang/Pancan_Fusion/cancer.txt

cat ${Working_Directory}/lowtemp |  awk -F "\t" '{OFS="\t"; print NR, $0, "samtool_"NR".yaml"}' >> ${Working_Directory}/allfusion.LowPassBAM.txt;
rm ${Working_Directory}/lowtemp
cat ${Working_Directory}/hightemp |  awk -F "\t" '{OFS="\t"; print NR, $0, "samtool_"NR".yaml"}' >> ${Working_Directory}/allfusion.HighPassBAM.txt;
rm ${Working_Directory}/hightemp
