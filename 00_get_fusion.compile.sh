####
#Aim: Get fusion calls from qgao and compile a full list
#Usage: bash 00_get_fusion.compile.sh
#Author: Wen-Wen Liang @ Wash U (liang.w@wustl.edu)
####


Data_Directory="/Projects/Users/qgao/Fusion/FinalCalls"
Working_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/"
FinalList="/Projects/Users/qgao/Fusion/allfusion.compile.info.txt"

echo -e "Cancer_Type\tCase\tFusion\tBarcode" > ${Working_Directory}/allfusion.compile.txt

while read lines; do 
Cancer_Type=$(echo $lines|awk -F " " '{print $1}')

cd ${Data_Directory}/${Cancer_Type}
for i in `ls TCGA*.star-fusion.fusion_predictions.abridged.annotated.coding_effect.tsv`; 

do 
Sample=$(echo ${i} | awk -F "." '{print $1}')
echo ${Sample} ${i}
cat ${Data_Directory}/${Cancer_Type}/${i} | awk -F "\t" 'NR>1' | awk -F "\t" -v x=${Sample} -v y=${Cancer_Type} '{OFS="\t"; print y, substr(x,1,14), $1, x}' | awk -F "\t" 'NR==FNR{a[$1$2$3];next}{OFS="\t"; if ($1$4$3 in a) print $0}' ${FinalList} - >> ${Working_Directory}/allfusion.compile.txt;
done
done < ${Working_Directory}/cancer.txt
