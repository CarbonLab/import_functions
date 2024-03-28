function data = TableData(data, n, c, Vars)
data = array2table(data); % Create table
data = data(1:n,~ismissing(c(1,:))); % Remove empty rows/cols
data.Properties.VariableNames = Vars; % Variable names read from txt file

% add var descriptions, type (double, str, etc), units, etc...

% Maybe one function/routine for every possible variable (~36) that
% converts the data into the correct var type. This function checks if it
% is present and then adds to table.
% Example:
% CheckSampNum1(data);
% if contains(data.SampTime1) 
%   --> data.SampTime1 = datetime(data.SampTime1);
% end

end