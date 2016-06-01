setup_casl_montage; % sets mean_montage_dir and subj_list 

for s = subj_list
    fprintf('%d ',s);
    filename = fullfile(mean_montage_dir, mean_image_name(s));
    if exist(filename, 'file')
        continue; % don't redo exising
    end
    
    mysubjectimages = filenames(fullfile(casl_dir, ['*' num2str(s)], '*', 'wPVEc11x11x9_delta_GM_001.nii'));% get_subject_image_list(s);
    mysubjectimages = resort_into_numeric_order(mysubjectimages);
    mysubjectimages = cellstr(mysubjectimages);
    for i = 1:length(mysubjectimages)
        if ~isempty(mysubjectimages{i})
            dat = fmri_data(mysubjectimages{i});
            m{i} = mean(dat);
            n{i} = regexprep(mysubjectimages{i}, ['.*Cohort2.*' num2str(s) '/'], '');
            n{i} = regexprep(n{i}, '/PVE.*nii', '');
        end
    end
    try
        save(filename, 'm', 'n');
    catch error
        fprintf('x ');
    end
    clear m;
end
fprintf('\n');
