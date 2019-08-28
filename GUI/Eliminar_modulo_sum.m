function Eliminar_modulo_sum(source,~)

global cu Info 

x=getappdata(source,'Index');

for i=1:cu-1
    if ~strcmp(Info(i).tag,'Flujo') && ~strcmp(Info(i).tag,'Entrada')
        if isequal(getappdata(Info(i).h.UIContextMenu.Children(1),'Index'),x) == 1
            k=i;
        end
    end
end

delete(Info(k).h.UserData.points);
delete(Info(k).h);

if length(Info) == 1
    Info =[];
else 
    Info(k)=[];
end

cu=cu-1;
end