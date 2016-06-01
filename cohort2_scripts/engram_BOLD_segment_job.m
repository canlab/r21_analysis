%-----------------------------------------------------------------------
% Job saved on 18-Apr-2016 13:44:53 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6470)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------
load cohort2_bold_structural_filenames.mat

path_8to12

spm_jobman('initcfg')

for i=1:length(structural_filenames)
  matlabbatch{i}.spm.spatial.preproc.channel.vols = {structural_filenames{i}};
  matlabbatch{i}.spm.spatial.preproc.channel.biasreg = 0.001;
  matlabbatch{i}.spm.spatial.preproc.channel.biasfwhm = 60;
  matlabbatch{i}.spm.spatial.preproc.channel.write = [0 0];
  matlabbatch{i}.spm.spatial.preproc.tissue(1).tpm = {'/Volumes/engram/Resources/spm12/tpm/TPM.nii,1'};
  matlabbatch{i}.spm.spatial.preproc.tissue(1).ngaus = 1;
  matlabbatch{i}.spm.spatial.preproc.tissue(1).native = [1 0];
  matlabbatch{i}.spm.spatial.preproc.tissue(1).warped = [0 0];
  matlabbatch{i}.spm.spatial.preproc.tissue(2).tpm = {'/Volumes/engram/Resources/spm12/tpm/TPM.nii,2'};
  matlabbatch{i}.spm.spatial.preproc.tissue(2).ngaus = 1;
  matlabbatch{i}.spm.spatial.preproc.tissue(2).native = [1 0];
  matlabbatch{i}.spm.spatial.preproc.tissue(2).warped = [0 0];
  matlabbatch{i}.spm.spatial.preproc.tissue(3).tpm = {'/Volumes/engram/Resources/spm12/tpm/TPM.nii,3'};
  matlabbatch{i}.spm.spatial.preproc.tissue(3).ngaus = 2;
  matlabbatch{i}.spm.spatial.preproc.tissue(3).native = [1 0];
  matlabbatch{i}.spm.spatial.preproc.tissue(3).warped = [0 0];
  matlabbatch{i}.spm.spatial.preproc.tissue(4).tpm = {'/Volumes/engram/Resources/spm12/tpm/TPM.nii,4'};
  matlabbatch{i}.spm.spatial.preproc.tissue(4).ngaus = 3;
  matlabbatch{i}.spm.spatial.preproc.tissue(4).native = [1 0];
  matlabbatch{i}.spm.spatial.preproc.tissue(4).warped = [0 0];
  matlabbatch{i}.spm.spatial.preproc.tissue(5).tpm = {'/Volumes/engram/Resources/spm12/tpm/TPM.nii,5'};
  matlabbatch{i}.spm.spatial.preproc.tissue(5).ngaus = 4;
  matlabbatch{i}.spm.spatial.preproc.tissue(5).native = [1 0];
  matlabbatch{i}.spm.spatial.preproc.tissue(5).warped = [0 0];
  matlabbatch{i}.spm.spatial.preproc.tissue(6).tpm = {'/Volumes/engram/Resources/spm12/tpm/TPM.nii,6'};
  matlabbatch{i}.spm.spatial.preproc.tissue(6).ngaus = 2;
  matlabbatch{i}.spm.spatial.preproc.tissue(6).native = [0 0];
  matlabbatch{i}.spm.spatial.preproc.tissue(6).warped = [0 0];
  matlabbatch{i}.spm.spatial.preproc.warp.mrf = 1;
  matlabbatch{i}.spm.spatial.preproc.warp.cleanup = 1;
  matlabbatch{i}.spm.spatial.preproc.warp.reg = [0 0.001 0.5 0.05 0.2];
  matlabbatch{i}.spm.spatial.preproc.warp.affreg = 'mni';
  matlabbatch{i}.spm.spatial.preproc.warp.fwhm = 0;
  matlabbatch{i}.spm.spatial.preproc.warp.samp = 3;
  matlabbatch{i}.spm.spatial.preproc.warp.write = [1 1];

end

spm_jobman('run',matlabbatch)
