import re 

with open("8PopChr3L_ms.txt", "r") as file:
    next(file)
    next(file)
    lines = 1
    individuals_started = 0   
    total_simulations = 0
    error = 0
    for line in file:
        if len(line) == 1: #line = \n
	    total_simulations += 1
            if individuals_started == 1:
                individuals_started = 0
                if lines != 233:
                    print('error')
		    error += 1
                lines = 1
            else:
                line = line
        elif line[0] == '/':
            line = line
        elif line[0] == 's':
            line = line
        elif line[0] == 'p':
            line = line
        elif line[0] == '0' or line[0] == '1':
            lines += 1
            individuals_started = 1

print('Total simulations used: '+str(total_simulations))
print(error)
