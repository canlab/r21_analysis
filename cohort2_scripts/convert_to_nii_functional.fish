#!/usr/local/bin/fish

set -l original (pwd)

for parfile in $argv
	set -l parfile_dir (dirname $parfile)
	set -l parfile_name (gbasename $parfile)
	set -l parfile_basename (gbasename $parfile .PAR)
	pushd $parfile_dir
	set -l niifile_dir ../Functional/Raw/$parfile_basename
	mkdir -p $niifile_dir
	echo Converting $parfile ...
	dcm2niix -o $niifile_dir -f $parfile_basename $parfile_name
	popd
end
