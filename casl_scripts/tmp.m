basedir = '/Volumes/engram/labdata/current/r21stress';
cohort1dir = '/Cohort1/Imaging/CASL/';
cohort2dir = '/Cohort2/Cohort2/Imaging/CASL/';
control = 'Control_*';
exp = 'Exp*';
percent = '*/percent_change*.nii';
wconv = '*/*wconventional*';
% 
% cohort1_controls_percent = filenames_struct_casl_summary( [basedir '/Cohort1/Imaging/CASL/Controls'], 'Control_*', '*/percent_change*.nii');
% cohort1_stress_percent = filenames_struct_casl_summary( [basedir '/Cohort1/Imaging/CASL/Experimentals/Stress'], 'Experimental_*', '*/percent_change*.nii');
% cohort1_intervention_percent = filenames_struct_casl_summary( [basedir '/Cohort1/Imaging/CASL/Experimentals/Stress+Intervention'], 'Exp*', '*/percent_change*.nii');
% cohort1_controls_wconv = filenames_struct_casl_summary( [basedir '/Cohort1/Imaging/CASL/Controls'], 'Control_*', '*/*wconventional*');
% cohort1_stress_wconv = filenames_struct_casl_summary( [basedir '/Cohort1/Imaging/CASL/Experimentals/Stress'], 'Experimental_*', '*/*wconventional*');
% cohort1_intervention_wconv = filenames_struct_casl_summary( [basedir '/Cohort1/Imaging/CASL/Experimentals/Stress+Intervention'], 'Exp*', '*/*wconventional*');op
% 


cohort1_controls_percent = filenames_struct_casl_summary( [basedir cohort1dir 'Controls'], control, percent);
cohort1_stress_percent = filenames_struct_casl_summary( [basedir cohort1dir 'Experimentals/Stress'], exp, percent);
cohort1_intervention_percent = filenames_struct_casl_summary( [basedir cohort1dir 'Experimentals/Stress+Intervention'], exp, percent);
cohort1_controls_wconv = filenames_struct_casl_summary( [basedir cohort1dir 'Controls'], control, wconv);
cohort1_stress_wconv = filenames_struct_casl_summary( [basedir cohort1dir 'Experimentals/Stress'], exp, wconv);
cohort1_intervention_wconv = filenames_struct_casl_summary( [basedir cohort1dir 'Experimentals/Stress+Intervention'], exp, wconv);