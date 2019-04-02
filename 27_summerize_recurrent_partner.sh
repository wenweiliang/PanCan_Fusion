WD="/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3"
for i in `ls ${WD}/Exclusive/*.exclusive.txt | awk -F "[./]" '{print $9}'`; do 
cat ${WD}/Exclusive/${i}.exclusive.txt | awk -F "\t" 'NR>1' | awk -F "\t" '($3=="NA" && $5=="NA"){OFS="\t"; split($4, b, "--"); print $2, b[1]"\n"$2, b[2]}' > ${WD}/RecurrentPartner/${i}.recurrentgene.txt
done

cat ${WD}/RecurrentPartner/*.recurrentgene.txt | cut -f2 | sort | uniq -c | awk -F " " '$1>1{OFS="\t"; print $2, $1}' | sort -k2,2n -r > ${WD}/RecurrentPartner/recurrent.rm.singleton.acrossCT.txt
cat ${WD}/RecurrentPartner/*.recurrentgene.txt | sort | uniq -c | awk -F " " '$1>1{OFS="\t"; print $2, $3, $1}' | sort -k3,3n -r > ${WD}/RecurrentPartner/recurrent.rm.singleton.in_oneCT.txt

cat ${WD}/RecurrentPartner/recurrent.rm.singleton.in_oneCT.txt | tail -n25 | cut -f2 | sort | uniq > ${WD}/RecurrentPartner/in_oneCT.txt
cat ${WD}/RecurrentPartner/recurrent.rm.singleton.acrossCT.txt | tail -n 20 > ${WD}/RecurrentPartner/acrossCT.txt

cat ${WD}/RecurrentPartner/acrossCT.txt | awk -F "\t" 'NR==FNR{a[$1];next}{OFS="\t"; if ($1 in a) print $1}' - ${WD}/RecurrentPartner/in_oneCT.txt | sort > ${WD}/RecurrentPartner/7B_genelist.txt
cat ${WD}/DriverGeneList/driver.txt | awk -F "\t" 'NR==FNR{a[$1];next}{OFS="\t"; if ($1 in a) next; else print $1}' - ${WD}/RecurrentPartner/7B_genelist.txt > ${WD}/DriverGeneList/Othergene.txt

