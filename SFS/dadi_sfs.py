import dadi

datafile = '9PopChrX_ms_100k_rep.txt'


print('reading file')
dd = dadi.Spectrum.from_ms_file(datafile)

#print('making Spectrum')
#fs = dadi.Spectrum.from_Data_dict(dd, pop_id = ['pop1','pop2'], projections = [143, 18], polarized = False)
