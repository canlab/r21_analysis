% subjects r21data.Subj_Level.data(subjnum, 1) == 2
clear all;
load('scripts/data_object_in_progress4.mat') % using this ensures all the runs are in the same order
%r21 = r21data;
%%
r21 = canlab_dataset();
r21.Subj_Level.names = r21data.Subj_Level.names;
r21.Subj_Level.type = r21data.Subj_Level.type;
r21.Subj_Level.descrip = r21data.Subj_Level.descrip;

%% cohort 2 
subjects = filenames(fullfile('Cohort2', '*'));

for sub = 1:length(subjects)
    clear subnum oldidx newidx pvec runs runnums runorder;
    %disp(subjects(sub))
    subnum = regexprep(subjects(sub), '.*_', '');
    subnum = str2num(subnum{1});
    disp(subnum);
    %disp('...')
    oldidx = find(r21data.Subj_Level.id == subnum);
    newidx = length(r21.Subj_Level.id) + 1; % this will let me append Cohort 1 as well
    r21.Subj_Level.id(newidx) = subnum;
    r21.Subj_Level.data(newidx,:) = r21data.Subj_Level.data(oldidx,:);
    pvec = filenames(fullfile('Cohort2', ['*' num2str(subnum)], '*', 'PVEc*'));
    runs = regexprep(pvec, {'.*Postupgrade_' '_1/PVEc.*'}, {'' ''});
    runs = regexprep(runs, '_', ''); % some have extra _
    for k = 1:length(runs)
        runnums(k) = str2num(runs{k});
    end
    [~, runorder] = sort(runnums);
    if length(runorder) ~= 4
        disp('WARNING. DID NOT FIND 4 RUNS. THEY MAY NOT BE SORTED CORRECTLY. REVIEW MANUALLY.')
    end
    for k=1:length(runorder)
        r21.Event_Level.textdata{newidx}{k, 1} = pvec{runorder(k)};
    end
end


%% cohort 1
subjects = filenames(fullfile('Cohort1', '*', '*'));

for sub = 1:length(subjects)
    clear subnum oldidx newidx pvec runs runnums runorder;
    %disp(subjects(sub))
    subnum = regexprep(subjects(sub), '.*_', '');
    subnum = str2num(subnum{1});
    disp(subnum);
    %disp('...')
    oldidx = find(r21data.Subj_Level.id == subnum);
    newidx = length(r21.Subj_Level.id) + 1; % this will let me append Cohort 1 as well
    r21.Subj_Level.id(newidx) = subnum;
    r21.Subj_Level.data(newidx,:) = r21data.Subj_Level.data(oldidx,:);
    pvec = filenames(fullfile(subjects{sub}, '*', 'PVEc*')); % filenames(fullfile('Cohort2', ['*' num2str(subnum)], '*', 'PVEc*'));
    runs = regexprep(pvec, {'.*Postupgrade_' '_1/PVEc.*'}, {'' ''});
    runs = regexprep(runs, '_', ''); % some have extra _
    for k = 1:length(runs)
        runnums(k) = str2num(runs{k});
    end
    [~, runorder] = sort(runnums);
    if length(runorder) ~= 4
        disp('WARNING. DID NOT FIND 4 RUNS. THEY MAY NOT BE SORTED CORRECTLY. REVIEW MANUALLY.')
    end
    for k=1:length(runorder)
        r21.Event_Level.textdata{newidx}{k, 1} = pvec{runorder(k)};
    end
end

%% save
r21data = r21;
save('data_object_in_progress_5_3', 'r21data');