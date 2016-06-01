#!/usr/local/bin/fish

find /Volumes/engram/labdata/projects/r21stress/cohort2/BOLD -type d -name 'qc_images' > dirnames.txt

set -l dirnames (cat dirnames.txt)
set -l length (count $dirnames)
set -l localdirname qc_images_cohort2
set -l bagname imagebag_cohort2

for index in (seq $length)
	set -l subname (basename (dirname $dirnames[$index]) )
	echo $subname
	mkdir -p $localdirname/$subname
	cp -r $dirnames[$index]/* $localdirname/$subname
	pushd $localdirname/$subname
	for file in *
		mv $file {$subname}_{$file}
	end
	popd
end
mkdir -p $bagname
find $localdirname -type f | parallel -j 6 cp '{}' $bagname
tar -czf $localdirname.tar.gz $bagname

