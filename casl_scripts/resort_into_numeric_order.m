function filelist = resort_into_numeric_order(input_filelist)

if iscell(input_filelist), input_filelist = char(input_filelist{:}); end

for i = 1:size(input_filelist, 1)

    % this may not work well if full paths are not entered.
    [dd, ff] = fileparts(input_filelist(i, :));
    [dd, ff] = fileparts(dd);
    str = regexprep(ff, '.*Postupgrade', '');
    str = regexprep(str, '_1$', '');
    [nums{i},whnums] = nums_from_text(str);
    
end

nums = cat(1, nums{:});

[~, indx] = sort(nums, 'ascend');

filelist = input_filelist(indx, :);

end % function

