%-----------------------------------------------------------------------
% Job configuration created by cfg_util (rev $Rev: 4252 $)
%-----------------------------------------------------------------------
load('filenames.mat')
SPM_T1_location= '/Volumes/engram/Resources/spm8/templates/T1.nii,1'

for i=1:(length(filenames)-1)
  filenamestring=strcat(filenames{i},',1')
  matlabbatch{i}.spm.spatial.normalise.estwrite.subj.source = {filenamestring};
  matlabbatch{i}.spm.spatial.normalise.estwrite.subj.wtsrc = '';
  matlabbatch{i}.spm.spatial.normalise.estwrite.subj.resample = {filenamestring};
  matlabbatch{i}.spm.spatial.normalise.estwrite.eoptions.template = {'/home/daniel/Work/spm8/templates/T1.nii,1'};
  matlabbatch{i}.spm.spatial.normalise.estwrite.eoptions.weight = '';
  matlabbatch{i}.spm.spatial.normalise.estwrite.eoptions.smosrc = 8;
  matlabbatch{i}.spm.spatial.normalise.estwrite.eoptions.smoref = 0;
  matlabbatch{i}.spm.spatial.normalise.estwrite.eoptions.regtype = 'mni';
  matlabbatch{i}.spm.spatial.normalise.estwrite.eoptions.cutoff = 25;
  matlabbatch{i}.spm.spatial.normalise.estwrite.eoptions.nits = 16;
  matlabbatch{i}.spm.spatial.normalise.estwrite.eoptions.reg = 1;
  matlabbatch{i}.spm.spatial.normalise.estwrite.roptions.preserve = 0;
  matlabbatch{i}.spm.spatial.normalise.estwrite.roptions.bb = [-78 -112 -50
                                                               78 76 85];
  matlabbatch{i}.spm.spatial.normalise.estwrite.roptions.vox = [2 2 2];
  matlabbatch{i}.spm.spatial.normalise.estwrite.roptions.interp = 1;
  matlabbatch{i}.spm.spatial.normalise.estwrite.roptions.wrap = [0 0 0];
  matlabbatch{i}.spm.spatial.normalise.estwrite.roptions.prefix = 'w';
end
