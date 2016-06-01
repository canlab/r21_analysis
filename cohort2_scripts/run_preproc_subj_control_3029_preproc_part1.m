% subj_control_3029
% Data in: /Volumes/current/r21stress/Cohort1/Imaging/BOLD/subjects/subj_control_3029
% Output saved to: /Volumes/current/r21stress/Cohort1/Imaging/BOLD/subjects/HTML_output/Preprocessing_html_subj_control_3029
% Started on: 21-Nov-2012_19_28
% Created by user: heya1148
% -------------------------------------------------------- 
t1 = clock;

load preproc_input.mat
canlab_preproc_2012(subjectdir, runwc, imgwc, TR, anat, 'acquisition', acqorder, 'nointeractive','nopart2'); 

elapsed = etime(clock, t1) ./ 60;
hours = floor(elapsed ./ 60);
min = rem(elapsed, 60);
fprintf('Completed in %3.0f hours, %3.0f min\n', hours, min);
