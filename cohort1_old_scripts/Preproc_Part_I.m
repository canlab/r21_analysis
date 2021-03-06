%% SCN SPIKE ID

% Go to the directory where the functional images are for a single subject:
cd /Volumes/Cort/Imaging/CORT/cort2121

% Specify a UNIX-style wildcard for listing the filenames of your
% functional runs:
my_image_wildcard = 'cort*rsense*img';

% Get the filename list and store in imgs variable.  Show us the names so
% we can check them:
% NOTES:
% - For the one-line code below to work, there should be ONE 4-D image per run!
% - If not, you need 3-D images for each RUN in a separate CELL of imgs

imgs = filenames(my_image_wildcard, 'absolute'); disp(char(imgs{:}))

diary qc_report.txt
[g, spikes, gtrim, nuisance_covs, snr] = scn_session_spike_id(imgs);
diary off

%% Loop example

cd /Volumes/Cort/Imaging/CORT/

my_image_wildcard = 'cort*rsense*img';

d = dir('cort*');

for i = 6:length(d)  % subject loop

    % if this is a directory
    if d(i).isdir

        % go to it
        cd(d(i).name)

        imgs = filenames(my_image_wildcard, 'absolute'); disp(char(imgs{:}))

        if ~isempty(imgs)
            
            diary qc_report.txt

            [g, spikes, gtrim, nuisance_covs, snr] = scn_session_spike_id(imgs);
            
            diary off

        else
            disp('Directory does not have images in it!')
        end

        % go back up
        cd ..

    end
    
end



%%  PREPROC PART 1 - SEAT and N-BACK tasks

% Go to the directory where the functional images are for a single subject:
cd /Volumes/r21stress/Imaging/

% Specify a UNIX-style wildcard for listing the filenames of your
% functional runs:
my_image_wildcard = 'cort*rsense*img';  % special for SEAT and N-Back tasks : example, as all input params are!

% Get the filename list and store in imgs variable.  Show us the names so
% we can check them:
% NOTES:
% - For the one-line code below to work, there should be ONE 4-D image per run!
% - If not, you need 3-D images for each RUN in a separate CELL of imgs
diary qc_report.txt

%imgs = filenames(my_image_wildcard, 'absolute'); disp(char(imgs{:}))
imgs = '/Volumes/r21stress/Imaging/Pilot_1004/R21_pilot_4_1004__nback_1_5_1.img'
disp(char(imgs{:}))

PREPROC.func_files = imgs;
PREPROC.TR = 1.7;
PREPROC.num_vols_per_run = [306] %210 210 210 270 270 270 270];  


[preprocessed_files mean_image_name] = preproc_part1(PREPROC, ...
    'verbose', 1, 'save plots', 1);
diary off

print('-dpsc2', '-append', 'qc_report'); 
%%

% The file called "sn.mat" contains warping parameters that we can apply to
% new images.
% e.g., cort_1523_30072008_mprage1x1x1sens_6368v4_seg_sn.mat

mysnfile = filenames('*seg_sn*mat', 'absolute', 'char')

