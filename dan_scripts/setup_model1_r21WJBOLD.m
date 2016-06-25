%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;

INCLUDE_CONTRASTS  = 0;
PARAMETRIC = 0;

if PARAMETRIC
    DSGN.metadata.notes = 'R21 Stress Word Judgment (SHORT BOLD)';
    modelname = ['r21_wj_model1_pmod'];

    DSGN.modeldir = '/Volumes/engram/labdata/projects/r21stress/BOLD/analysis/first_level/SHORT_model1_pmod';
else
    DSGN.metadata.notes = 'R21 Stress Word Judgment (SHORT BOLD) no parametric modulators';
    modelname = ['r21_wj_model1'];
    
    DSGN.modeldir = '/Volumes/engram/labdata/projects/r21stress/BOLD/analysis/first_level/SHORT_model1';
end;


%try just one for now
%DSGN.subjects = filenames('/Volumes/engram/labdata/projects/r21stress/BOLD/subjects/subj_control_3029', 'absolute');
%DSGN.subjects = filenames('/Volumes/engram/labdata/projects/r21stress/BOLD/subjects/subj_exp_int_938', 'absolute');
DSGN.subjects = filenames('/Volumes/engram/labdata/projects/r21stress/BOLD/subjects/subj_*', 'absolute');


% DSGN.subjects = filenames('/dreamio3/wagerlab/labdata/current/ilcp/Imaging/ilcp*_S*_OC*');
DSGN.funcnames = {'Functional/Preprocessed/R21_Stress_BOLD*SHORT*/swra*.nii'};
   %do I need to use the preproc object to define these? check order
%DSGN.funcnames = {'Functional/Preprocessed/R21_Stress_BOLD*LONG*/swra*.nii'};   %Nback

DSGN.allowmissingfunc = false;
DSGN.concatenation = {[1:2]};

DSGN.allowemptycond = true;


%% PARAMETERS
DSGN.tr = 1.7;
DSGN.hpf = 180;
DSGN.fmri_t = 16;
DSGN.fmri_t0 = 1;

DSGN.ar1 = true;

DSGN.modelingfilesdir = 'spm_modeling';
%DSGN.notimemod = false;
%DSGN.multireg = '../rp_aR21*';
DSGN.multireg = 'noise_model_1';



%% MODELING (task conditions, noise regressors, etc)
condfile = load('r21_conditions.mat');
for i=1:numel(condfile.names)
    DSGN.conditions{1}{i} = condfile.names{i};
    
    if PARAMETRIC
        for j=1:numel(condfile.pmod_names)
            if ~isempty( strfind(condfile.pmod_names{j}, condfile.names{i} ) )  %if pmod condition corresponds
                DSGN.pmods{1}{i} = condfile.pmod_names(j);
            end;
        end;
    end;
end;

DSGN.allowemptycond = false;


if INCLUDE_CONTRASTS
%% CONTRASTS
DSGN.noscale = false;

c=0;
c=c+1; DSGN.contrasts{c} = {{'VposCONDmeSWITCHyes'}};
c=c+1; DSGN.contrasts{c} = {{'VposCONDmeSWITCHno'}};
c=c+1; DSGN.contrasts{c} = {{'VposCONDcelebSWITCHyes'}};
c=c+1; DSGN.contrasts{c} = {{'VposCONDcelebSWITCHno'}};
c=c+1; DSGN.contrasts{c} = {{'VposCONDsyllabSWITCHyes'}};
c=c+1; DSGN.contrasts{c} = {{'VposCONDsyllabSWITCHno'}};

c=c+1; DSGN.contrasts{c} = {{'VambCONDmeSWITCHyes'}};
c=c+1; DSGN.contrasts{c} = {{'VambCONDmeSWITCHno'}};
c=c+1; DSGN.contrasts{c} = {{'VambCONDcelebSWITCHyes'}};
c=c+1; DSGN.contrasts{c} = {{'VambCONDcelebSWITCHno'}};
c=c+1; DSGN.contrasts{c} = {{'VambCONDsyllabSWITCHyes'}};
c=c+1; DSGN.contrasts{c} = {{'VambCONDsyllabSWITCHno'}};

c=c+1; DSGN.contrasts{c} = {{'VnegCONDmeSWITCHyes'}};
c=c+1; DSGN.contrasts{c} = {{'VnegCONDmeSWITCHno'}};
c=c+1; DSGN.contrasts{c} = {{'VnegCONDcelebSWITCHyes'}};
c=c+1; DSGN.contrasts{c} = {{'VnegCONDcelebSWITCHno'}};
c=c+1; DSGN.contrasts{c} = {{'VnegCONDsyllabSWITCHyes'}};
c=c+1; DSGN.contrasts{c} = {{'VnegCONDsyllabSWITCHno'}};

%% valence
c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHyes' 'VposCONDmeSWITCHno' 'VposCONDcelebSWITCHyes' 'VposCONDcelebSWITCHno' 'VposCONDsyllabSWITCHyes' 'VposCONDsyllabSWITCHno' } };
DSGN.contrastnames{c} = 'vPOS';
c=c+1; DSGN.contrasts{c} = { { 'VambCONDmeSWITCHyes' 'VambCONDmeSWITCHno' 'VambCONDcelebSWITCHyes' 'VambCONDcelebSWITCHno' 'VambCONDsyllabSWITCHyes' 'VambCONDsyllabSWITCHno' } };
DSGN.contrastnames{c} = 'vAMB';
c=c+1; DSGN.contrasts{c} = { { 'VnegCONDmeSWITCHyes' 'VnegCONDmeSWITCHno' 'VnegCONDcelebSWITCHyes' 'VnegCONDcelebSWITCHno' 'VnegCONDsyllabSWITCHyes' 'VnegCONDsyllabSWITCHno' } };
DSGN.contrastnames{c} = 'vNEG';
%%
c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHyes' 'VposCONDmeSWITCHno' 'VposCONDcelebSWITCHyes' 'VposCONDcelebSWITCHno' 'VposCONDsyllabSWITCHyes' 'VposCONDsyllabSWITCHno' } ...
                             { 'VambCONDmeSWITCHyes' 'VambCONDmeSWITCHno' 'VambCONDcelebSWITCHyes' 'VambCONDcelebSWITCHno' 'VambCONDsyllabSWITCHyes' 'VambCONDsyllabSWITCHno' } };
DSGN.contrastnames{c} = 'vPOS-AMG';
c=c+1; DSGN.contrasts{c} = { { 'VnegCONDmeSWITCHyes' 'VnegCONDmeSWITCHno' 'VnegCONDcelebSWITCHyes' 'VnegCONDcelebSWITCHno' 'VnegCONDsyllabSWITCHyes' 'VnegCONDsyllabSWITCHno'  }  ...
                             { 'VambCONDmeSWITCHyes' 'VambCONDmeSWITCHno' 'VambCONDcelebSWITCHyes' 'VambCONDcelebSWITCHno' 'VambCONDsyllabSWITCHyes' 'VambCONDsyllabSWITCHno' } };
DSGN.contrastnames{c} = 'vNEG-AMG';
c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHyes' 'VposCONDmeSWITCHno' 'VposCONDcelebSWITCHyes' 'VposCONDcelebSWITCHno' 'VposCONDsyllabSWITCHyes' 'VposCONDsyllabSWITCHno' } ...
                             { 'VnegCONDmeSWITCHyes' 'VnegCONDmeSWITCHno' 'VnegCONDcelebSWITCHyes' 'VnegCONDcelebSWITCHno' 'VnegCONDsyllabSWITCHyes' 'VnegCONDsyllabSWITCHno'  } };
DSGN.contrastnames{c} = 'vPOS-NEG';

c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHyes' 'VposCONDmeSWITCHno' 'VposCONDcelebSWITCHyes' 'VposCONDcelebSWITCHno' 'VposCONDsyllabSWITCHyes' 'VposCONDsyllabSWITCHno' } ...
                             { 'VambCONDmeSWITCHyes' 'VambCONDmeSWITCHno' 'VambCONDcelebSWITCHyes' 'VambCONDcelebSWITCHno' 'VambCONDsyllabSWITCHyes' 'VambCONDsyllabSWITCHno' } ...
                             { 'VnegCONDmeSWITCHyes' 'VnegCONDmeSWITCHno' 'VnegCONDcelebSWITCHyes' 'VnegCONDcelebSWITCHno' 'VnegCONDsyllabSWITCHyes' 'VnegCONDsyllabSWITCHno'  }  };
DSGN.contrastweights{c} = [1 0 -1];
DSGN.contrastnames{c} = 'vLINEAR';


%% valence separated switch yes and no
c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHno'  'VposCONDcelebSWITCHno'  'VposCONDsyllabSWITCHno' } };
DSGN.contrastnames{c} = 'vPOS_swNO';
c=c+1; DSGN.contrasts{c} = { { 'VambCONDmeSWITCHno'  'VambCONDcelebSWITCHno'  'VambCONDsyllabSWITCHno' } };
DSGN.contrastnames{c} = 'vAMB_swNO';
c=c+1; DSGN.contrasts{c} = { { 'VnegCONDmeSWITCHno'  'VnegCONDcelebSWITCHno'  'VnegCONDsyllabSWITCHno' } };
DSGN.contrastnames{c} = 'vNEG_swNO';

c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHno'  'VposCONDcelebSWITCHno'  'VposCONDsyllabSWITCHno' } ...
                             { 'VambCONDmeSWITCHno'  'VambCONDcelebSWITCHno'  'VambCONDsyllabSWITCHno' } };
DSGN.contrastnames{c} = 'vPOS-AMG_swNO';
c=c+1; DSGN.contrasts{c} = { { 'VnegCONDmeSWITCHno'  'VnegCONDcelebSWITCHno'  'VnegCONDsyllabSWITCHno' } ...
                             { 'VambCONDmeSWITCHno'  'VambCONDcelebSWITCHno'  'VambCONDsyllabSWITCHno' } };
DSGN.contrastnames{c} = 'vNEG-AMB_swNO';
c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHno'  'VposCONDcelebSWITCHno'  'VposCONDsyllabSWITCHno' } ...
                             { 'VnegCONDmeSWITCHno'  'VnegCONDcelebSWITCHno'  'VnegCONDsyllabSWITCHno' } };
DSGN.contrastnames{c} = 'vPOS-NEG_swNO';

%skipped switch yes for now
% c=c+1; DSGN.contrasts{c} = {{ { 'VposCONDmeSWITCHyes' 'VposCONDcelebSWITCHyes' 'VposCONDsyllabSWITCHyes' } }
% c=c+1; DSGN.contrasts{c} = {{ { 'VambCONDmeSWITCHyes' 'VambCONDcelebSWITCHyes' 'VambCONDsyllabSWITCHyes' } }
% c=c+1; DSGN.contrasts{c} = {{ { 'VnegCONDmeSWITCHyes' 'VnegCONDcelebSWITCHyes' 'VnegCONDsyllabSWITCHyes' } }

%% attribution
c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHyes'     'VposCONDmeSWITCHno'     'VambCONDmeSWITCHyes'     'VambCONDmeSWITCHno'     'VnegCONDmeSWITCHyes'     'VnegCONDmeSWITCHno' } };
DSGN.contrastnames{c} = 'cME';
c=c+1; DSGN.contrasts{c} = { { 'VposCONDcelebSWITCHyes'  'VposCONDcelebSWITCHno'  'VambCONDcelebSWITCHyes'  'VambCONDcelebSWITCHno'  'VnegCONDcelebSWITCHyes'  'VnegCONDcelebSWITCHno' } };
DSGN.contrastnames{c} = 'cYOU';
c=c+1; DSGN.contrasts{c} = { { 'VposCONDsyllabSWITCHyes' 'VposCONDsyllabSWITCHno' 'VambCONDsyllabSWITCHyes' 'VambCONDsyllabSWITCHno' 'VnegCONDsyllabSWITCHyes' 'VnegCONDsyllabSWITCHno' } };
DSGN.contrastnames{c} = 'cSYLL';

c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHyes'     'VposCONDmeSWITCHno'     'VambCONDmeSWITCHyes'     'VambCONDmeSWITCHno'     'VnegCONDmeSWITCHyes'     'VnegCONDmeSWITCHno' } ...
                             { 'VposCONDsyllabSWITCHyes' 'VposCONDsyllabSWITCHno' 'VambCONDsyllabSWITCHyes' 'VambCONDsyllabSWITCHno' 'VnegCONDsyllabSWITCHyes' 'VnegCONDsyllabSWITCHno' } };
DSGN.contrastnames{c} = 'cME-SYLL';
c=c+1; DSGN.contrasts{c} = { { 'VposCONDcelebSWITCHyes'  'VposCONDcelebSWITCHno'  'VambCONDcelebSWITCHyes'  'VambCONDcelebSWITCHno'  'VnegCONDcelebSWITCHyes'  'VnegCONDcelebSWITCHno' } ...
                             { 'VposCONDsyllabSWITCHyes' 'VposCONDsyllabSWITCHno' 'VambCONDsyllabSWITCHyes' 'VambCONDsyllabSWITCHno' 'VnegCONDsyllabSWITCHyes' 'VnegCONDsyllabSWITCHno' } };
DSGN.contrastnames{c} = 'cYOU-SYLL';
c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHyes'     'VposCONDmeSWITCHno'     'VambCONDmeSWITCHyes'     'VambCONDmeSWITCHno'     'VnegCONDmeSWITCHyes'     'VnegCONDmeSWITCHno' } ...
                             { 'VposCONDcelebSWITCHyes'  'VposCONDcelebSWITCHno'  'VambCONDcelebSWITCHyes'  'VambCONDcelebSWITCHno'  'VnegCONDcelebSWITCHyes'  'VnegCONDcelebSWITCHno' } };
DSGN.contrastnames{c} = 'cME-YOU';


%% attribution separated switch yes and no
c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHno'      'VambCONDmeSWITCHno'      'VnegCONDmeSWITCHno' } };
DSGN.contrastnames{c} = 'cME_swNO';
c=c+1; DSGN.contrasts{c} = { { 'VposCONDcelebSWITCHno'   'VambCONDcelebSWITCHno'   'VnegCONDcelebSWITCHno' } };
DSGN.contrastnames{c} = 'cYOU_swNO';
c=c+1; DSGN.contrasts{c} = { { 'VposCONDsyllabSWITCHno'  'VambCONDsyllabSWITCHno'  'VnegCONDsyllabSWITCHno' } };
DSGN.contrastnames{c} = 'cSYLL_swNO';

c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHno'      'VambCONDmeSWITCHno'      'VnegCONDmeSWITCHno' } ...
                             { 'VposCONDsyllabSWITCHno'  'VambCONDsyllabSWITCHno'  'VnegCONDsyllabSWITCHno' } };
DSGN.contrastnames{c} = 'cME-SYLL_swNO';
c=c+1; DSGN.contrasts{c} = { { 'VposCONDcelebSWITCHno'   'VambCONDcelebSWITCHno'   'VnegCONDcelebSWITCHno' } ...
                             { 'VposCONDsyllabSWITCHno'  'VambCONDsyllabSWITCHno'  'VnegCONDsyllabSWITCHno' } };
DSGN.contrastnames{c} = 'cYOU-SYLL_swNO';
c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHno'      'VambCONDmeSWITCHno'      'VnegCONDmeSWITCHno' } ...
                             { 'VposCONDcelebSWITCHno'   'VambCONDcelebSWITCHno'   'VnegCONDcelebSWITCHno' } };
DSGN.contrastnames{c} = 'cME-YOU_swNO';

%skipped switch yes for now
% c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHyes'     'VambCONDmeSWITCHyes'     'VnegCONDmeSWITCHyes'  } };
% c=c+1; DSGN.contrasts{c} = { { 'VposCONDcelebSWITCHyes'  'VambCONDcelebSWITCHyes'  'VnegCONDcelebSWITCHyes' } };
% c=c+1; DSGN.contrasts{c} = { { 'VposCONDsyllabSWITCHyes' 'VambCONDsyllabSWITCHyes' 'VnegCONDsyllabSWITCHyes' } };


%% all switch vs. no switch
c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHyes' 'VposCONDcelebSWITCHyes' 'VposCONDsyllabSWITCHyes'  'VambCONDmeSWITCHyes' 'VambCONDcelebSWITCHyes' 'VambCONDsyllabSWITCHyes' 'VnegCONDmeSWITCHyes' 'VnegCONDcelebSWITCHyes' 'VnegCONDsyllabSWITCHyes' } };
DSGN.contrastnames{c} = 'swYES';
c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHno'  'VposCONDcelebSWITCHno'  'VposCONDsyllabSWITCHno'   'VambCONDmeSWITCHno'  'VambCONDcelebSWITCHno'  'VambCONDsyllabSWITCHno'  'VnegCONDmeSWITCHno'  'VnegCONDcelebSWITCHno'  'VnegCONDsyllabSWITCHno'  } };
DSGN.contrastnames{c} = 'swNO';

c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHyes' 'VposCONDcelebSWITCHyes' 'VposCONDsyllabSWITCHyes'  'VambCONDmeSWITCHyes' 'VambCONDcelebSWITCHyes' 'VambCONDsyllabSWITCHyes' 'VnegCONDmeSWITCHyes' 'VnegCONDcelebSWITCHyes' 'VnegCONDsyllabSWITCHyes' } ...
                             { 'VposCONDmeSWITCHno'  'VposCONDcelebSWITCHno'  'VposCONDsyllabSWITCHno'   'VambCONDmeSWITCHno'  'VambCONDcelebSWITCHno'  'VambCONDsyllabSWITCHno'  'VnegCONDmeSWITCHno'  'VnegCONDcelebSWITCHno'  'VnegCONDsyllabSWITCHno'  } };
DSGN.contrastnames{c} = 'swYES-NO';

%% switch for just attribution
c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHyes' 'VposCONDcelebSWITCHyes' 'VambCONDmeSWITCHyes'  'VambCONDcelebSWITCHyes'  'VnegCONDmeSWITCHyes'  'VnegCONDcelebSWITCHyes' } };
DSGN.contrastnames{c} = 'cATTRIB_swYES';
c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHno'  'VposCONDcelebSWITCHno'  'VambCONDmeSWITCHno'   'VambCONDcelebSWITCHno'   'VnegCONDmeSWITCHno'   'VnegCONDcelebSWITCHno' } };
DSGN.contrastnames{c} = 'cATTRIB_swNO';

c=c+1; DSGN.contrasts{c} = { { 'VposCONDmeSWITCHyes' 'VposCONDcelebSWITCHyes' 'VambCONDmeSWITCHyes'  'VambCONDcelebSWITCHyes'  'VnegCONDmeSWITCHyes'  'VnegCONDcelebSWITCHyes' } ...
                             { 'VposCONDmeSWITCHno'  'VposCONDcelebSWITCHno'  'VambCONDmeSWITCHno'   'VambCONDcelebSWITCHno'   'VnegCONDmeSWITCHno'   'VnegCONDcelebSWITCHno' } };
DSGN.contrastnames{c} = 'cATTRIB_swYES-NO';

end;

save(modelname,'DSGN')