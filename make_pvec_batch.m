load r21_stress_subjects.mat;

td=subjects.textdata;
snfiles=subjects.warpfiles;

for i=1:length(td)

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

save('pvec_batch.mat','matlabbatch')

