function Eliminar_modulo_mo(source,~)

global cu Info  cumc cuh sp

x=getappdata(source,'Index');

for i=1:cu-1
    if ~strcmp(Info(i).tag,'Flujo') && ~strcmp(Info(i).tag,'Entrada')
        try
            if isequal(getappdata(Info(i).h.UIContextMenu.Children(3),'Index'),x) == 1
                k=i;
            end
        catch
        end
    end
end

delete(Info(k).h.UserData.points);

% if strcmp(Info(k).tag,'Hidrociclon') ==1 || strcmp(Info(k).tag,'Molino Convencional') ==1
%     1
%     delete(Info(k).h.UserData.image);
% end
delete(Info(k).h);

% if strcmp(Info(x).tag,'Entrada')== 1 
%     e=e-1;
% elseif strcmp(Info(x).tag,'Flujo')== 1 
%     cuf=cuf-1;
% end

if strcmp(Info(k).tag,'Hidrociclon')
    cuh=cuh-1;
elseif strcmp(Info(k).tag,'Tromel')
    sp=sp-1;
elseif strcmp(Info(k).tag,'Tamiz')
    sp=sp-1;
elseif strcmp(Info(k).tag,'Spliter')
    sp=sp-1;
elseif strcmp(Info(k).tag,'Molino Convencional')
    cumc=cumc-1;
end

for i=1:cu-1
    if i > k
        Info(i).c=Info(i).c-1;
    end
end
if length(Info) == 1
    Info =[];
else 
    Info(k)=[];
end
cu=cu-1;
end