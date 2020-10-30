# Script to calculate genome-wide sample size.
# Author: Tiago Ribeiro - tiaaagosr@gmail.com

import re

#import numpy as np

site_counts = []

pops = ['CO','EA','EF','EG','FR','KF','RG','SD','ZI']
chrm = ['X','2L','2R','3L','3R']

output = open('empirical_sample_sizee.csv','w')


for pop in pops:
    for arm in chrm:
        filename = '/Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_'+pop+'_NoInv_Chr'+arm+'.txt'
        output = open('samplesize_allcounts_'+pop+'_Chr'+arm+'.csv','w')
        site_counts = []
        with open(filename) as counts_file:
            for line in counts_file:
                line = re.split('\t',line[:-1])
                line = list(map(int,line))
                sample_size_full = sum(line)
                output.write(str(sample_size_full)+'\n')
            output.close()


output.close()        
