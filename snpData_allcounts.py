# Script to generate SNP file to be used on dadi
# Author: Tiago Ribeiro - tiaaagosr@gmail.com

import re, sys
from random import sample

pop1 = sys.argv[1] # CO
pop2 = sys.argv[2] # EF
chrm = sys.argv[3] # 3R
n_cutoff1 = sys.argv[4] # cutoff value
n_cutoff2 = sys.argv[5] # cutoff value

site_counts = []

output = open('snpData_'+pop1+'_'+pop2+'.csv','w')

beginning_of_line = "-A-\t-T-\tC\ẗ́"
middle_of_line = "\tG\t"
ending_of_line = "\tabcd1\t"
first_line = 'ref\toutg\tAllele1\tpop1\tpop2\tAllele2\tpop1\tpop2\tGene\tPosition\n'

output.write(first_line)

with open('AllCounts_'+pop1+"_"+pop2+'_Chr'+chrm+'.txt') as two_pops:
    pos_count = 0
    for line in two_pops:
        line1 = line.split()
        line1 = list(map(int,line1))
        line_pop1 = line1[:4]
        line_pop2 = line1[4:]
	combined_alleles = []
	combined_alleles.append(line_pop1[0] + line_pop2[0])
	combined_alleles.append(line_pop1[1] + line_pop2[1])
	combined_alleles.append(line_pop1[2] + line_pop2[2])
	combined_alleles.append(line_pop1[3] + line_pop2[3])
	min_max = sorted(range(len(combined_alleles)), key=lambda k: combined_alleles[k])   
	bi_allele1 = []
        bi_allele1.append(line_pop1[min_max[2]]) # last 2 vectors will be the minor allele and the major allele respectively
	bi_allele1.append(line_pop1[min_max[3]])
	bi_allele2 = []
        bi_allele2.append(line_pop2[min_max[2]]) # last 2 vectors will be the minor allele and the major allele respectively   
        bi_allele2.append(line_pop2[min_max[3]])
        if sum(bi_allele1) >= n_cutoff1 and sum(bi_allele2) >= n_cutoff2: # only analyze sites with minimum sample size
            if float((bi_allele1[0]+bi_allele2[0]))/(n_cutoff1+n_cutoff2) >= 0.01: # downsample as needed
                pos_count += 1
                tmp_line = [0]*bi_allele1[0]+[1]*bi_allele1[1]
                tmp_line = sample(tmp_line, n_cutoff1)
                bi_allele1[0] = sum(tmp_line)
                bi_allele1[1] = n_cutoff1 - bi_allele1[0]
                bi_allele1.sort()

                tmp_line = [0]*bi_allele2[0]+[1]*bi_allele2[1]
                tmp_line = sample(tmp_line, n_cutoff2)
                bi_allele2[0] = sum(tmp_line)
                bi_allele2[1] = n_cutoff2 - bi_allele2[0]
                bi_allele2.sort()

                line_output = beginning_of_line + str(bi_allele1[0]) + "\t" + str(bi_allele2[0]) + middle_of_line + str(bi_allele1[1]) + "\t" + str(bi_allele2[1]) + ending_of_line + "\t" + str(pos_count) + "\n"
                output.write(line_output)
output.close()




