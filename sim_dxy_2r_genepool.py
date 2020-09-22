# Func to calculate DXY from simulated data - 2020 summer project with Jose
# Author: Tiago Ribeiro - tiaaagosr@gmail.com

import re

chrm = '2R'
sample_size = [132, 19, 9, 11, 38, 6, 26] # I am hard coding this, but could be obtained from ms command line -I flag


# Here, I will use the fst function to calculate pair-wise Fst for all the populations.
n_sites = 100 * (2000000-18)

output_dxy_counts = open('chr'+chrm+'_sim_dxy.csv','w')
output_counts = ['pop1','pop2','dxy']
output_dxy_counts.write('\t'.join(output_counts)+'\n')


print('opening file')
for i in range(0,len(sample_size)-1):
    j = i + 1
    for k in range(j,len(sample_size)):
        dxy_sum = 0
        sim_samples = 1 
        with open("Chr"+chrm+"_Results.txt") as sim_results:
            for line in sim_results:
                line = re.split('\t',line[:-1])
                if len(line[0]) == 0:
                    sim_samples = 1
                elif sim_samples == 1:
                    sim_samples = 0
                else:
                    line = list(map(int,line))
                    n1 = sample_size[i]
                    n2 = sample_size[k]
                    if (line[i] + line[k]) <= ((n1 + n2)-(line[i] + line[k])): # If true, 1 = minor allele
                        minor_f1 = float(line[i])/n1
                        minor_f2 = float(line[k])/n2
                    else:
                        minor_f1 = float(n1 - line[i])/n1
                        minor_f2 = float(n2 - line[k])/n2
                    if minor_f1 != 0 and minor_f2 != 0:
                        major_f1 = 1 - minor_f1
                        major_f2 = 1 - minor_f2
                        dxy_count = (major_f1 * minor_f2) + (major_f2 * minor_f1)
                        dxy_sum = dxy_sum + dxy_count
        output_dxy = [i,k,float(dxy_sum)/n_sites]
        output_dxy = list(map(str,output_dxy))
        output_dxy_counts.write('\t'.join(output_dxy)+'\n')

output_dxy_counts.close()

