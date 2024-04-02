function convertedTable = convertTableStrings(data)
% Convert the columns of strings into the appropriate variable type. Either
% double or datetime. Difficult because not all datetime cols are in the
% same format and the col name changes between firmware versions. **Not
% Complete**
    % Initialize the converted table as a copy of the input
    convertedTable = data;
    
    % Get the variable names of the table
    varNames = data.Properties.VariableNames;
    
    % Loop through each variable in the table
    for i = 1:length(varNames)
        % Get the data for the current variable
        currentData = data.(varNames{i});
        
        % Check if the current variable is a string or cell array of strings
        if iscellstr(currentData) || isstring(currentData)
            % Try converting the string data to double
            numericData = str2double(currentData);
            
            % Check if the conversion was successful (no NaNs)
            if all(~isnan(numericData))
                % Update the converted table with the numeric data
                convertedTable.(varNames{i}) = numericData;
            elseif contains(varNames{i},'MM/DD/YYYY HH:MM:SS') | strcmp(varNames{i},'Sample_Time') % These col names can change so not sure how to handle this
                % Convert 'MM/DD/YYYY HH:MM:SS' column using the specified date format
                convertedTable.(varNames{i}) = datetime(currentData, 'InputFormat', 'MM/dd/yyyy HH:mm:ss');
            elseif strcmp(varNames{i},'Date_MC')
                % Convert 'Date_MC' column using the specified date format
                convertedTable.(varNames{i}) = datetime(currentData, 'InputFormat', 'dd MMM yyyy'); 
            elseif strcmp(varNames{i},'Time_MC')
                % Convert 'Time_MC' column using the specified date format
                convertedTable.(varNames{i}) = datetime(currentData, 'Format', 'HH:mm:ss');
            end
                % If conversion to datetime also fails, leave as string
        end
    end
end