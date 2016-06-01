% Prep model 1

% Correlation between CASL Time 2 - 1 (Threat - Baseline) and EMP31 (Threat- Baseline)

[dat, datcell, wh_level, descrip] = get_var(r21data, {'group' 'cd31_log_1' 'cd31_log_2 '});

%  select which subjects
sid = r21data.Subj_Level.id;
% kludge - fix!!
sid = sid(1:end-1);

x = [dat];
wh = all(~isnan(x), 2);                 % wh = which good subjects, behavioral data

fprintf('%d subjects out of %d with behavioral data intact.\n', sum(wh),length(wh));

% get all relevant images 
for i = 1:length(sid)
    if isempty(r21data.Sub_Event_Level.textdata{i})
        imgs{i} = {};
        wh(i) = 0;
        
    else
        %imgs{i} = r21data.Sub_Event_Level.textdata{i}(:, 5)';
        
        % select images for this analysis -- comparison between run 1 and 2
        % change here for different analysis
        %imgs2{i} = imgs{i}(1:2);
      imgs2{i}={r21data.Sub_Event_Level.textdata{i}{1:2}};
      
        if any(cellfun(@isempty, imgs2{i}))  % some missing images - exclude
            wh(i) = 0;
        end
        
    end % end if
    
end

fprintf('%d subjects with imaging and behavioral data intact.\n', sum(wh));

%wh = wh & ~cellfun(@isempty, imgs);     % exclude from wh those with no imaging data; NOT NECESSARY

% Keep only valid subjects
dat = dat(wh, :);
imgs2 = imgs2(wh);

%% Set up image files
% % Difference: Speech - baseline Contrast images - one for each subject
% Groupdiff is an object with one S-B CASL image per subject

n = length(imgs2);

groupdiff = fmri_data(imgs2{1}{2});  % Placeholder object - CASL image for Speech -comparison between run 1 and 2
        % change here for different analysis

for i = 1:n
    %comparison between run 1 and 2 change here for different analysis
    m2 = mean(fmri_data(imgs2{i}{2}));  % mean CASL image for Speech 
    m1 = mean(fmri_data(imgs2{i}{1}));  % mean CASL image for Baseline
    mcon = m2;
    mcon.dat = mcon.dat - m1.dat;           % Difference: Speech - baseline
    
    groupdiff.dat(:, i) = mcon.dat;         % voxels x subjects, difference maps
    
end

%% Analysis 1 Run analyses with Speech - Baseline

d1 = 'ANCOVA model: ';
d2 = '1. Speech - Baseline EMP correlated with (predicting) brain Speech - Baseline';
d3 = '2. (Intercept) : Speech - Baseline across all subjects';
modeldescrip = sprintf('%s\n%s\n%s\n', d1, d2, d3);

regnames{1} = 'Speech - Baseline EMP-brain correlation';
regnames{2} = 'Speech - Baseline Brain';

% design matrix
X = scale(dat(:, 3) - dat(:, 2), 1);            % Speech - Baseline EMP, mean-centered
groupdiff.X = X;

disp(modeldescrip)

% Run standard multiple regression
out = regress(groupdiff);

% FDR Threshold
disp('FDR THRESHOLDED')
disp(modeldescrip)
t = threshold(out.t, .05, 'fdr');

disp('0.001 UNCORRECTED')
disp(modeldescrip)
t = threshold(out.t, .001, 'unc');

disp('0.05 UNCORRECTED')
disp(modeldescrip)
t = threshold(out.t, .05, 'unc');

% orthviews(t); % methods(t); % etc.
o2 = montage(t);                                % create a montage, with handle to object o2

% Label the figures
axes(o2.montage{2}.axis_handles)
axis on; set(gca, 'Color', 'w');
xlabel(regnames{1});

axes(o2.montage{4}.axis_handles)
axis on; set(gca, 'Color', 'w');
xlabel(regnames{2});

%% Analysis 2

% Select only stress subjects, EMP-brain correlation
% ANCOVA center EMPs within stress group, 1. Emp-brain across all, within group (stress); add other groups;

%
whgroup = dat == 2;
stressgroup = groupdiff;
stressgroup.dat = stressgroup.dat(:, whgroup);

d1 = 'ANCOVA model: ';
d2 = '1. Speech - Baseline EMP correlated with (predicting) brain Speech - Baseline';
d3 = '2. (Intercept) : Speech - Baseline across stress subjects only';
modeldescrip = sprintf('%s\n%s\n%s\n', d1, d2, d3);

regnames{1} = 'Speech - Baseline EMP-brain correlation';
regnames{2} = 'Speech - Baseline Brain';

% design matrix
X = scale(dat(whgroup, 3) - dat(whgroup, 2), 1);            % Speech - Baseline EMP, mean-centered -- DOUBLE CHECK ON THE MEAN CENTERING PART
stressgroup.X = X;

disp(modeldescrip)

% Run standard multiple regression
out = regress(stressgroup);

%% Analysis 3:  adding in 2. group effect, 3. interaction

d1 = 'ANCOVA model: ';
d2 = '1. Speech - Baseline EMP correlated with (predicting) brain Speech - Baseline';
d3 = '2. (Intercept) : Speech - Baseline across all subjects';
d4 = '3. Group predicting brain Speech - Baseline';
d5 = '4. Group x EMP interaction predicitng brain Speech - Baseline';
modeldescrip = sprintf('%s\n%s\n%s\n', d1, d2, d3, d4, d5);

groupdiff_interxn = groupdiff;

regnames{1} = 'Speech - Baseline EMP-brain correlation';
regnames{2} = 'Speech - Baseline Brain';
regnames{3} = 'Speech - Baseline Brain: Group effects';
regnames{4} = 'Speech - Baseline Brain: Group x EMP interaction';

% design matrix
X = scale(dat(:, 3) - dat(:, 2), 1);            % Speech - Baseline EMP, mean-centered
X = scale(dat(:, 3) - dat(:, 2), 1);            % EMP Speech - Baseline mean-centered
X(:, 2) = (dat(:, 1) == 2) - (dat(:, 1) == 1);  % Stress group vs. Control group 
X(:, 3) = X(:, 1) .* X(:, 2);                   % Interaction
groupdiff_interxn.X = X;

disp(modeldescrip)

% Run standard multiple regression
out = regress(groupdiff_interxn);




