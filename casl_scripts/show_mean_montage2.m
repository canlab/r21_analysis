function [] = show_mean_montage(subj_num, m, label)

create_figure(['mean ' num2str(subj_num)], 4, 1);
%display(sprintf('subject %d ', subjnumber));
for j=1:4
    %tmp = r21data.Sub_Event_Level.mean_image{i}{j};
    
    axh = subplot(4, 1, j);
    if length(m) < j || isempty(m{j})
        continue;
    end
    spacing = ceil(m{j}.volInfo.dim(3) ./ 12);
    fastmontage(m{j}, 'axial', 'spacing', spacing, 'slices_per_row', 12); % every 4th slice
    fixed_label = regexprep(label{j}, '.*Postupgrade', '');
    fixed_label = regexprep(fixed_label, '_', '-');
    title(['Subject ' num2str(subj_num) ' Run ' num2str(j) '-' fixed_label])
    clim = [-300 300];
    set(axh, 'CLim' , clim);
    drawnow;
end

snapnow;
close all;

end