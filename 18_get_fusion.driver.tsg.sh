####
#Aim: Generate the input for Steven's supplementary figure
#Usage: bash runjobs_by_tmux.sh 18_get_fusion.driver.tsg.sh
#Authour: Wen-Wen Liang @ Wash U (liang.w@wustl.edu)
####


Cancer_Type=$1
Data_Directory="/Projects/Users/qgao/Fusion/FinalCalls"
Working_Directory="/diskmnt/Projects/Users/wliang/Pancan_Fusion/18_TSG/DriverFusion"
Driver_list="/diskmnt/Projects/Users/wliang/Pancan_Fusion/05_Onco_TSG/tsg.txt"
FinalList="/Projects/Users/qgao/Fusion/allfusion.compile.info.txt"

while read lines; do 
Driver=$(echo $lines | awk -F " " '{print $1}')

echo -e "Sample\tCancer_Type\tDriver\tDriverFusion" > ${Working_Directory}/${Cancer_Type}.${Driver}.fusion.txt


cat ${FinalList} | awk -F "\t" -v y=${Cancer_Type} '$1==y' | awk -F "\t" -v z=${Driver} '{OFS="\t"; split($3, b, "--"); if (b[1]==z || b[2]==z) print substr($2,1,12), $1, z, $3}' | sort | uniq >> ${Working_Directory}/${Cancer_Type}.${Driver}.fusion.txt


done < ${Driver_list}
