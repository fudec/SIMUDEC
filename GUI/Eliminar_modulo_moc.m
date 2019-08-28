function Eliminar_modulo_mo(source,~)

global  Info cu 
k=get_index(source);


delete(Info(k).h.UserData.points);
delete(Info(k).h);

if length(Info) == 1
    Info =[];
else 
    Info(k)=[];
end


cu=cu-1;
set(r,'Enable','off')
end