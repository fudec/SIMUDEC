function Eliminar_modulof(source,~)

global  Info cu cuf  Resultados_push r TagIdentifier wcunt
x=source.UserData;
% for i=1:cu-1
%         if isequal(length(Info(i).h.UIContextMenu.Children),0) == 0
%             if isempty(Info(i).h.UIContextMenu.Children(1).UserData) == 0
%                 if isequal(Info(i).h.UIContextMenu.Children(1).UserData,x) == 1
%                     k=i;
%                 end
%             end
%         end
% end
k=x;
% if strcmp(Info(x).tag,'Entrada')== 1 
%     e=e-1;
% elseif strcmp(Info(x).tag,'Flujo')== 1 
%     cuf=cuf-1;
% end

% Info(i).h.UIContextMenu.Children(1).UserData=Info(i).h.UIContextMenu.Children(1).UserData-1;
for i=1:cu-1
    if i > k
%         Temp=Info(i).k;
%         Temp(1)=Temp(1)-1;
%         Info(i).k=Temp;
        Info(i).c=Info(i).c-1;
    end
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
cuf=cuf-1;
wcunt=wcunt-1;
TagIdentifier = TagIdentifier-1;
end