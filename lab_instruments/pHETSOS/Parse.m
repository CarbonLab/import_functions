function data = Parse(filename)
% Parse data generated from the mfet/nano. Input .txt file.
% Output is a table of data and meta data. Need to finish ParseMeta
% function. Tested mphox, beams, mfet/nano files. Need to test more.
% Would like to make it work on prior firmware versions as well. 
% Ben Werb, Bwerb@mbari.org, 3/19/2024.

fid = FileOpen(filename); % Open file
Vars = extractColumnNames(filename); % Read column names from file
[data, n, c] = ParseData(fid,filename); % Read data
data = TableData(data, n, c, Vars); % Format data in table
data = convertTableStrings(data); % Convert strings to correct var type
% data = CleanData(data); % Add clean up function
% meta = ParseMeta(filename); % Read meta data. Complete this function
end