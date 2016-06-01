% List of open inputs
% Normalise: Estimate & Write: Source Image - cfg_files
% Normalise: Estimate & Write: Images to Write - cfg_files
% Normalise: Estimate & Write: Source Image - cfg_files
% Normalise: Estimate & Write: Images to Write - cfg_files
nrun = X; % enter the number of runs here
jobfile = {'/home/daniel/Desktop/Work/r21stress_analysis/Test_script_properties_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(4, nrun);
for crun = 1:nrun
    inputs{1, crun} = MATLAB_CODE_TO_FILL_INPUT; % Normalise: Estimate & Write: Source Image - cfg_files
    inputs{2, crun} = MATLAB_CODE_TO_FILL_INPUT; % Normalise: Estimate & Write: Images to Write - cfg_files
    inputs{3, crun} = MATLAB_CODE_TO_FILL_INPUT; % Normalise: Estimate & Write: Source Image - cfg_files
    inputs{4, crun} = MATLAB_CODE_TO_FILL_INPUT; % Normalise: Estimate & Write: Images to Write - cfg_files
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});
