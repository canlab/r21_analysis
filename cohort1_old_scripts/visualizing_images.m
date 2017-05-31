imgs = filenames('*.img', 'char', 'absolute');

all_imgs = expand_4D_filenames(imgs, [106]);

%%

clear all

load image_names
%%
spm_check_registration(char(all_imgs(1:6,:)))

%%
spm_orthviews('window', 1:6, [10 50])