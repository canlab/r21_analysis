load data_object_in_progress_5_4.mat

td=r21data.Event_Level.textdata

for i=1:length(td)
  subjdir=fileparts(td{i}{1})
  snfile_pattern=strcat(subjdir,'/*_sn.mat')
  dirlisting=dir(snfile_pattern)
  if length(dirlisting)>1
    snfile=dirlisting(1).name
  else
    snfile=dirlisting.name
  end
  snfiles{i}=snfile
end

save('snfiles.mat',snfiles)
  
