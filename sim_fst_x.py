# Func to calculate FST from simulated data - 2020 summer project with Jose
# Author: Tiago Ribeiro - tiaaagosr@gmail.com

import re

chrm = 'X'
sample_size = [143, 18, 8, 11, 17, 41, 31, 31, 12] # I am hard coding this, but could be obtained from ms command line -I flag
fst_cutoff = 0.5 # modify this if a different cutoff is needed

# This function calculates FST for any two populations, it is called inside the calc_fst_pbs function.
def fst(MinorFreq1, MinorFreq2, SampleSize1, SampleSize2):
#    "The arguments for this functions are: MinorFreqAllele from pop A and B (qA, qB), and the sample size from the respective populations."

    denom = MinorFreq1 + MinorFreq2 - 2 * MinorFreq1 * MinorFreq2
    SharedNum = SampleSize1 * (2 * MinorFreq1 - 2 * MinorFreq1 ** 2) + SampleSize2 * (2 * MinorFreq2 - 2 * MinorFreq2 ** 2)
    NumA = (MinorFreq1 - MinorFreq2) ** 2
    FracNum = (SampleSize1 + SampleSize2) * SharedNum
    FracDen = 4 * SampleSize1 * SampleSize2 * (SampleSize1 + SampleSize2 - 1)
    frac = float(FracNum) / FracDen
    WholeNum = NumA - frac
    DenFracNum = (4 * SampleSize1 * SampleSize2 - SampleSize1 - SampleSize2) * SharedNum
    DenFrac = float(DenFracNum) / FracDen
    WholeDen = NumA + DenFrac

    if WholeDen != 0:
        FST = float(WholeNum) / WholeDen
    else:
        FST = 0

#    if FST >= 0.99:
#        FST = 0.99 # Maximum FST
#    elif FST < 0:
#        FST = 0

    return FST


# Here, I will use the fst function to calculate pair-wise Fst for all the populations.
sim_fst_results = []
sim_counts = 1 # Will store info about which simulation is being computed
total_snps = 0
sim_samples = 1 


    
with open("Chr"+chrm+"_Results.txt") as sim_results:
    print('opening file')
    for line in sim_results:
        line = re.split('\t',line[:-1])
        if len(line[0]) == 0:
            sim_counts += 1
            sim_samples = 1
        elif sim_samples == 1:
            sim_samples = 0
        else:
            line = list(map(int,line))
            total_snps += 1
            for i in range(0,len(sample_size)-1): # will loop through the line calculating pair-wise FST - this loops on the 1st pop in the pair
                j = i + 1
                for k in range(j,len(sample_size)): # this loops on the 2nd pop in the pair
                    n1 = sample_size[i]
                    n2 = sample_size[k]
                    # Checking minor allele:
                    if (line[i] + line[k]) <= ((n1 + n2)-(line[i] + line[k])): # If true, 1 = minor allele
                        minFr1 = float(line[i])/n1
                        minFr2 = float(line[k])/n2
                    else: # 0 is the minor allele
                        minFr1 = float(n1 - line[i])/n1
                        minFr2 = float(n2 - line[k])/n2
                    fst_result = fst(minFr1, minFr2, n1, n2)
                    if fst_result >= fst_cutoff:
                        sim_fst_results.append([sim_counts,i,k,fst_result,minFr1,minFr2,n1,n2]) # Appending: SimulationID, Pop 1, Pop 2, FST, min_freq1, min_freq2, n1, n2

                
# order the output file by pop pair. Additionally, create output file with counts of how many FST are found above a set of different thresholds
ordering_output = []
print('ordering output')
output_fst_counts = open('Chr'+chrm+'_fst_sim_counts.csv','w')
output_fst_counts.write('Total SNPs = '+str(total_snps)+'\n')
output_counts = ['pop1','pop2','count_fst_1','count_fst_above_09','count_fst_above_075','count_fst_above_05']
output_fst_counts.write('\t'.join(output_counts)+'\n')

for i in range(0,len(sample_size)-1):
    j = i + 1
    for k in range(j,len(sample_size)):
        count_fst_1 = 0
        count_fst_above_09 = 0
        count_fst_above_075 = 0
        count_fst_above_05 = 0
        for fst_info in sim_fst_results:
            if fst_info[1] == i and fst_info[2] == k:
                ordering_output.append(fst_info)
                if fst_info[3] == 1:
                    count_fst_1 += 1
                elif fst_info[3] >= 0.9:
                    count_fst_above_09 += 1
                elif fst_info[3] >= 0.75:
                    count_fst_above_075 += 1
                elif fst_info[3] >= 0.5:
                    count_fst_above_05 += 1
        output_counts = [i,k,count_fst_1,count_fst_above_09,count_fst_above_075,count_fst_above_05]
        output_counts = list(map(str,output_counts))
        output_fst_counts.write('\t'.join(output_counts)+'\n')     
output_fst_counts.close()


#output = open('chrX_10sim_fst.csv','w')
#for obs in ordering_output:
#    obs = list(map(str,obs))
#    obs = '\t'.join(obs)+'\n'
#    output.write(obs)
#output.close()
