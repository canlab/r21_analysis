#! /usr/local/bin/python

from os import path
import os
import re
import sys
from glob import glob

prefix=sys.argv[1]
starting_path=os.getcwd()
raw_parrecs=glob(prefix+'/*/raw/*')
#These contain both BOLD and CASL directories, so we need to filter out the CASL images.

#This function returns false for any string which has 'casl' in it, in any case.
def filter_casl(check_string):
    return 'CASL' not in check_string.upper()

#We only need to look at files that have "mprage" in them.
def filter_mprage(check_string):
    ignorecase=check_string.upper()
    return "MPRAGE" in ignorecase

raw_parrecs=filter(filter_casl , raw_parrecs)
raw_parrecs=filter(filter_mprage , raw_parrecs)
#Sorting it at this point assures consistent results across versions of python.
raw_parrecs.sort()

#Make sure to add any new conserved parts before PAR and REC, otherwise you'll screw
#up the file extension.
conserved_parts=["[0-9]{3,4}","MPRAGE","_[2-9]_","\.PAR","\.REC"]
conserved_regexps=[re.compile(x) for x in conserved_parts]
new_prefix="R21_Cohort2"
new_filenames=[]

for filename in raw_parrecs:
    filename_parts=[new_prefix]
    ignorecase=filename.upper()
    #an fsm is a finite state machine (a compiled regexp)
    for fsm in conserved_regexps:
        match=fsm.search(ignorecase)
        if match:
            filename_parts.append(match.group())
    #This line concatenates all of the conserved parts except the file extension with underscores,
    #then adds the file extension to the end.
    run_number=filename_parts[-2].translate(None, "_")
    run_number="_"+run_number.zfill(3)
    new_filename=reduce(lambda x,y:x+'_'+y,filename_parts[0:-2])+run_number+filename_parts[-1]
    new_filenames.append(new_filename)

renaming_formulae=zip(raw_parrecs,new_filenames)

#Renaming the files and printing the old and new names.
for formula in renaming_formulae:
    localdir=os.path.abspath(os.path.dirname(formula[0]))
    os.chdir(localdir)
    localname=os.path.basename(formula[0])
    print "Old Name:", localname, ";  New Name:", formula[1]
    os.rename(localname,formula[1])
    os.chdir(starting_path)
    
