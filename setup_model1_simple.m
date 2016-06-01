function [DSGN] = setup_model1_simple(trname, tr, funcnames)

modelname = ['model1_' trname 'simple'];
% 
DSGN.modeldir = ['/dreamio3/wagerlab/labdata/projects/bmrk5_painsound/first_level_' trname 'Aug2015/basic_pain_sound'];
% 
DSGN.subjects = importdata(['/dreamio3/wagerlab/labdata/projects/bmrk5_painsound/modelscripts/all_tr' trname '_with_firstlevel.lst']);
% 
% DSGN.funcnames = {'Functional/Preprocessed/s*/swrarun_r1.nii' 'Functional/Preprocessed/s*/swrarun_r2.nii' 'Functional/Preprocessed/s*/swrarun_r3.nii' 'Functional/Preprocessed/s*/swrarun_r4.nii'};

DSGN.funcnames = funcnames;
DSGN.tr = tr;

%% model setup
DSGN.allowmissingfunc = true;
DSGN.concatenation = {[1:4]};
DSGN.allowemptycond = true;

%DSGN.tr = 1.3;
DSGN.hpf = 224; % was 180
DSGN.fmri_t0 = 1;

%DSGN.modelingfilesdir = 'spm_modeling'; % Added like Hedwig's file
DSGN.notimemod = true;
DSGN.multireg = 'noise_model_1';


%Definitions of pain and soud stimulation period regressors
c = 0;
for i = {'stim_heat_short' 'stim_heat_long' 'stim_heat_offset' 'stim_soundpain' 'stim_iads'}
    for j = {'L' 'M' 'H'}
        c=c+1; DSGN.conditions{1}{c} = [i{1} '_' j{1}];
    end
end

% % Definition of pain and sound cue period regressors
for i = {'cue_heat_all' 'cue_soundpain' 'cue_iads'};
	c=c+1; DSGN.conditions{1}{c} = i{1};
end

% Definition of other parts of the experiment which we are interested in
% modelling as regressors but not contrasting right now
for i = {'endscreenBS' 'intensity' 'rating_post_stim' 'rating_pre_stim' 'unpleasantness' 'badtrial' 'firstheat'};
	c=c+1; DSGN.conditions{1}{c} = i{1};
end

DSGN.singletrials{1} = {1 1 1 1 1 1 1 1 1 1 1 1 1 1 1};

DSGN.regmatching = 'regexp';

%% contrasts

c=0;

%Each condition vs rest

for i = {'stim_heat_short' 'stim_heat_long' 'stim_heat_offset' 'stim_soundpain' 'stim_iads'}
    for j = {'L' 'M' 'H'}
        c=c+1; DSGN.contrasts{c} = {{[i{1} '_' j{1}]}};
        DSGN.contrastnames{c} = [i{1} '_' j{1}];
    end
end

% heat short and long, H - L
c=c+1; DSGN.contrasts{c} = {{'stim_heat_long_H' 'stim_heat_short_H'} {'stim_heat_long_L' 'stim_heat_short_L'}};
DSGN.contrastnames{c} = 'stim_heat_short_long_H-L';

% heat short and long (all levels) vs rest
c=c+1; DSGN.contrasts{c} = {{'stim_heat_long_H' 'stim_heat_short_H'...
    'stim_heat_long_M' 'stim_heat_short_M'...
    'stim_heat_long_L' 'stim_heat_short_L' }};
DSGN.contrastnames{c} = 'stim_heat_short_long_all_levels_v_rest';

% heat short and long and offset, H - L
c=c+1; DSGN.contrasts{c} = {{'stim_heat_long_H' 'stim_heat_short_H' 'stim_heat_offset_H'} {'stim_heat_long_L' 'stim_heat_short_L' 'stim_heat_offset_L'}};
DSGN.contrastnames{c} = 'stim_heat_short_long_offset_H-L';

% heat short+long+offset (all levels) vs rest
c=c+1; DSGN.contrasts{c} = {{'stim_heat_long_H' 'stim_heat_short_H' 'stim_heat_offset_H' ...
    'stim_heat_long_M' 'stim_heat_short_M' 'stim_heat_offset_M'...
    'stim_heat_long_L' 'stim_heat_short_L' 'stim_heat_offset_L'}};
DSGN.contrastnames{c} = 'stim_heat_short_long_offset_all_levels_v_rest';


save(modelname,'DSGN')
end