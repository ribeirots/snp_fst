# Func to calculate DXY from simulated data - 2020 summer project with Jose
# Author: Tiago Ribeiro - tiaaagosr@gmail.com

import re

chrm = 'X'
sample_size = [143, 18, 8, 11, 17, 41, 31, 31, 12] # I am hard coding this, but could be obtained from ms command line -I flag



n_sites = 100 * (2000000-1)

output_dxy_counts = open('chr'+chrm+'_sim_dxy.csv','w')
output_pi_pops = open('chr'+chrm+'_sim_pi.csv','w')
output_pi_header = ['pop1','dxy']
output_pi_pops.write('\t'.join(output_pi_header)+'\n')

output_counts = ['pop1','pop2','dxy']
output_dxy_counts.write('\t'.join(output_counts)+'\n')

pop_i_index = 1
pop_ZI_index = 1
zi_pi_sum = 0
print('opening file')
for i in range(0,len(sample_size)-1):
    j = i + 1
    for k in range(j,len(sample_size)):
        dxy_sum = 0
        sim_samples = 1 

## Calculate dxy
        pi_sum = 0
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
                    if minor_f1 != 0 or minor_f2 != 0:
                        major_f1 = 1 - minor_f1
                        major_f2 = 1 - minor_f2
                        dxy_count = (major_f1 * minor_f2) + (major_f2 * minor_f1)
                        dxy_sum = dxy_sum + dxy_count

## Calculate pi for i
                    if pop_i_index == 1:
                        pi_sum += 2*minor_f2*(1-minor_f2)
                    if pop_ZI_index == 1:
                        zi_pi_sum += 2*minor_f1*(1-minor_f1)                        
	

        output_dxy = [i,k,float(dxy_sum)/n_sites]
        output_dxy = list(map(str,output_dxy))
        output_dxy_counts.write('\t'.join(output_dxy)+'\n')

        if pop_ZI_index == 1:
            pop_ZI_index = 0
            output_pi = [i,float(zi_pi_sum)/n_sites]
            output_pi = list(map(str,output_pi))
            output_pi_pops.write('\t'.join(output_pi)+'\n')
        
        if pop_i_index == 1:
            output_pi = [k,float(pi_sum)/n_sites]
            output_pi = list(map(str,output_pi))
            output_pi_pops.write('\t'.join(output_pi)+'\n')
    pop_i_index = 0
output_dxy_counts.close()
output_pi_pops.close()

