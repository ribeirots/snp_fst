# Func to generate snpData for later dadi SFS for simulated data
# Author: Tiago Ribeiro - tiaaagosr@gmail.com

import re

chrm = 'X'
sample_size = [143, 18, 8, 11, 17, 41, 31, 31, 12] # I am hard coding this, but could be obtained from ms command line -I flag


beginning_of_line = "-A-\t-T-\tC\ẗ́"
middle_of_line = "\tG\t"
ending_of_line = "\tabcd1\t"
first_line = 'ref\toutg\tAllele1\tpop1\tpop2\tAllele2\tpop1\tpop2\tGene\tPosition\n'
            
for i in range(0,len(sample_size)-1): # this loops on the 1st pop in the pair
    j = i + 1
    for k in range(j,len(sample_size)): # this loops on the 2nd pop in the pair
        n1 = sample_size[i]
        n2 = sample_size[k]
        pos_count = 0
        sim_samples = 1 
        # Opening file to read 1st pair
        with open("../Chr"+chrm+"_Results.txt") as sim_results:
            output = open('snpData_sim_'+str(i)+'_'+str(k)+'_Chr'+chrm+'.txt','w')
            output.write(first_line)
            for line in sim_results:
                line = re.split('\t',line[:-1])
                if len(line[0]) == 0:
                    sim_samples = 1
                elif sim_samples == 1:
                    sim_samples = 0
                else:
                    # Checking if SNP:
                    if line[i] != 0 or line[k] != 0:
                        pos_count += 1
                        line = list(map(int,line))
                        line_output = beginning_of_line + str(line[i]) + "\t" + str(line[k]) + middle_of_line + str(n1 - line[i]) + "\t" + str(n2 - line[k]) + ending_of_line + "\t" + str(pos_count) + "\n"
                        output.write(line_output)
            output.close()


