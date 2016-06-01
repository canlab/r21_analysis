setup_casl_montage; % sets mean_montage_dir and subj_list 

for s = subj_list
    filename = fullfile(mean_montage_dir, mean_image_name(s));
    if ~exist(filename, 'file')
        continue;
    end
    load(filename); % loads m
    show_mean_montage2(s, m, n);
    clear m;
end
