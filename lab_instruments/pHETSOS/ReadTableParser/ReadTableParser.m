function data = ReadTableParser(filename,Vars)
%READTABLEPARSER this is so simple and almost works perfectly. Maybe there
%are more options that could be changed to use this instead of the method
% I use in 'Parse.m'.

opts = detectImportOptions(filename);
opts.CommentStyle = '//';
opts.VariableNames = Vars;

opts.ExtraColumnsRule
data = readtable(filename,opts);
%try to make this work. will simplify everything greatly
end

% Adding comment to main branch

% Jacki testing adding comment for Ben's reivew 20 March 2024
