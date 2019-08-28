function Eliminar_modulo(source,eventdata)

global cu Info cuh cumc Resultados_push r
x=source.UserData;

delete(Info(x).h.UserData.points);

if strcmp(Info(x).tag,'Flujo')~= 1 && strcmp(Info(x).tag,'Entrada')~= 1
    delete(Info(x).h.UserData.image);
end
% if strcmp(Info(x).tag,'Molino Convencional') == 1 
%     cumc=cumc-1;
% end
% 
% if strcmp(Info(x).tag,'Hidrociclon')== 1
%     cuh=cuh-1;
% end

for i=1:cu-1
    if i >= x
        Info(i)=Info(i+1);
%         Info(i).k=Info(i).k-1;
%         Info(i).h.UIContextMenu.Children(1).UserData=Info(i).h.UIContextMenu.Children(1).UserData-1;
    end
end
delete(sprintf('Info(%d).h.UserData',cu));
delete(Info(cu).h);
if length(Info) == 1
    Info =[];
else 
    Info(cu)=[];
end
set(Resultados_push,'Enable','off')
set(r,'Enable','off')
cu=length(Info);

end