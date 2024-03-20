function data = Parse(filename)
% Parse data generated from the mfet/nano. Input .txt file.
% Output is a table of data and meta data. Need to finish ParseMeta
% function. Tested mphox, beams, mfet/nano files. Need to test more.
% Would like to make it work on prior firmware versions as well. 
% Ben Werb, Bwerb@mbari.org, 3/19/2024.

fid = FileOpen(filename); % Open file
Vars = VarNames(filename); % Load in correct variable names
[data, n, c] = ParseData(fid,filename); % Read data
meta = ParseMeta(filename); % Read meta data. Complete this function
data = TableData(data, n, c, Vars); % Format data in table
%meta = TableMeta(meta); % Format meta data in table
%data = CleanData(data); % Add clean up function

end