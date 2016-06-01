#! /usr/local/bin/python

from os import path
import os
import re
import sys
from glob import glob

prefix=sys.argv[1]
starting_path=os.path.abspath(prefix)
raw_parrecs=glob(prefix+'/subj*/raw/*')
starting_location=os.getcwd()
#These contain both BOLD and CASL directories, so we need to filter out the CASL images.

#This function returns false for any string which has 'casl' in it, in any case.
def filter_casl(check_string):
    return 'CASL' not in check_string.upper()

#We only need to look at files that have "long" or "short" in them.
def filter_short(check_string):
    ignorecase=check_string.upper()
    is_long="LONG" in ignorecase
    is_short="SHORT" in ignorecase
    return (is_long or is_short)

raw_parrecs=filter(filter_casl , raw_parrecs)
raw_parrecs=filter(filter_short , raw_parrecs)
#Sorting it at this point assures consistent results across versions of python.
raw_parrecs.sort()

#Make sure to add any new conserved parts before PAR and REC, otherwise you'll screw
#up the file extension.
conserved_parts=["[0-9]{3,4}","LONG","SHORT","_[0-9]{2}[^0-9]", "_[2-9][^0-9]","\.PAR","\.REC"]
conserved_regexps=[re.compile(x) for x in conserved_parts]
new_prefix="R21_Stress_BOLD"
new_filenames=[]

for filename in raw_parrecs:
    filename_parts=[new_prefix]
    ignorecase=filename.upper()
    #Special handling of extra numbers in the filenames
    find_extra_numbers=re.compile('_[0-9]_[0-9]{1,2}_1')
    match=find_extra_numbers.search(ignorecase)
    if match:
        ignorecase=re.sub('_[0-9]_','_',ignorecase)
    #an fsm is a finite state machine (a compiled regexp)
    for fsm in conserved_regexps:
        match=fsm.search(ignorecase)
        if match:
            filename_parts.append(match.group())
    #The zfill pads integer strings out with zeros. This should ensure a 3-digit run extension.
    run_number=filename_parts[-2].translate(None, '_')
    run_number=run_number.zfill(3)
    filename_parts[-2]=run_number
    #This line concatenates all of the conserved parts except the file extension with underscores,
    #then adds the file extension to the end.
    new_filename=reduce(lambda x,y:x+'_'+y,filename_parts[0:-2])+"_"+filename_parts[-2]+filename_parts[-1]
    new_filenames.append(new_filename)
    
renaming_formulae=zip(raw_parrecs,new_filenames)
print renaming_formulae
print "External Localdir: ", os.path.abspath(os.path.dirname(renaming_formulae[0][0]))
#Renaming the files and printing the old and new names.
for formula in renaming_formulae:
    print "Formula: ", formula[0]
    localdir=os.path.abspath(os.path.dirname(formula[0]))
    print "Localdir: ", localdir
    os.chdir(localdir)
    localname=os.path.basename(formula[0])
    print ("Old Name:", localname, ";  New Name:", formula[1])
    os.rename(localname,formula[1])
    os.chdir(starting_location)
    
