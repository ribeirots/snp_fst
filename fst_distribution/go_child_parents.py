# script made to be used with FlyBase and GeneOntology.org files.
# this script takes in [1] gene_association.fb and [2] go.obo files to generate a file linking a giving FBgn ID to all its GO terms and their parents (including is_a, part_of, intersection_of, and regulates).
# the two files mentioned above should be in the same directory as this script. The only argument needed is the output file name.
# author: Tiago Ribeiro - tribeiro@wisc.edu

import re, sys

output_filename = sys.argv[1]

# dictionaries to store FBgn child GO terms and gene name.
FB_go_dict = {}
FB_genename_dict = {}

# Reading gene_association.fb to create a dictionary with all FBgn genes.
with open('gene_association.fb') as gn_ass:
    for row in gn_ass:
        if row[:2] == 'FB':
            row = re.split('\t',row[:-1])
            # check point to ensure that GO term is on the correct column.
            if row[4][:3] != 'GO:':
                print('GO term should be in the 4th column for all gene entries. Potentially due to gene name mislabling, missing GO term in the correct position for: '+row)
                quit()
            l = row[1],row[2],row[4]
            # True = new dict entry. False = add to existing entry.
            if l[0] not in FB_go_dict.keys():
                FB_go_dict[l[0]] = [l[2]]
                FB_genename_dict[l[0]] = l[1]
            else:
                FB_go_dict[l[0]].append(l[2])

# Create dictionary linking a child GO to its parents - if any. Also creates a secondary dict saying whether the GO is obsolete.
go_obo_dict = {}
go_id_found = 0 
is_obsolete = 0
with open('go.obo') as goobo:
    for row in goobo:
        if row[:6] == 'id: GO':
            child_id = row[4:-1]
            parent_list = []
            go_id_found = 1
            is_obsolete = 0
        elif go_id_found:
            if ('is_obsolete: true' in row):
                is_obsolete = 1
            if len(row) <= 1:
                go_id_found = 0
                if (len(parent_list) >= 1) and (is_obsolete == 0):
                    if child_id not in go_obo_dict.keys():
                        go_obo_dict[child_id] = parent_list
                        parent_list = []
            elif 'GO:' in row:
                if ('is_a' in row) or ('part_of' in row) or ('intersection_if' in row) or ('regulates' in row):
                    r = re.split(' ',row[:-1])
                    for obs in r:
                        if obs[:3] == 'GO:':
                            parent_list.append(obs)

# This function will receive one GO term id (e.g. 'GO:0005886') and return if it is the top most Molecular Function (m), Cellular Component (c), Biological Process (b), or if it is obsolete, or an vector with all the GOs term that are parents of the input GO term.
def go_parent_search(got):
    if got == 'GO:0003674':
        return ['m']
    elif got == 'GO:0005575':
        return ['c']
    elif got == 'GO:0008150':
        return ['b']
    elif got in go_obo_dict.keys():
        return go_obo_dict[got]
    else:
        return ['obsolete']

# This function will receive a vector of GO terms and loop through the 'go_parent_search()' function until all the GO parents have been added. It will search for the parents of each additional term that is itself added as parent until no new term is added (no replicates either). It returns a vector with the child terms and all the parent terms.
def go_parent_loop(vector_goterms):
    i1 = 0 # marker to extend the vector with GO Terms
    i2 = 0 # marker to determine the loop break
    go_vect = vector_goterms
    while i2 < len(go_vect):
        i1 = i2
        i2 = len(go_vect)
        for j in range(i1,i2):
            j_go_vect = go_parent_search(go_vect[j])
            for obs in j_go_vect:
                if (obs[0] == 'G') and (obs not in go_vect):
                    # This if clause ensures that we not adding obsolete parents.
                    if obs in go_obo_dict.keys() or obs in ['GO:0003674','GO:0005575','GO:0008150']:
                        go_vect.append(obs)
    return go_vect

output = open(output_filename,'w')
for fbgnkey in FB_go_dict.keys():
    goterms_with_parents = go_parent_loop(FB_go_dict[fbgnkey])
    gene_name = FB_genename_dict[fbgnkey]
    output_vector = [fbgnkey,gene_name] + goterms_with_parents
    output.write('\t'.join(output_vector) + '\n')
output.close()
