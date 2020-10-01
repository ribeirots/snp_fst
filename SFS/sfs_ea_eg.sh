#!/bin/bash

## EA
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EA_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EF_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_EA_EF_ChrX.txt
python snpData_allcounts.py EA EF 11 31 X
rm AllCounts_EA_EF_ChrX.txt

echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EA_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EG_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_EA_EG_ChrX.txt
python snpData_allcounts.py EA EG 11 17 X
rm AllCounts_EA_EG_ChrX.txt

echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EA_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_FR_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_EA_FR_ChrX.txt
python snpData_allcounts.py EA FR 11 41 X
rm AllCounts_EA_FR_ChrX.txt

echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EA_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_KF_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_EA_KF_ChrX.txt
python snpData_allcounts.py EA KF 11 12 X
rm AllCounts_EA_KF_ChrX.txt

echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EA_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_SD_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_EA_SD_ChrX.txt
python snpData_allcounts.py EA SD 11 31 X
rm AllCounts_EA_SD_ChrX.txt

# EG - EF
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EG_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EF_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_EG_EF_ChrX.txt
python snpData_allcounts.py EG EF 17 31 X
rm AllCounts_EG_EF_ChrX.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EF_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EG_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_EF_EG_Chr3L.txt
python snpData_allcounts.py EG EF 5 10 3L
rm AllCounts_EF_EG_Chr3L.txt

# EG FR
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EG_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_FR_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_EG_FR_ChrX.txt
python snpData_allcounts.py EG FR 17 41 X
rm AllCounts_EG_FR_ChrX.txt

echo 'pasting 3L'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EG_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_FR_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_EG_FR_Chr3L.txt
python snpData_allcounts.py EG FR 5 29 3L
rm AllCounts_EG_FR_Chr3L.txt

echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EG_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_KF_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_EG_KF_ChrX.txt
python snpData_allcounts.py EG KF 17 12 X
rm AllCounts_EG_KF_ChrX.txt

echo 'pasting 3L'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EG_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_KF_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_EG_KF_Chr3L.txt
python snpData_allcounts.py EG KF 5 24 3L
rm AllCounts_EG_kF_Chr3L.txt

echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EG_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_SD_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_EG_SD_ChrX.txt
python snpData_allcounts.py EG SD 17 31 X
rm AllCounts_EG_SD_ChrX.txt

echo 'pasting 3L'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EG_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_SD_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_EG_SD_Chr3L.txt
python snpData_allcounts.py EG SD 5 10 3L
rm AllCounts_EG_SD_Chr3L.txt








