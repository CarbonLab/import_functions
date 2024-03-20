function data = ReadTableParser(filename)
%READTABLEPARSER this is so simple and almost works perfectly. Maybe there
%are more options that could be changed to use this instead of the method
% I use in 'Parse.m'.
data = readtable(filename,CommentStyle='//');
end

% Jacki testing adding comment for Ben's reivew 20 March 2024

