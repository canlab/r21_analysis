%%  PREPROC PART 2 - SEAT and N-BACK tasks
 
% Go to the directory where the functional images are for a single subject:
cd cd /Volumes/r21stress/Imaging/
 
% Specify a UNIX-style wildcard for listing the filenames of your
% functional runs:
my_image_wildcard = 'ra*run1*.img';  % special for SEAT and N-Back tasks : example, as all input params are!
 
my_anat_wildcard = '*MPRAGE*img';
 
imgs = filenames(my_image_wildcard, 'absolute'); disp(char(imgs{:}))
 
disp(' ')
 
anat = filenames(my_anat_wildcard, 'absolute'); disp(char(anat{:}))
 
PREPROC2.anat_files = anat;
PREPROC2.files_to_warp = {imgs};
PREPROC2.mean_ra_func_files = {'mean_ra_func.img'};
 
preproc_part2(PREPROC2, 'set_origins', 1, 'coreg anat to func', 1, ...
    'warp', 1, 'smooth', 1, 'check norms', 0, ...
    'SPM5', 'generate mean', 1, 'verbose', 1, 'clean up', 1, 'save plots', 1);



%% Coreg only
preproc_part2(PREPROC2, 'set_origins', 1, 'coreg anat to func', 1, ...
    'warp', 0, 'smooth', 0, 'check norms', 0, ...
    'SPM5', 'generate mean', 1, 'verbose', 1, 'clean up', 1, 'save plots', 1);