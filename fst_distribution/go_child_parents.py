# script made to be used with FlyBase and GeneOntology.org files.
# there is an option to update the GO_desc12_condensed_parents.txt file - set to True by default (update_go_desc=1, change 0 to turn it off). It is written as option to make the script usable by people who don't need this file in their pipeline.
# this script requires the following two files to be in the same directory as this script:
# file 1: gene_association.fb
# file 2: go.obo
# the script will generate a new file linking a giving FBgn ID to all its GO terms and their parents (including is_a, part_of, intersection_of, and regulates).
# the only argument required by the script if the name of the output file.
# if "GO_desc12" option is true, the GO_desc12_condensed_parents.txt file should also be in the same directory.
# the script will create an updated GO_desc12_condensed_parents.txt and will name it GO_desc12_condensed_parents_updated.txt

# I am also adding an option to turn off the GO_gene_cats update (that uses flybase and geneontology information). go_gene_cats = 0 (off) or 1 (on)
# author: Tiago Ribeiro - tribeiro@wisc.edu

import re, sys

go_gene_cats = 0
update_go_desc=1

if len(sys.argv) < 2:
    print("You need to inform the name for the output file.")
    quit()

# filenames
gene_association = 'gene_association.fb'
goobo = 'go.obo'
go_desc12 = 'GO_desc12_condensed_parents.txt'

if go_gene_cats:
    print('The script will use gene_annotion and go.obo to update the information about the GO terms from each gene.\n')
else:
    print('The option to update gene information is turned off.\n')

if update_go_desc:
    print('The script will update the list of GO term names.\n')
else:
    print('The option to update the file with GO terms and their names is turned off.\n')


if go_gene_cats:
    output_filename = sys.argv[1]

    # dictionaries to store FBgn child GO terms and gene name.
    FB_go_dict = {}
    FB_genename_dict = {}

    # Reading gene_association.fb to create a dictionary with all FBgn genes.
    with open(gene_association) as gn_ass:
        print('Reading FBgn from the gene_association file.\n')
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
    with open(goobo) as goobofile:
        print('Reading the go.obo file with information about GO terms.\n')
        for row in goobofile:
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

    output = open(output_filename,'w')
    print('Writing the updated file associating genes and their GO terms (parents and childs).\n')
    for fbgnkey in FB_go_dict.keys():
        goterms_with_parents = go_parent_loop(FB_go_dict[fbgnkey])
        gene_name = FB_genename_dict[fbgnkey]
        output_vector = [fbgnkey,gene_name] + goterms_with_parents
        output.write('\t'.join(output_vector) + '\n')
    output.close()


#################################################################################
#################################################################################
######### The next block will update GO_desc12_condensed_parents.txt ############
#################################################################################
#################################################################################

if update_go_desc:
    go_desc_term = []
    go_desc_entries = []
    with open(go_desc12) as godesc:
        print('Reading current file with GO term names.\n')
        for row in godesc:
            row = re.split('\t',row[:-1])
            go_desc_term.append(row[0])
            go_desc_entries.append(row)
    
    tmp_godesc = re.split('\.',go_desc12)
    output_godesc_name = '.'.join(tmp_godesc[:-1]) + '_updated.' + tmp_godesc[-1]
    output_godesc = open(output_godesc_name,'w')
    get_name_p_key = 0
    term_to_add = []
    list_terms_to_add = []
    with open(goobo) as goobofile:
        print('Searching for new GO terms to add to the updated file.\n')
        for row in goobofile:
            if get_name_p_key == 1:
                row = row.split()
                if row[0] == 'name:':
                    term_to_add.append(row[1])
                elif row[0] == 'namespace:':
                    term_to_add.append(row[1][0])
                    tmp_term = [term_to_add[0], term_to_add[2], term_to_add[1]]
                    list_terms_to_add.append(tmp_term)
                else:
                    get_name_p_key = 0
            elif row[:3] == 'id:':
                row = row.split()
                if row[1][:3] == 'GO:':
                    if row[1] not in go_desc_term:
                        term_to_add = []
                        term_to_add.append(row[1])
                        get_name_p_key = 1
                    


    j = 0
    print('Writing updated file with GO term names.\n')
    for aterm in list_terms_to_add:
        while int(re.split(':',aterm[0])[1]) > int(re.split(':',go_desc_entries[j][0])[1]):
            output_godesc.write('\t'.join(go_desc_entries[j])+'\n')
            j += 1
        output_godesc.write('\t'.join(aterm)+'\n')

    for i in range(j,len(go_desc_entries)):
        output_godesc.write('\t'.join(go_desc_entries[i])+'\n')
    output_godesc.close()


#################################################################################
#################################################################################
########## The next block contain the functions used in this script #############
#################################################################################
#################################################################################

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
