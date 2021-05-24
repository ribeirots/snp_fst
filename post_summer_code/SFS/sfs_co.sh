#!/bin/bash

## CO-FR
echo 'pasting X'

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_CO_NoInv_Chr2R.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_FR_NoInv_Chr2R.txt | column -s $'\t' -t > AllCounts_CO_FR_Chr2R.txt
python snpData_allcounts.py CO FR 9 38 2R
rm AllCounts_CO_FR_Chr2R.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_CO_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_FR_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_CO_FR_Chr3L.txt
python snpData_allcounts.py CO FR 8 29 3L
rm AllCounts_CO_FR_Chr3L.txt

## CO-EA
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_CO_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EA_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_CO_EA_ChrX.txt
python snpData_allcounts.py CO EA 8 11 X
rm AllCounts_CO_EA_ChrX.txt

## CO-EG
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_CO_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EG_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_CO_EG_ChrX.txt
python snpData_allcounts.py CO EG 8 17 X
rm AllCounts_CO_EG_ChrX.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_CO_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EG_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_CO_EG_Chr3L.txt
python snpData_allcounts.py CO EG 8 5 3L
rm AllCounts_CO_EG_Chr3L.txt

## CO-EF
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_CO_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EF_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_CO_EF_ChrX.txt
python snpData_allcounts.py CO EF 8 31 X
rm AllCounts_CO_EF_ChrX.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_CO_NoInv_Chr2R.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EF_NoInv_Chr2R.txt | column -s $'\t' -t > AllCounts_CO_EF_Chr2R.txt
python snpData_allcounts.py CO EF 9 11 2R
rm AllCounts_CO_EF_Chr2R.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_CO_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_EF_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_CO_EF_Chr3L.txt
python snpData_allcounts.py CO EF 8 10 3L
rm AllCounts_CO_EF_Chr3L.txt

## CO-SD
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_CO_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_SD_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_CO_SD_ChrX.txt
python snpData_allcounts.py CO SD 8 31 X
rm AllCounts_CO_SD_ChrX.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_CO_NoInv_Chr2R.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_SD_NoInv_Chr2R.txt | column -s $'\t' -t > AllCounts_CO_SD_Chr2R.txt
python snpData_allcounts.py CO SD 9 6 2R
rm AllCounts_CO_SD_Chr2R.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_CO_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_SD_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_CO_SD_Chr3L.txt
python snpData_allcounts.py CO SD 8 10 3L
rm AllCounts_CO_SD_Chr3L.txt

## CO-KF
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_CO_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_KF_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_CO_KF_ChrX.txt
python snpData_allcounts.py CO KF 8 12 X
rm AllCounts_CO_KF_ChrX.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_CO_NoInv_Chr2R.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_KF_NoInv_Chr2R.txt | column -s $'\t' -t > AllCounts_CO_KF_Chr2R.txt
python snpData_allcounts.py CO KF 9 26 2R
rm AllCounts_CO_KF_Chr2R.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_CO_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_KF_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_CO_KF_Chr3L.txt
python snpData_allcounts.py CO KF 8 24 3L
rm AllCounts_CO_KF_Chr3L.txt

## SD-KF
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_SD_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_KF_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_SD_KF_ChrX.txt
python snpData_allcounts.py SD KF 31 12 X
rm AllCounts_SD_KF_ChrX.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_SD_NoInv_Chr2R.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_KF_NoInv_Chr2R.txt | column -s $'\t' -t > AllCounts_SD_KF_Chr2R.txt
python snpData_allcounts.py SD KF 6 26 2R
rm AllCounts_SD_KF_Chr2R.txt

paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_SD_NoInv_Chr3L.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_KF_NoInv_Chr3L.txt | column -s $'\t' -t > AllCounts_SD_KF_Chr3L.txt
python snpData_allcounts.py SD KF 10 24 3L
rm AllCounts_SD_KF_Chr3L.txt



