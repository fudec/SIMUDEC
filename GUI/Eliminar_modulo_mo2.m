function Eliminar_modulo_mo2(source,~)

global  Info cu cumR  Resultados_push r TagIdentifier
x=source.UserData;
for i=1:cu
                if isequal(Info(i).c,x) == 1
                    k=i;
                end
end

% if strcmp(Info(x).tag,'Entrada')== 1 
%     e=e-1;
% elseif strcmp(Info(x).tag,'Flujo')== 1 
%     cuf=cuf-1;
% end

% Info(i).h.UIContextMenu.Children(1).UserData=Info(i).h.UIContextMenu.Children(1).UserData-1;
for i=1:cu
    if i >= k
        Temp=Info(i).k;
        Temp(1)=Temp(1)-1;
        Info(i).k=Temp;
    end
end
for i=1:cu
    Info(i).h.UIContextMenu.Children(1).UserData=Info(i).h.UIContextMenu.Children(1).UserData-1;
    Info(i).h.UIContextMenu.Children(2).UserData=Info(i).h.UIContextMenu.Children(2).UserData-1;
    Info(i).h.UIContextMenu.Children(3).UserData=Info(i).h.UIContextMenu.Children(3).UserData-1;
    Info(i).c=Info(i).c-1;
end
delete(Info(k).h.UserData.points);
delete(Info(k).h);

if length(Info) == 1
    Info =[];
else 
    Info(k)=[];
end

% for i=1:cu
%     if i >= k
%                 Info(i)=Info(i-1);
%     end
% end

cu=cu-1;
cumR=cumR-1;
set(Resultados_push,'Enable','off')
set(r,'Enable','off')
TagIdentifier = TagIdentifier-1;
end