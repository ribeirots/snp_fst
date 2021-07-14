# generate msms simulation commands based on empirical window length and recombination
# output bash file to be ran on CHTC
# tribeiro@wisc.edu March2021

# argument 1 = id for the current bash file being generated.
# argument 2 = how many jobs will be submitted. # of simulations per job is given by the script below.
# argument 3 = simulations per job

import random, sys

# Write here the name of the model being simulated: North 2R

n_pops = 6
# Ne values for SA and NA models
# Southern Extension, X: 661372.5, 2R: 826813, 3L: 597868.
# Northern Extension: X: 618139, 2R: 823306.5, 3L: 827211.
Ne = 823306.5
ploidy = 4 # change to 3 for X. change to 4 for autosomes.
n_simulations = int(sys.argv[3]) # use 1000 on chtc
r_rate = sys.argv[4]
geneconversion = 6.25e-8
geneconv_tractlength = 518
perbase_theta = 0.0078 # 3L: 0.0077, X* = 0.0069, 2R = 0.0078 - *X for FR model.

recrate = []
if ploidy == 4:
    with open('../../recrate'+r_rate+'_auto_lengths.txt') as recwindows:
        next(recwindows)
        for recraterow in recwindows:
            recraterow = recraterow.split() # Arm, Start, End, Length, c
            rec_l = recraterow[3:]
            
            rec_l[0] = int(rec_l[0]) # len
            rec_l[1] = float(rec_l[1]) # c cM/MB. c = 100 -> 1 Morgan/megabase, 1 crossing-over expected every 1mb
            rec_l.append(rec_l[1]/100000000) # 100000000 -> divide by 100 to convert cM to M. Divide by 1m to convert from Comeron's scale (1MB) to per base.
            rec_l[1] = rec_l[2]*rec_l[0]*Ne*ploidy # multiply by 4N to obtain the population-scaled metric, multiply by rec_l[0] (length) to obtain the locus value
            if rec_l[1] == 0:
                rec_l[2] = ploidy * Ne * geneconversion
            recrate.append(rec_l)
else:
    with open('../../recrate'+r_rate+'_X_lengths.txt') as recwindows:
        next(recwindows)
        for recraterow in recwindows:
            recraterow = recraterow.split() # Arm, Start, End, Length, c
            rec_l = recraterow[3:]
            
            rec_l[0] = int(rec_l[0]) # len
            rec_l[1] = float(rec_l[1]) # c cM/MB. c = 100 -> 1 Morgan/megabase, 1 crossing-over expected every 1mb
            rec_l.append(rec_l[1]/100000000) # 100000000 -> divide by 100 to convert cM to M. Divide by 1m to convert from Comeron's scale (1MB) to per base.
            rec_l[1] = rec_l[2]*rec_l[0]*Ne*ploidy # multiply by 4N to obtain the population-scaled metric, multiply by rec_l[0] (length) to obtain the locus value
            if rec_l[1] == 0:
                rec_l[2] = ploidy * Ne * geneconversion
            recrate.append(rec_l)
            
recrate = random.choices(recrate, k=n_simulations) # sampling with replacement

# Start of the bash script to be submitted
bash_output = open('ms_rec_'+sys.argv[1]+'.sh','w')
first_row = '#!/bin/bash\n'
bash_output.write(first_row)
second_row = '\n'
bash_output.write(second_row)

# untar python3
untar = 'tar -xzf python37.tar.gz\n'

exp1 = 'export PATH=$PWD/python/bin:$PATH\n'
exp2 = 'export PYTHONPATH=$PWD/packages\n'
exp3 = 'export HOME=$PWD\n'

bash_output.write(untar)
bash_output.write(exp1)
bash_output.write(exp2)
bash_output.write(exp3)
bash_output.write('\n')


mkdir_row = 'mkdir ms_output\n'
bash_output.write(mkdir_row)

bash_output.write('tar -xzf ms_chtc.tar.gz\n')
bash_output.write('cd msdir\n')

bash_output.write('\n')
        
# loop here to run a few simulations per job, always changing the recombination rate and length
for rec_i in range(0,n_simulations):    
    c_size = recrate[rec_i] # randomly obtained from file (with replacement)

    c_size_ms = str(c_size[1])+' '+str(c_size[0])

    #gene convertion
    if c_size[1] == 0:
        gn_f = c_size[2]
    else:
        gn_f = geneconversion/c_size[2]

    theta =  perbase_theta * c_size[0] # theta/bp * length

    gn_tc = geneconv_tractlength

    gn_code = str(gn_f)+' '+str(gn_tc)

    output_ms = 'results_ms'+str(rec_i)+'.txt'

    cmd = './ms 368 1 -t '+str(theta)+' -r '+c_size_ms+' -c '+gn_code+' -I 5 158 24 9 76 101 0 -en 0 1 1.704878438 -en 0 2 0.327939838 -en 0 3 0.425374997 -en 0 4 0.274598828 -en 0 5 0.129370411 -em 0 1 2 2.84E+01 -em 0 2 1 2.84E+01 -em 0 1 3 1.08E-02 -em 0 3 1 1.08E-02 -em 0 1 4 0 -em 0 4 1 0 -em 0 1 5 0 -em 0 5 1 0 -em 0 2 3 1.99E+01 -em 0 3 2 1.99E+01 -em 0 2 4 1.57E+01 -em 0 4 2 1.57E+01 -em 0 2 5 6.57E+00 -em 0 5 2 6.57E+00 -em 0 3 4 1.16E-02 -em 0 4 3 1.16E-02 -em 0 3 5 1.78E+00 -em 0 5 3 1.78E+00 -em 0 4 5 1.14E+00 -em 0 5 4 1.14E+00 -ej 0.034413976 4 3 -en 0.034413976001 3 0.186840502 -em 0.034413976001 1 2 2.84E+01 -em 0.034413976001 2 1 2.84E+01 -em 0.034413976001 1 3 2.77E-03 -em 0.034413976001 3 1 2.77E-03 -em 0.034413976001 1 5 0 -em 0.034413976001 5 1 0 -em 0.034413976001 2 3 1.55E-02 -em 0.034413976001 3 2 1.55E-02 -em 0.034413976001 2 5 6.57E+00 -em 0.034413976001 5 2 6.57E+00 -em 0.034413976001 3 5 7.13E-02 -em 0.034413976001 5 3 7.13E-02 -ej 0.061759199 5 3 -en 0.061759199001 3 0.533396129 -em 0.061759199001 1 2 2.84E+01 -em 0.061759199001 2 1 2.84E+01 -em 0.061759199001 1 3 8.96E-03 -em 0.061759199001 3 1 8.96E-03 -em 0.061759199001 2 3 1.86E-01 -em 0.061759199001 3 2 1.86E-01 -ej 0.092920134 3 2 -en 0.092920134001 2 0.358345282 -em 0.092920134001 1 2 1.95E-02 -em 0.092920134001 2 1 1.95E-02 -ej 0.096188358 1 2 -en 0.096188358001 2 0.14017137 -en 0.100840635 2 1 > ' + output_ms

    bash_output.write(cmd+'\n')
    bash_output.write('\n')

bash_output.write('cd ../\n')    
mvrow = 'mv msdir/results_ms*.txt ms_output\n'    
bash_output.write(mvrow)

cd_output = 'cd ms_output\n'
bash_output.write(cd_output)

bash_output.write('\n')
bash_output.write('for z in $(ls *.txt)\n')
bash_output.write('do\n')
bash_output.write('cd ../\n')
bash_output.write('python3 ms_fst_chtc_minAlleleFreq_targetN.py ms_output/$z ./ fst_output_chr2R.out 158,21,5,74,101\n') # ZI        RG        CO        EF        FR
bash_output.write('python3 ms_fst_chtc_minAlleleFreq_targetN.py ms_output/$z ./ fst_output_chr2L.out 144,18,4,75,87\n')
bash_output.write('python3 ms_fst_chtc_minAlleleFreq_targetN.py ms_output/$z ./ fst_output_chr3R.out 129,19,4,75,63\n')
bash_output.write('python3 ms_fst_chtc_minAlleleFreq_targetN.py ms_output/$z ./ fst_output_chr3L.out 151,24,4,76,86\n')
bash_output.write('cat details_fst_output_chr2R.out >> fst_recrate'+r_rate+'_'+sys.argv[1]+'_chr2R.csv\n')
bash_output.write('cat details_fst_output_chr2L.out >> fst_recrate'+r_rate+'_'+sys.argv[1]+'_chr2L.csv\n')
bash_output.write('cat details_fst_output_chr3R.out >> fst_recrate'+r_rate+'_'+sys.argv[1]+'_chr3R.csv\n')
bash_output.write('cat details_fst_output_chr3L.out >> fst_recrate'+r_rate+'_'+sys.argv[1]+'_chr3L.csv\n')
bash_output.write('rm details_fst_output_chr2R.out\n')
bash_output.write('rm details_fst_output_chr2L.out\n')
bash_output.write('rm details_fst_output_chr3R.out\n')
bash_output.write('rm details_fst_output_chr3L.out\n')
bash_output.write('\n')
bash_output.write('cd ms_output\n')
bash_output.write('cat $z >> recrate'+r_rate+'_'+sys.argv[1]+'.csv\n')
bash_output.write('rm $z\n')
bash_output.write('done\n')


bash_output.write('mv recrate'+r_rate+'_'+sys.argv[1]+'.csv ../\n')

bash_output.close()

if sys.argv[1] == '0':
    output_submit = open('submit_recomb.sub','w')
    output_submit.write('universe = vanilla\n')
    output_submit.write('\n')
    output_submit.write('log = recomb_cmd_$(Process).log\n')
    output_submit.write('error = recomb_cmd_$(Process).err\n')
    output_submit.write('executable = ms_rec_$(Process).sh\n')
    output_submit.write('arguments = $(Process)\n')
    output_submit.write('output = rec_ms_$(Process).out\n')
    output_submit.write('\n')
    output_submit.write('should_transfer_files = YES\n')
    output_submit.write('when_to_transfer_output = ON_EXIT\n')
    output_submit.write('transfer_input_files = http://proxy.chtc.wisc.edu/SQUID/chtc/python37.tar.gz, ../../ms_fst_chtc_minAlleleFreq_targetN.py, ../../ms_chtc.tar.gz\n')
    output_submit.write('\n')
    output_submit.write('request_cpus = 1\n')
    output_submit.write('request_memory = 2GB\n')
    output_submit.write('request_disk = 2MB\n')
    output_submit.write('\n')
    output_submit.write('queue '+sys.argv[2]+'\n')
    output_submit.close()
    
