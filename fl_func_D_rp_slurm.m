function fl_func_D_rp_slurm(slurm_id)

% get subject IDs from Slurm ID
if nargin==0, slurm_id = 1; end
if ischar(slurm_id), slurm_id = str2double(slurm_id); end;
fprintf(1,'\n\nslurmArrayID: %d\n\n\n\n',slurm_id);

rng('shuffle'); pause(rand(1)*8);


subIDs = load('~/projects/bmrk5_nac_pain/code/batchjobs/validsubj.txt');
subIDs = subIDs(:,slurm_id);
addpath('/home/stge3905/projects/bmrk5_nac_pain/code/batchjobs/');

% folders
rdir   = '/work/ics/data/projects/wagerlab/labdata/projects/bmrk5_nac_pain/';
odir   = fullfile(rdir,'/data/onsets/');
adir   = fullfile(rdir,'/analysis/SPM/');
imgdir = fullfile(rdir,'data','mri');


% fl folder
fl = 'fl_D_full_ST_rp';

% filters
imgfilt   = 'swrarun_r*.nii';
rpfilt    = 'noise_model_rp_spikes_r*.mat';
onsetfilt = 'full_model_ST_r*.mat';

% contrast filters
cfilt    = {'stim_heat_(short|long)\w*ON','stim_(soundpain|iads)\w*ON','stim_heat_(short|long)\w*OFF','stim_(soundpain|iads)\w*OFF',...
            'stim_heat_(short|long)_L\w*ON','stim_heat_(short|long)_M\w*ON','stim_heat_(short|long)_H\w*ON',...
            'stim_(soundpain|iads)_L\w*ON','stim_(soundpain|iads)_M\w*ON','stim_(soundpain|iads)_H\w*ON',...
            'cue_heat', 'cue_sound'};
        
conname  = {'pain ON','sound ON','pain OFF','sound OFF',...
            'pain L ON','pain M ON','pain H ON',...
            'sound L ON','sound M ON','sound H ON',...
            'cue pain', 'cue sound'};


% fl job template
jobs = {'~/projects/bmrk5_nac_pain/code/fl_templates/fl_singletrial_rp.m'};

% spm config
spm_jobman('initcfg');
spm_get_defaults('cmdline',true);
spm_get_defaults('maxmem',2^33);
spm_get_defaults('mask.thresh',-inf);

% n runs
nrun = numel(subIDs);
nerr = zeros(size(subIDs));

% echo job info
fprintf(1,'\n=========================================\n');    
fprintf(1,['\nSubjects ' repmat('%4d ',1,nrun) '\n\n'],subIDs);
fprintf(1,'SPM template:\t%s\nOutput dir:\t%s\nFL dir:\t\t%s\nNIFTI filt:\t%s\nonset filt:\t%s\nnuis filt:\t%s\n',...
           jobs{1},adir,fl,imgfilt,onsetfilt,rpfilt);
fprintf(1,'\n=========================================\n');    


for crun = 1:nrun

    fprintf(1,'\nnow running subject %d...\n\n',subIDs(crun));
    in = cell(4,1);
    
    % subject fl dir
    fldir = fullfile(adir,fl,sprintf('sub%04d',subIDs(crun)));
    if ~isdir(fldir), mkdir(fldir); end;
    
    % filter all image files
    imgs = filenames(fullfile(imgdir,sprintf('sub%04d',subIDs(crun)),'/run**',imgfilt));
    
    % filter onset file
    ons  = filenames(sprintf('%ssub%04d/BME/%s',odir,subIDs(crun),onsetfilt));
    
    % filter nuisance file
    nuis = filenames(sprintf('%ssub%04d/nuis/%s',odir,subIDs(crun),rpfilt));
   
    in{1} = {fldir}; % Change Directory: Directory - cfg_files
    in{2} = {fldir}; % fMRI model specification: Directory - cfg_files
    
    for r = 1:4
        in{3 + (r-1)*3} = cellstr(spm_select('ExtFPList',fileparts(imgs{r}),regexprep(imgfilt,'*','.*'),1:462)); % scans
        in{4 + (r-1)*3} = ons(r); % conditions
        in{5 + (r-1)*3} = nuis(r); % nuisance matrix R
    end
    
    if sum(cellfun(@length, in)) == 2 + (4*2) + (4*462)
        
        % estimate FL SPM
        spm_jobman('serial', jobs, '', in{:});
        
        
        % add some contrasts
        cd(fldir);
        load('SPM.mat');
        
        for cc = 1:length(cfilt)
            contrast = cellregexp(SPM.xX.name,cfilt{cc});
            
            disp(SPM.xX.name(logical(contrast))');
            matlabbatch{1}.spm.stats.con.consess{cc}.tcon.name = conname{cc};
            matlabbatch{1}.spm.stats.con.consess{cc}.tcon.convec = contrast ./ sum(contrast);
            matlabbatch{1}.spm.stats.con.consess{cc}.tcon.sessrep = 'none';
        end
        matlabbatch{1}.spm.stats.con.spmmat = cellstr(fullfile(fldir,'SPM.mat'));
        matlabbatch{1}.spm.stats.con.delete = 1;
        % run job
        spm_jobman('run',matlabbatch);
        
    else
        fprintf(1,'\n\n\nSubject %d\ndoes not have 462 images for all runs. Input N was: %d\nremoving: %s\n\n\n', subIDs(crun),sum(cellfun(@length, in)),fldir);
        rmdir(fldir,'s');
        nerr(crun) = 1;
    end
end

spm_get_defaults('cmdline',false);
fprintf(1,'\n\ndone with %d jobs\n',max(crun));
if sum(nerr)==0
    disp(subIDs);
else
fprintf(1,['ran FL for\t' repmat('%4d',1,sum(nerr==0)), '\nerror at\t\t' repmat('%4d',1,sum(nerr==1)) '\n'],...
    subIDs(nerr==0),subIDs(nerr));
end
