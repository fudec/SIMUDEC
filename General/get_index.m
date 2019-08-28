function out= get_index(handle)
global Info
handle.UserData
for i=1:length(Info)
    if strcmp(Info(i).Index,handle.UserData.Index)
        out = i;
    end
end
        
end
