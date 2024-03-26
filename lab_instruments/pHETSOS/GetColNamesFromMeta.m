fid = fopen(filename, 'r');
if fid == -1
    error('Unable to open file: %s', filename);
end

% Initialize variables
data = {};
lineNumber = 0;
% Read lines from file
while true
    line = fgetl(fid);
    if line == -1
        break;
    end
    if contains(line,'//--')
        break
    end
    % Remove comments
    line = RemoveComments(line);

    parts = split(line, '= ', 2);
    if numel(parts) == 1
        continue; % Skip lines that don't have ' = ' delimiter
    elseif numel(parts) == 2 && strlength(parts(2)) > 1
        c = split(parts(2), ',', 2);
        parts = [parts(1) c];
    end

    % Trim whitespace
    parameter = strtrim(parts{1});
    equipped = strtrim(parts{2});
    if numel(parts) > 2
        comments = strtrim(parts{3});
    else
        comments = '';
    end
    % save data
    lineNumber = lineNumber + 1;
    data{lineNumber, 1} = parameter;
    data{lineNumber, 2} = equipped;
    data{lineNumber, 3} = comments;
end
tbl = table(data(:,1),str2double(data(:,2)),data(:,3), 'VariableNames', {'parameter', 'equipped','comments'});

tbl_Vars = tbl(tbl.equipped==1,:);
 
for i = 1:height(tbl_Vars)
    str = tbl_Vars.parameter(i);
    if ismember(str,'Sample Num')
        continue
    elseif ismember(str,'MM/DD/YYYY HH:MM:SS')
        tbl_Vars.parameter(i) = {'Sample Time'};
        continue
    elseif ismember(str,'Battery Volt')
        tbl_Vars.parameter(i) = {'V_main'};
        continue
    elseif ismember(str,'Bias Battery Pos')
        tbl_Vars.parameter(i) = {'V_Bias_Pos'};
        continue
     elseif ismember(str,'Bias Battery Neg')
        tbl_Vars.parameter(i) = {'V_Bias_Neg'};
        continue
    %elseif % go through all cases. If we have oxy or ctd whatever add new
    %variables and name them correctly. For example if 'Optode' then add
    %vars: {'Opt_PN','Opt_SN','Moxy','O2satper','TC_opt','Dphase','Bphase','Rphase','Bamp','Bpot','Ramp','Opt_rawtemp'}'
    %likewise for ctd and if nano is equipped.
    end
end