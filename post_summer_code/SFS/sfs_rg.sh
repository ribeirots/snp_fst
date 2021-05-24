#!/bin/bash

## RG-CO
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_RG_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_CO_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_RG_CO_ChrX.txt
python snpData_allcounts.py RG CO 18 8 X
rm AllCounts_RG_CO_ChrX.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_RG_NoInv_Chr2R.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_CO_NoInv_Chr2R.txt | column -s $'\t' -t > AllCounts_RG_CO_Chr2R.txt
python snpData_allcounts.py RG CO 19 9 2R
rm AllCounts_RG_CO_Chr2R.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_RG_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_CO_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_RG_CO_Chr3L.txt
python snpData_allcounts.py RG CO 22 8 3L
rm AllCounts_RG_CO_Chr3L.txt

## RG-EA
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_RG_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EA_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_RG_EA_ChrX.txt
python snpData_allcounts.py RG EA 18 11 X
rm AllCounts_RG_EA_ChrX.txt

## RG-EG
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_RG_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EG_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_RG_EG_ChrX.txt
python snpData_allcounts.py RG EG 18 17 X
rm AllCounts_RG_EG_ChrX.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_RG_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EG_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_RG_EG_Chr3L.txt
python snpData_allcounts.py RG EG 22 5 3L
rm AllCounts_RG_EG_Chr3L.txt

## RG-FR
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_RG_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_FR_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_RG_FR_ChrX.txt
python snpData_allcounts.py RG FR 18 41 X
rm AllCounts_RG_FR_ChrX.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_RG_NoInv_Chr2R.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_FR_NoInv_Chr2R.txt | column -s $'\t' -t > AllCounts_RG_Fr_Chr2R.txt
python snpData_allcounts.py RG FR 19 38 2R
rm AllCounts_RG_FR_Chr2R.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_RG_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_FR_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_RG_FR_Chr3L.txt
python snpData_allcounts.py RG FR 22 29 3L
rm AllCounts_RG_FR_Chr3L.txt

## RG-EF
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_RG_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EF_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_RG_EF_ChrX.txt
python snpData_allcounts.py RG EF 18 31 X
rm AllCounts_RG_EF_ChrX.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_RG_NoInv_Chr2R.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EF_NoInv_Chr2R.txt | column -s $'\t' -t > AllCounts_RG_EF_Chr2R.txt
python snpData_allcounts.py RG EF 19 11 2R
rm AllCounts_RG_EF_Chr2R.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_RG_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EF_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_RG_EF_Chr3L.txt
python snpData_allcounts.py RG EF 22 10 3L
rm AllCounts_RG_EF_Chr3L.txt

## RG-SD
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_RG_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_SD_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_RG_SD_ChrX.txt
python snpData_allcounts.py RG SD 18 31 X
rm AllCounts_RG_SD_ChrX.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_RG_NoInv_Chr2R.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_SD_NoInv_Chr2R.txt | column -s $'\t' -t > AllCounts_RG_SD_Chr2R.txt
python snpData_allcounts.py RG SD 19 6 2R
rm AllCounts_RG_SD_Chr2R.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_RG_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_SD_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_RG_SD_Chr3L.txt
python snpData_allcounts.py RG SD 22 10 3L
rm AllCounts_RG_SD_Chr3L.txt

## RG-KF
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_RG_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_KF_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_RG_KF_ChrX.txt
python snpData_allcounts.py RG KF 18 12 X
rm AllCounts_RG_KF_ChrX.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_RG_NoInv_Chr2R.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_KF_NoInv_Chr2R.txt | column -s $'\t' -t > AllCounts_RG_KF_Chr2R.txt
python snpData_allcounts.py RG KF 19 26 2R
rm AllCounts_RG_KF_Chr2R.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_RG_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_KF_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_RG_KF_Chr3L.txt
python snpData_allcounts.py RG KF 22 24 3L
rm AllCounts_RG_KF_Chr3L.txt
