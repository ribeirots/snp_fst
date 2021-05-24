# generate window delimited fst - window-wide and snp
# tribeiro@wisc.edu

import re

#pops = ['KF','EF','FRht','RG','SD','ZI']
pops = ['SD','ZI']
#chrm = ['X','2R','2L','3R','3L']
chrm = ['3R']
for arm in chrm:

    wintracks = []
    with open('/media/tiago/Seagate Portable Drive/fas1k/window_summary/windows_ZI250_Chr'+arm+'.txt') as windows:
        for w in windows:
            line = w[:-1]
            line = re.split('\t',line)
            line[0] = int(line[0])
            line[1] = int(line[1])
    #        line[2] = int(line[2])
            wintracks.append(line) 
    
    for p1 in range(0,len(pops)-1):
        pop1 = pops[p1]
        print('Pop1: '+pop1)
        for p2 in range(p1+1,len(pops)):
            pop2 = pops[p2]
            print(pop2)
            output = open("window_"+pop1+"_"+pop2+"_Chr"+arm+"_summary2.csv","w")
            output.write('Start\tEnd\tWindowFST\tMaxSNPFST\tMaxSNP_Position\n')

            win_index = 0
            numSum = 0
            denSum = 0
            max_fst = -999
            max_fst_pos = 0
            
            with open('empirical_snp_fst_'+pop1+'_'+pop2+'_NoInv_Chr'+arm+'downsampled2.txt') as fstinput:
                next(fstinput)
                for f in fstinput:
                    fst_info = f[:-1]
                    fst_info = re.split('\t',fst_info)
                    fst_info[0] = int(fst_info[0]) # pos
                    fst_info[1] = float(fst_info[1]) # snp fst
                    fst_info[2] = float(fst_info[2]) # whole num
                    fst_info[3] = float(fst_info[3]) # whole dem
                    if fst_info[0] <= wintracks[win_index][1]:
                        numSum += fst_info[2]
                        denSum +=  fst_info[3]
                        if fst_info[1] > max_fst:
                            max_fst = fst_info[1]
                            max_fst_pos = fst_info[0]
                    else:
                        if denSum > 0:
                            win_fst = numSum/denSum
                        else:
                            win_fst = 0
                        snp_fst = max_fst
                        start = wintracks[win_index][0]
                        end = wintracks[win_index][1]
                        new_line = [str(start), str(end), str(win_fst), str(max_fst), str(max_fst_pos)]
                        if max_fst == -999:
                            new_line = [str(start), str(end), 'NA', 'NA', 'NA']
                        output.write("\t".join(new_line)+"\n")
                        win_index += 1
                        win_cycle = 1
                        while win_cycle == 1:
                            if fst_info[0] > wintracks[win_index][1]:
                                start = wintracks[win_index][0]
                                end = wintracks[win_index][1]
                                new_line = [str(start), str(end), 'NA', 'NA', 'NA']
                                output.write("\t".join(new_line)+"\n")                    
                                win_index += 1
                            else:
                                win_cycle = 0
                                numSum = fst_info[2]
                                denSum = fst_info[3]
                                max_fst = fst_info[1]
                                max_fst_pos = fst_info[0]
                
                if win_cycle == 0:
                    if denSum > 0:
                        win_fst = numSum/denSum
                    else:   
                        win_fst = 0
                    snp_fst = max_fst
                    start = wintracks[win_index][0]
                    end = wintracks[win_index][1]
                    new_line = [str(start), str(end), str(win_fst), str(max_fst), str(max_fst_pos)]
                    output.write("\t".join(new_line)+"\n")
                else:
                    print('Last SNP beyond last window. Error?')

                output.close()
            
        
