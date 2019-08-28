function out = get_index_info(str)
global Info
for i=1:length(Info)
    if strcmp(Info(i).Index,str)
        out = i;
    end
end
end