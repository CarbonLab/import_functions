function data = ReadMFETNANO(filename,Vars)
data = readtable(filename,CommentStyle={'//'},...
    ExpectedNumVariables=length(Vars),ReadVariableNames=false,...
    Delimiter='\t',DatetimeType='text',Format='MM/dd/yyyy HH:mm:ss');
data.Properties.VariableNames = Vars;
ii = ~contains(data.SampNum1, '#0000000') & ~isnat(data.SampTime1);
data = data(ii,:);
end