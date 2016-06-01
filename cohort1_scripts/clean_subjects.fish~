#!/usr/local/bin/fish

cd /Volumes/engram/labdata/projects/r21stress/BOLD/subjects

find subj* -maxdepth 1 -mindepth 1 -type d | grep -v "Functional" | grep -v "Structural" | grep -v "raw" | parallel rm -r
find subj* -maxdepth 1 -type f | parallel rm
ls -1d --color=never subj*/Functional/* | grep -v Raw | parallel rm -r
