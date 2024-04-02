function data = TableData(data, n, c, Vars)
data = array2table(data); % Create table
data = data(1:n,~ismissing(c(1,:))); % Remove empty rows/cols
data.Properties.VariableNames = Vars; % Variable names read from txt file
end