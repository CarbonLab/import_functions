function [data, n, c] = ParseData(fid,filename)

% Initialize variables
estlength = length(readlines(filename)); % est final size reduces calc time
estwidth = 100; % arbitrary
data = cell(estlength,estwidth);
n = 0;
%use fgetl to read the data
while true
    line = fgetl(fid);
    if line == -1
        break;
    end
    % parse data
    if isempty(line) || contains(line,'SampNum') || contains(line,'//')...
            || contains(line,'#0000000') % remove 0th sample
        continue;
    else
        n=n+1;
        c = strtrim(strsplit(line,'\t'));
        data(n,1:length(c)) = c;
    end

close('all')
end
end