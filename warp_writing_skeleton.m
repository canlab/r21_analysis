% List of open inputs
nrun = X; % enter the number of runs here
jobfile = {'/home/daniel/Desktop/Work/r21stress_analysis/warp_writing_skeleton_job.m'};
jobs = repmat(jobfile, 1, nrun);
inputs = cell(0, nrun);
for crun = 1:nrun
end
spm('defaults', 'FMRI');
spm_jobman('serial', jobs, '', inputs{:});
