# Script to calculate the sample size cutoff for 90% of the sites of a given counts file.
# Author: Tiago Ribeiro - tiaaagosr@gmail.com

import re

import numpy as np

site_counts = []

pops = ['CO','EA','EF','EG','FR','KF','RG','SD','ZI']
chrm = ['X','2R','3L']

output = open('empirical_pi.csv','w')


for pop in pops:
    for arm in chrm:
        filename = '/Volumes/4_TB_RAID_Set_1/DPGP2plus/wrap1kb/inv_free_counts/AllCounts_'+pop+'_NoInv_Chr'+arm+'.txt'

        site_counts = []
        with open(filename) as counts_file:
            for line in counts_file:
                line = re.split('\t',line[:-1])
                line = list(map(int,line))
                sample_size_full = sum(line)
                site_counts.append(sample_size_full)

        perc_counts = np.array(site_counts)
        cutoff = np.percentile(perc_counts,10)
        cut90 = np.percentile(perc_counts,90)
	site_counts = []

        with open(filename) as counts_file:
	    pi_sum = 0
	    sites_used = 0
            for line in counts_file:
                line = re.split('\t',line[:-1])
                line = list(map(int,line))
                sample_size_full = sum(line)
		if sample_size_full >= cutoff:
		    sites_used += 1
    		    min_max = sorted(range(len(line)), key=lambda k: line[k])
		    minor = line[min_max[2]]
		    major = line[min_max[3]]
                    sample_size = minor + major
                    min_freq =  float(minor)/sample_size
                    maj_freq = 1 - min_freq
		    pi_sum += 2 * maj_freq * min_freq

        outting = []
        outting.append(filename[59:])
	pi = float(pi_sum) / sites_used
        outting.append(str(pi))
        outting.append(str(cutoff))
	outting.append(str(cut90))
        output.write('\t'.join(outting)+'\n') # filename, pi, cutoff10, cutoff90
output.close()
