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
    else 
        m = m+1;
        d = strtrim(strsplit(line,'\t'));
        meta(m,1:length(d)) = d;
    end

close('all')
end