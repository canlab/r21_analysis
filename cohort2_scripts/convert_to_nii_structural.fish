#!/usr/local/bin/fish

set -l original (pwd)

for parfile in $argv
	set -l parfile_dir (dirname $parfile)
	set -l parfile_name (gbasename $parfile)
	set -l parfile_basename (gbasename $parfile .PAR)
	pushd $parfile_dir
	set -l niifile_dir ../Structural/SPGR
	mkdir -p $niifile_dir
	dcm2niix -o $niifile_dir -f $parfile_basename $parfile_name 
	popd
end

cd $original
