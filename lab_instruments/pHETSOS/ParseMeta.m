function meta = ParseMeta(filename)
% Grab meta data from txt file. Output is a nx1 cell array containing all
% the meta data information.
str = fileread(filename);
iistart = strfind(str,'++**');
iiend = strfind(str,'--**');
meta = str(iistart:iiend);
meta = strsplit(meta,'//')';
end