function fid = FileOpen(filename)
fid = fopen(filename, 'r'); % File identifier
if fid == -1
    error('Unable to open file: %s', filename);
end
end