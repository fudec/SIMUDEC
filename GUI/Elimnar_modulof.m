function Elimnar_modulof(source,eventdata)

global cu Info cuf e
x=source.UserData

delete(Info(x).h.UserData.points);

if strcmp(Info(x).tag,'Flujo')~= 1 && strcmp(Info(x).tag,'Entrada')~= 1
    delete(Info(x).h.UserData.image);
end

if strcmp(Info(x).tag,'Entrada')== 1 
    e=e-1;
elseif strcmp(Info(x).tag,'Flujo')== 1 
    cuf=cuf-1;
end

delete(Info(x).h);

for i=1:cu-1
    if i >= x
        Info(i)=Info(i+1);
        Info(i).k=Info(i).k-1;
        Info(i).h.UIContextMenu.Children(1).UserData=Info(i).h.UIContextMenu.Children(1).UserData-1;
    end
end

if length(Info) == 1
    Info =[];
else 
    Info(cu)=[];
end

cu=cu-1;
cuf=cuf-1;
end