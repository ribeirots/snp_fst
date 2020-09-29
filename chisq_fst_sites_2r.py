# Script to calculate goodness of fit - chisq for FSTs
# tribeiro@wisc.edu

import re
from scipy.stats import chisquare

chrm = '2r'
CHRM = '2R'
pop_map = ['ZI', 'RG', 'CO', 'EF', 'FR', 'SD', 'KF']
fst_map = ['1.0','0.9','0.75','0.5']

# Reading empirical FST counts
emp_fst_tmp= [] # pop1, pop2, fst-1, fst-09, fst-075, fst-05
with open('results/'+chrm+'_compiled_fst_emp.txt') as emp_fst_data:
    print('results/'+chrm+'_compiled_fst_emp.txt')
    for empfst_line in emp_fst_data:
        empfst_line = empfst_line.split()
        emp_fst_tmp.append(empfst_line)

# replacing pop code with letters
emp_fst = []
for fstemp in emp_fst_tmp:
    pop_code1 = int(fstemp[0])
    pop_code2 = int(fstemp[1])
    pop_letter1 = pop_map[pop_code1]
    pop_letter2 = pop_map[pop_code2]
    fstemp[0] = pop_letter1
    fstemp[1] = pop_letter2
    emp_fst.append(fstemp)

# Reading empirical allele counts
emp_snp = []
with open('results/'+chrm+'_compiled_sites_emp.txt') as sites_emp_data:
    print('results/'+chrm+'_compiled_sites_emp.txt')
    for snpemp_line in sites_emp_data:
        snpemp_line = snpemp_line.split()
        count_appending = []
        if CHRM == snpemp_line[2]:
            pop1 = snpemp_line[0]
            pop2 = snpemp_line[1]
            count_appending.append(int(snpemp_line[3]))
            count_appending.append(pop1)
            count_appending.append(pop2)
            emp_snp.append(count_appending) # Count, Pop1, Pop2

# Reading simulation fst
sim_fst = [] # Pop1, Pop2, fst1, 09, 075, 05
with open('results/Chr'+CHRM+'_fst_sim_counts.csv') as sim_fst_data:
    print('results/Chr'+CHRM+'_fst_sim_counts.csv')
    next(sim_fst_data)
    next(sim_fst_data)
    for simfst_line in sim_fst_data:
        simfst_line = simfst_line.split()
        pop_code1 = int(simfst_line[0])
        pop_code2 = int(simfst_line[1])
        pop_letter1 = pop_map[pop_code1]
        pop_letter2 = pop_map[pop_code2]
        simfst_line[0] = pop_letter1
        simfst_line[1] = pop_letter2
        sim_fst.append(simfst_line)

## Calculate chisq
# Z = FST Category- slide from 1 to 4
output_fst = open('results/fst_comparison_Chr'+CHRM+'.csv','w')
first_line = ['popA', 'popB', 'fst_threshold', 'observed', 'expected', 'chisq', 'p-value']
output_fst.write('\t'.join(first_line)+'\n')

print(('results/fst_comparison_Chr'+CHRM+'.csv'))
for z in range(1,5):
    for i in range(0,len(pop_map)-1):
        for k in range(i+1,len(pop_map)):
            popA = pop_map[i]
            popB = pop_map[k]
            for total_emp_snp in emp_snp:
                if (total_emp_snp[1] == popA and total_emp_snp[2] == popB) or (total_emp_snp[1] == popB and total_emp_snp[2] == popA):
                    t_emp_snp_count = int(total_emp_snp[0])
            # t_emp_snp_count = total observed

            for emp_fst_counts in emp_fst:
                if (emp_fst_counts[0] == popA and emp_fst_counts[1] == popB) or (emp_fst_counts[0] == popB and emp_fst_counts[1] == popA):
                    observed_fsts = list(map(int,emp_fst_counts[2:])) # Fst1, 09, 075, 05
            # observed_fsts = vector of 4 FST counts


            for sim_fst_counts in sim_fst:
                if (sim_fst_counts[0] == popA and sim_fst_counts[1] == popB) or (sim_fst_counts[0] == popB and sim_fst_counts[1] == popA):
                    simulated_fsts = list(map(int,sim_fst_counts[2:])) # Fst1, 09, 075, 05
            # simulated_fsts = vector of 4 FST counts

            sim_ratio = sum(simulated_fsts[:z])/200000000 #ratio of expected FST counts at a given threshold or higher

            if sim_ratio * t_emp_snp_count == 0:
                expected_1 = 0.001
            else:
                expected_1 = sim_ratio * t_emp_snp_count

            if (1-sim_ratio) * t_emp_snp_count == 0:
                expected_2 = 0.001
            else:
                expected_2 = (1-sim_ratio) * t_emp_snp_count

            observed_1 = sum(observed_fsts[:z])
            observed_2 = t_emp_snp_count - observed_1
            summary_fst = []
            summary_fst.append(popA)
            summary_fst.append(popB)
            summary_fst.append(fst_map[z-1])
            summary_fst.append(observed_1)
            summary_fst.append(int(expected_1))
            summary_fst.append(chisquare([observed_1, observed_2], f_exp=[expected_1,expected_2])[0])
            summary_fst.append(chisquare([observed_1, observed_2], f_exp=[expected_1,expected_2])[1])
            ### summary_fst -> PopA, PopB, z(FST Category), Obs, Expect, chisq, p-value
            summary_fst = list(map(str,summary_fst))
            output_fst.write('\t'.join(summary_fst)+'\n')
output_fst.close()
