setup_casl_montage;

opts = struct('useNewFigure', false, 'maxHeight', 800, 'maxWidth', 500, ...
    'outputDir', mean_montage_dir, 'showCode', false);
file = publish('new_casl_mean_montage', opts);
web(file)
