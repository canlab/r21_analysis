% subjects r21data.Subj_Level.data(subjnum, 1) == 2
clear all;
load('scripts/data_object_in_progress4.mat') % using this ensures all the runs are in the same order
r21 = r21data;
for subjnum=1:length(r21data.Subj_Level.id)
    if r21data.Subj_Level.data(subjnum, 1) == 2
        r21.Sub_Event_Level.textdata{subjnum} = {};
        r21.Sub_Event_Level.data{subjnum} = {};
        for runnum=1:4
            dir = r21data.Sub_Event_Level.textdata{subjnum}{runnum,2};
            if ~isempty(dir)
                dir = regexprep(dir, '.*Stress/', ''); % works for stress subjes only
                dir = regexprep(dir, '.*CONTROL/', '');
                dir = regexprep(dir, '.*Intervention/', '');
                disp(dir);
                PVEc = filenames(fullfile('Cohort2',dir,'PVEc*'));
                if isempty(PVEc)
                    disp('CANNOT FIND PVEc');
                else
                    % TODO MAKE SURE TO GET ANY PVEc FILES FOR RUNS THAT WERE
                    % NOT PREPROCESSED BEFORE!!! or are we not getting any
                    % runs we were missing before? -yup see i = 47 (7175)
                    r21.Sub_Event_Level.textdata{subjnum}{runnum,1} = PVEc{1}; % TODO PRESERVE RUNS - NOT ALL HAVE 4
                end
            end
        end
    end
end
r21.Sub_Event_Level.names = 'CASLImage';
r21.Sub_Event_Level.type = {'text'};
r21.Sub_Event_Level.descrip = {'relative path to PVEc image'};
r21data = r21;
save('data_object_in_progress_5_1', 'r21data');