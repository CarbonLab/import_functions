function line = RemoveComments(line)
    % Remove comments indicated by '--' or '//'
    index = strfind(line, '--');
    if ~isempty(index)
        line = strtrim(line(index(1)+2:end));
    else
        index = strfind(line, '//');
        if ~isempty(index)
            line = strtrim(line(index(1)+2:end));
        end
    end
end