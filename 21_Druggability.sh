###
#Format the output as: "CancerType" "SampleID" "Fusion" "DrugTarget" "CancerType_from_DEPO" "Label"
###


Cancer_Type=$1
Gene_List="/diskmnt/Projects/Users/wliang/Pancan_Fusion/13_Drugability/GeneList/${Cancer_Type}.DEPO.gene.txt"
Fusion_List="/diskmnt/Projects/Users/wliang/Pancan_Fusion/13_Drugability/GeneList/${Cancer_Type}.DEPO.fusion.txt"
Working_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/13_Drugability/DEPOintersect2"
Fusion_Call="/diskmnt/Projects/Users/wliang/Pancan_Fusion/allfusion.compile.txt"
AlltargetGene="/diskmnt/Projects/Users/wliang/Pancan_Fusion/13_Drugability/GeneList/AllDEPOtarget.gene.txt"
AlltargetFusion="/diskmnt/Projects/Users/wliang/Pancan_Fusion/13_Drugability/GeneList/AllDEPOtarget.fusion.txt"

echo -e "CancerType\tSampleID\tFusion\tLeftGene\tRightGene\tDrugTarget\tCancerType_from_DEPO\tLabel" > ${Working_Directory}/${Cancer_Type}.DEPO.intersect.txt

cat ${Fusion_Call} | awk -F "\t" -v x=${Cancer_Type} '{OFS="\t"; split($3,b,"--"); if ($1==x) print $0, b[1], b[2]}' | awk -F "\t" 'NR==FNR{a[$1]=$2;next}{OFS="\t"; if ($5 in a) print $0, $5, a[$5]; else if ($6 in a) print $0, $6, a[$6]}' ${AlltargetGene} - | awk -F "\t" 'NR==FNR{a[$1]; next}{OFS="\t"; if ($5 in a || $6 in a) print $0, "OnLabel"; else print $0, "OffLabel" }' ${Gene_List} - | sort | uniq >> ${Working_Directory}/${Cancer_Type}.DEPO.intersect.txt
cat ${Fusion_Call} | awk -F "\t" -v x=${Cancer_Type} '{OFS="\t"; split($3,b,"--"); if ($1==x) print $0, b[1], b[2]}' | awk -F "\t" 'NR==FNR{a[$1]=$2;next}{OFS="\t"; if ($3 in a) print $0, $3, a[$3]}' ${AlltargetFusion} - | awk -F "\t" 'NR==FNR{a[$1]; next}{OFS="\t"; if ($3 in a) print $0, "OnLabel"; else print $0, "OffLabel"}' ${Fusion_List} - | sort | uniq >> ${Working_Directory}/${Cancer_Type}.DEPO.intersect.txt
