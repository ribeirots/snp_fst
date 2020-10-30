# Func to calculate DXY from simulated data - 2020 summer project with Jose
# Author: Tiago Ribeiro - tiaaagosr@gmail.com

import re

#chrm = 'X'
#sample_size = [10] # I am hard coding this, but could be obtained from ms command line -I flag


sim_samples = 1
n_sites = 1000

output_dxy_counts = open('simple_pi.csv','w')

pi_sum = 0

if 1 == 1:
    if 1 == 1:
## Calculate dxy
        with open("freq_simple_ms.txt") as sim_results:
            for line in sim_results:
                line = line
                if len(line) == 1:
                    sim_samples = 1
                elif sim_samples == 1:
                    sim_samples = 0
                else:
                    line = int(line)
                    n1 = 50
                    if line <= (n1-line): # If true, 1 = minor allele
                        minor_f1 = float(line)/n1
                    else:
                        minor_f1 = float(n1 - line)/n1
                    if minor_f1 != 0:
                        major_f1 = 1 - minor_f1

## Calculate pi for i
                    if 1 == 1:
                        pi_sum += 2*minor_f1*(1-minor_f1)
	
       
        if 1 == 1:
            output_pi = [0,float(pi_sum)/n_sites]
            output_pi = list(map(str,output_pi))
            output_dxy_counts.write('\t'.join(output_pi)+'\n')
output_dxy_counts.close()

