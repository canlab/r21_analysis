load data_object_in_progress_5_4.mat;

td=r21data.Event_Level.textdata;

for i=1:length(td)
  subjdir=fileparts(td{i}{1});
  snfile_pattern=strcat(subjdir,'/*_sn.mat');
  dirlisting=dir(snfile_pattern);
  if length(dirlisting)>1
    snfile=dirlisting(1).name;
  elseif length(dirlisting)==0
    continue
  else
    snfile=dirlisting.name;
  end
  snfiles{i}=snfile

%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 4252 $)
%-----------------------------------------------------------------------
  matlabbatch{i}.spm.spatial.normalise.write.subj.matname = {snfiles{i}};
  matlabbatch{i}.spm.spatial.normalise.write.subj.resample = td{i};
  matlabbatch{i}.spm.spatial.normalise.write.roptions.preserve = 0;
  matlabbatch{i}.spm.spatial.normalise.write.roptions.bb = [-78 -112 -50
                                                            78 76 85];
  matlabbatch{i}.spm.spatial.normalise.write.roptions.vox = [2 2 2];
  matlabbatch{i}.spm.spatial.normalise.write.roptions.interp = 1;
  matlabbatch{i}.spm.spatial.normalise.write.roptions.wrap = [0 0 0];
  matlabbatch{i}.spm.spatial.normalise.write.roptions.prefix = 'w';

end

save('CASL_cohort1_control_writing_batch.mat','matlabbatch')

