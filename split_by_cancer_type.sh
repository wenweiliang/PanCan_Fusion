Driver_List="/diskmnt/Projects/Users/qgao/Fusion/TCGA_Drivers/marker.list"
Cancer_List="/diskmnt/Projects/Users/qgao/Fusion/6.FilterRecurrentBreak/cancer.txt"
Working_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/11_Driver/DriverGeneList"

while read lines; do 

Cancer_Type=$(echo $lines | awk -F " " '{print $1}')
cat ${Driver_List} | awk -F "\t" -v x=${Cancer_Type} '{OFS="\t"; if ($2==x) print $1}' > ${Working_Directory}/${Cancer_Type}.driver.txt

done < ${Cancer_List}
