function ColNames = extractColumnNames(filename)
    % Open the file for reading
    fid = fopen(filename, 'r');
    if fid == -1
        error('Unable to open file: %s', filename);
    end
    
    % Initialize lineNumber
    lineNumber = 0;
    
    % Read lines from file
    while true
        line = fgetl(fid);
        lineNumber = lineNumber + 1;
        if line == -1
            break; % End of file reached
        end
        if contains(line, '//') || isempty(line)
            continue; % Skip commented or empty lines
        end
        if ~contains(line, '//')  % Stop at header line
            break; % Header found
        end
    end
    
    % Close the file
    fclose(fid);
    
    % Read the header line from the file
    d = readlines(filename);
    ColNames = d(lineNumber);
    
    % Split the header line into column names
    ColNames = cellstr(strtrim(strsplit(ColNames, '\t')));

% BAND AID!!!!! BAND AID!!!!! BAND AID!!!!! BAND AID!!!!! BAND AID!!!!!
str = fileread(filename);
Pmfet_nano = contains(str,'MFET') && contains(str,'NanoFET');
if Pmfet_nano == 1

     ColNames = {'SampNum','MM/DD/YYYY HH:MM:SS','VbatMain',...
         'VbiasPos','VbiasNeg','TC_cont','Humidity','Vrse','Vrse_std',...
         'Vk','Vk_std','Ik','Ib','SampNum_nano',...
         'MM/DD/YYYY HH:MM:SS_nano','VbiasPos_nano','Vrse_nano',...
         'Vrse_std_nano','Vk_nano','Vk_std_nano','Ik_nano','Ib_nano'};

end
% BAND AID!!!!! BAND AID!!!!! BAND AID!!!!! BAND AID!!!!! BAND AID!!!!!
end
