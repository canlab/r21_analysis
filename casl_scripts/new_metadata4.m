clear all;
load('scripts/data_object_in_progress4.mat') % using this ensures all the runs are in the same order

%% copy over subject data headers
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

%% manual correction (5 subjects of the 59 we currently have repreprocessed)

sub =  7725;
display(sprintf('Correcting %d', sub));
%i = find(r21data.Subj_Level.id == sub);
% this has runs 1 2 4 - TODO looks like the raw has run 3???
j = find(r21.Subj_Level.id == sub);
r21.Event_Level.textdata{j}{4} = r21.Event_Level.textdata{j}{3};
r21.Event_Level.textdata{j}{3} = '';

sub = 8520;
display(sprintf('Correcting %d', sub));
% matches original preprocessed list - missing run 1
j = find(r21.Subj_Level.id == sub);
r21.Event_Level.textdata{j}{4} = r21.Event_Level.textdata{j}{3};
r21.Event_Level.textdata{j}{3} = r21.Event_Level.textdata{j}{2};
r21.Event_Level.textdata{j}{2} = r21.Event_Level.textdata{j}{1};
r21.Event_Level.textdata{j}{1} = '';

sub = 9390;
display(sprintf('Correcting %d', sub));
% matches original preprocessed list - missing run 1 & 2
j = find(r21.Subj_Level.id == sub);
r21.Event_Level.textdata{j}{3} = '';
r21.Event_Level.textdata{j}{4} = '';

sub = 6711;
display(sprintf('Correcting %d', sub));
% original preprocessing had nothing for this subject!!! 
% but we have 5 runs... notes say baseline had to be restarted - skip 1st
j = find(r21.Subj_Level.id == sub);
r21.Event_Level.textdata{j}{1} = r21.Event_Level.textdata{j}{2};
r21.Event_Level.textdata{j}{2} = r21.Event_Level.textdata{j}{3};
r21.Event_Level.textdata{j}{3} = r21.Event_Level.textdata{j}{4};
r21.Event_Level.textdata{j}{4} = r21.Event_Level.textdata{j}{5};
r21.Event_Level.textdata{j}(5,:) = [];

sub = 6783;
display(sprintf('Correcting %d', sub));
% matches original preprocessed list - missing run 3
j = find(r21.Subj_Level.id == sub);
r21.Event_Level.textdata{j}{4} = r21.Event_Level.textdata{j}{3};
r21.Event_Level.textdata{j}{3} = '';

%% save
r21data = r21;
save('data_object_in_progress_5_4', 'r21data');