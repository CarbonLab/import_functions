function GetMfetData(filename)
% Parse data generated from the mfet/nano. Input .txt file.
% Output is a data table and a cell array of meta data.
% Ben Werb | Bwerb@mbari.org | 3/19/2024.
if nargin < 1
    filename = uigetfile('*.txt',...
               'Select a .txt file'); % User can select file
end
fid = FileOpen(filename); % Open file
Vars = extractColumnNames(filename); % Read column names from file
[data, n, c] = ParseData(fid,filename); % Read data
data = TableData(data, n, c, Vars); % Format data in table
data = convertTableStrings(data); % Convert strings to correct var type
meta = ParseMeta(filename); % Read meta data. Complete this function

assignin("base","data",data);
assignin("base","meta",meta);

end