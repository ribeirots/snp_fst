#script to calculate coverage from allcounts

import re

pop = 'SD'
chrms = ["3R"]

for i in chrms:
    filename = "AllCounts_"+pop+"_NoInv_Chr"+i
    print(filename)
    output = open(filename+"_cov.csv","w")

    with open(filename+".txt") as counts:
        for line in counts:
            line2 = re.split('\t',line[:-1])
            line2 = list(map(int,line2))
            output.write(str(sum(line2))+"\n")
    output.close()
            
            
        
