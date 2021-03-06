basedir = '/Volumes/r21stress/Imaging/Experimentals/Stress/Experimental_5979/par_rec'
cd(basedir)
 
qcdir = fullfile(basedir, 'qc_check');
if ~exist(qcdir, 'dir'), mkdir(qcdir); end
 
 
%% List files and do prelim QC
 
run_wildcard = '*long*';
image_wildcard = '5979*nii';
 
rundirs = dir(fullfile(basedir, run_wildcard));
isnotdir = ~cat(1, rundirs.isdir);
rundirs(isnotdir) = [];
 
dirnames = char(rundirs(:).name);
nruns = length(rundirs);
fprintf('Found %3.0f run (session) directories:\n', nruns);
 

%% char array version
% n_images_per_run = zeros(nruns, 1);
% [imgs, img_wildcard] = deal(cell(nruns, 1));
%  
% for i = 1:length(rundirs)
%     % get filenames
%     img_wildcard{i} = fullfile(basedir, rundirs(i).name, image_wildcard);
%     
%     % filenames is Wagerlab SCN toolbox function
%     imgs{i} = filenames(img_wildcard{i}, 'char', 'absolute');
%     n_images_per_run(i) = size(imgs{i}, 1);
%     
%     fprintf('Run %3.0f:\t%3.0f images\t%s\n', i, n_images_per_run(i), img_wildcard{i});
% end
% disp(dirnames);

%% cell array version (joew)
imgs = {};
for i = 1:length(rundirs)
    % get filenames
    img_wildcard{i} = fullfile(basedir, rundirs(i).name, image_wildcard);
    % filenames is Wagerlab SCN toolbox function
    run_imgs = filenames(img_wildcard{i}, 'cell', 'absolute');
    n_images_per_run(i) = size(run_imgs, 1);
    fprintf('Run %3.0f:\t%3.0f images\t%s\n', i, n_images_per_run(i), img_wildcard{i});
    imgs = {imgs{:}  run_imgs{:}}'
%    imgs = {imgs{:}  run_imgs{1:5}}' %DBG joew
end
size(imgs)

%% Write output movie
% improvements: 1) use slover? 2) print to gif?
 
% myslover = struct('func', 'i1(i1==0)=NaN', 'vol', spm_vol(imgs{1}(1, :)), 'hold', 1);
% myslover = slover(imgs{1}(1, :))
% slover(myslover)
 
movieoutfile = fullfile(qcdir, 'slice_movie.tiff');
skipby = 5;
 
%figure(han);
 
for r = 1:length(imgs)
    for i = 1:skipby:size(imgs{r}, 1)
 
        han = montage_clusters(imgs{r}(i, :));
        hh = get(han, 'Children'); hh = findobj(hh, 'Type', 'Axes');
        axes(hh(hh==min(hh)));
        title(['Run ' num2str(r) ' Image ' num2str(i)]);
 
        figure(han); drawnow;
        F = getframe(gcf);
        
        if r == 1 && i == 1
            imwrite(F.cdata, movieoutfile,'tiff', 'Description', img_wildcard{1}, 'Resolution', 30);
        else
            imwrite(F.cdata, movieoutfile,'tiff', 'WriteMode', 'append', 'Resolution', 30);
        end
    end
end
 
 
%% Preproc 1
 
%% 
 
% clean up by removing intermediate files we don't want
!rm */a*img
!rm */a*hdr
 
% Save motion parameter figures
f1 = findobj('Tag', 'Graphics'); 
figure(f1); scn_export_papersetup(700)
saveas(gcf, fullfile(qcdir, 'motion_param.png'));
 
 
 


