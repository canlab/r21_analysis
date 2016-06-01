mean_montage_dir = './rewarp_mean_montage';
%subj_list = [8642 8862 9180 9190 9194];
casl_dir = '../../Cohort2';
slist = filenames([casl_dir '/*/*/w*.nii']);
for i=1:length(slist)
  sn_strings=regexp(slist{i}, '[0-9][0-9][0-9][0-9]', 'match');
  subj_list(i) = str2num(sn_strings{1});
end


