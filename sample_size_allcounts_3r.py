# Script to calculate genome-wide sample size.
# Author: Tiago Ribeiro - tiaaagosr@gmail.com

import re

#import numpy as np

pops = ['CO','EA','EF','EG','FR','RG','SD','ZI']
chrm = ['3R']

for pop in pops:
    for arm in chrm:
        filename = '/Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/Chr3R/AllCounts_'+pop+'_Chr'+arm+'.txt'
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
