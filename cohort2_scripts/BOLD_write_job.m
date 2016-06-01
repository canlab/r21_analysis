%-----------------------------------------------------------------------
% Job saved on 18-Apr-2016 14:02:14 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6470)
% cfg_basicio BasicIO - Unknown
%-----------------------------------------------------------------------

path_8to12;

spm_jobman('initcfg');
basedir=pwd;
subjdirs = ls ('-d','--color=never', '/Volumes/engram/labdata/projects/r21stress/cohort2/BOLD/subjects/*/');
subjdirs = cell(strsplit(subjdirs));
subjdirs(length(subjdirs))=[];
for i=1:length(subjdirs)
  warpfile= ls(strcat(subjdirs{i},'/Structural/SPGR/y_*.nii'));
  matlabbatch{i}.spm.spatial.normalise.write.subj.def = {warpfile};
  
  meanfile = strcat(subjdirs{i},'/Functional/Preprocessed/mean_ra_func.img');
  funcfiles = ls(strcat(subjdirs{i},'/Functional/Preprocessed/R21_*/ra*.nii'));
  funcfiles = cell(strsplit(funcfiles));
  funcfiles{length(funcfiles)}=meanfile;
  matlabbatch{i}.spm.spatial.normalise.write.subj.resample = funcfiles;
  matlabbatch{i}.spm.spatial.normalise.write.woptions.bb = [-78 -112 -70
                                                            78 76 85];
  matlabbatch{i}.spm.spatial.normalise.write.woptions.vox = [2 2 2];
  matlabbatch{i}.spm.spatial.normalise.write.woptions.interp = 4;
end
cd(basedir);
spm_jobman('run',matlabbatch);


