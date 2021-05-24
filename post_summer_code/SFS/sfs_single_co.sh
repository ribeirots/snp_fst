#!/bin/bash

## CO-FR
echo 'pasting X'
paste /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_CO_NoInv_ChrX.txt /Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_FR_NoInv_ChrX.txt | column -s $'\t' -t > AllCounts_CO_FR_ChrX.txt
python snpData_allcounts.py CO FR 8 41 X
rm AllCounts_CO_FR_ChrX.txt
