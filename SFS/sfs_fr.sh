#!/bin/bash

## FR-EF
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_FR_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EF_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_FR_EF_ChrX.txt
python snpData_allcounts.py FR EF 41 31 X
rm AllCounts_FR_EF_ChrX.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EF_NoInv_Chr2R.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_FR_NoInv_Chr2R.txt | column -s $'\t' -t > AllCounts_EF_FR_Chr2R.txt
python snpData_allcounts.py EF FR 11 38 2R
rm AllCounts_EF_FR_Chr2R.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EF_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_FR_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_EF_FR_Chr3L.txt
python snpData_allcounts.py EF FR 10 29 3L
rm AllCounts_EF_FR_Chr3L.txt

## FR-SD
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_FR_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_SD_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_FR_SD_ChrX.txt
python snpData_allcounts.py FR SD 41 31 X
rm AllCounts_FR_SD_ChrX.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_FR_NoInv_Chr2R.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_SD_NoInv_Chr2R.txt | column -s $'\t' -t > AllCounts_FR_SD_Chr2R.txt
python snpData_allcounts.py FR SD 38 6 2R
rm AllCounts_FR_SD_Chr2R.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_FR_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_SD_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_FR_SD_Chr3L.txt
python snpData_allcounts.py FR SD 29 10 3L
rm AllCounts_FR_SD_Chr3L.txt


## FR-KF
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_FR_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_KF_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_FR_KF_ChrX.txt
python snpData_allcounts.py FR KF 41 12 X
rm AllCounts_FR_KF_ChrX.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_FR_NoInv_Chr2R.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_KF_NoInv_Chr2R.txt | column -s $'\t' -t > AllCounts_FR_KF_Chr2R.txt
python snpData_allcounts.py FR KF 38 26 2R
rm AllCounts_FR_KF_Chr2R.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_FR_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_KF_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_FR_KF_Chr3L.txt
python snpData_allcounts.py FR KF 29 24 3L
rm AllCounts_FR_KF_Chr3L.txt


## EF-SD
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EF_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_SD_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_EF_SD_ChrX.txt
python snpData_allcounts.py EF SD 31 31 X
rm AllCounts_EF_SD_ChrX.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EF_NoInv_Chr2R.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_SD_NoInv_Chr2R.txt | column -s $'\t' -t > AllCounts_EF_SD_Chr2R.txt
python snpData_allcounts.py EF SD 11 6 2R
rm AllCounts_EF_SD_Chr2R.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EF_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_SD_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_EF_SD_Chr3L.txt
python snpData_allcounts.py EF SD 10 10 3L
rm AllCounts_EF_SD_Chr3L.txt

## EF-KF
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EF_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_KF_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_EF_KF_ChrX.txt
python snpData_allcounts.py EF KF 31 12 X
rm AllCounts_EF_KF_ChrX.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EF_NoInv_Chr2R.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_KF_NoInv_Chr2R.txt | column -s $'\t' -t > AllCounts_EF_KF_Chr2R.txt
python snpData_allcounts.py EF KF 11 26 2R
rm AllCounts_EF_KF_Chr2R.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EF_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_KF_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_EF_KF_Chr3L.txt
python snpData_allcounts.py EF KF 10 24 3L
rm AllCounts_EF_KF_Chr3L.txt
