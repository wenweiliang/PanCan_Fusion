bash 00_get_fusion.compile.sh
bash runjobs_by_tmux.sh 01_get_fusion.oncogene_tsg_PK.sh
bash runjobs_by_tmux.sh 02_exp_persample.sh #Independent of callset
bash runjobs_by_tmux.2.sh 03_exp_persample.for_4cancer.sh #Independent of callset
bash runjobs_by_tmux.sh 04_cnv_persample.oncogene.sh oncogene #Independent of callset
bash runjobs_by_tmux.sh 04_cnv_persample.tsg.sh tsg #Independent of callset
bash runjobs_by_tmux.sh 04_cnv_persample.pk.sh pk #Independent of callset
bash runjobs_by_tmux.sh 05_combine_exp_cnv.sh #Independent of callset
bash runjobs_by_tmux.sh 06_intersect_of_MC3_and_fusion_sample.sh
bash runjobs_by_tmux.sh 07_drivermutation.final.sh mutation ##takes a lot of time
bash runjobs_by_tmux.sh 08_get_fusion.driver.final.sh fusion ##takes a lot of time


bash runjobs_by_tmux.sh 09_summerize_mutual_exclusivity.mc3.final.sh
bash runjobs_by_tmux.sh 10_groupby.sh
bash runjobs_by_tmux.sh 11_summerize_mutual_exclusivity.final.bysample.sh
bash 12_summerize_recurrent_partner.sh
bash runjobs_by_tmux.sh 13_drivermutation.other.sh
bash runjobs_by_tmux.sh 14_get_fusion.driver.other.sh
bash runjobs_by_tmux.sh 15_summerize_mutual_exclusivity.final.other.sh

#`/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3/Final` for figure 5A
#`/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3/OtherExclusive/*.other.exclusive.txt` for figure 5C
#`/diskmnt/Projects/Users/wliang/Pancan_Fusion/20_Driver3/RecurrentPartner/7B_genelist.txt` the gene i want to show in figure 5C

bash 16_get_breakpoint.sh #For validation
