function data = TableData(data, n, c, Vars)
data = array2table(data); % Create table
data = data(1:n,~ismissing(c(1,:))); % This is problematic
data.Properties.VariableNames = Vars; % Variable names are preset right...
% now based on the package name. GetParams function (incomplete)...
% creates variable headers based on meta data. Not sure the best way
% to handle this. Current firmware sometimes creates extra column headers 
% so cannot just read them in directly from the txt file.

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