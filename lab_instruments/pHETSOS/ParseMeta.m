% Initialize variables
fid = FileOpen(filename); % Open file
Vars = VarNames(filename); % Load in correct variable names

estlength = length(readlines(filename)); % est final size reduces calc time
estwidth = 100; % arbitrary
meta = cell(estlength,estwidth);
m = 0;
%use fgetl to read the data
while true
    line = fgetl(fid);
    if contains(line,'--**')
        break;
    end
    % parse data
    if isempty(line) || contains(line,'++**')
        continue;
    elseif ~contains(line,'= ')
        m = m+1;
        line = RemoveComments(line);
        d = strtrim(strsplit(line,'\t'));
        meta(m,1:length(d)) = d;
    elseif contains(line, '= ')
        m = m+1;
        line = RemoveComments(line);
        d = ParseParams(line);
        meta(m,1:length(d)) = d;
    end
meta = meta(1:m,1:3);
% meta = cell2table(meta,VariableNames={'Parameter','Equipped','Comments'});
close('all')
end