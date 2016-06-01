load data_object_in_progress_5_4.mat;
PREPROC.anat_files='foo'; %fill this in with a cellstr of subjects anatomical images
PREPROC.files_to_warp=r21data.Event_Level.textdata; %this should be a cell array of cellstrs of functional images
PREPROC.meanfilename_realigned='bar'; %cellstr of subjects' mean prewarped functional images.
preproc_part2(PREPROC)
