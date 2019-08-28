function editar_etiqueta(source,~)
global cu Info axesgnu h

k = get_index(source)
default = Info(k).tag2;
% default=string(default);
Input = [];
if iscell(default)
    Input = inputdlg('Nueva Etiqueta','Etiqueta', 1, default);
elseif isstring(default)
    Input = inputdlg('Nueva Etiqueta','Etiqueta', 1, {default});
else
     Input = inputdlg('Nueva Etiqueta','Etiqueta', 1, {default});
end

if isempty(Input)
    return
end
Position = Info(k).h.UserData.points(3).Position;
set(h,'CurrentAxes',axesgnu)
delete(Info(k).h.UserData.points(3));

txt=text(Position(1),Position(2),Input,'LineStyle','-','FontSize',9);
Info(k).h.UserData.points(3)=txt;
txt.Position=Position;
Info(k).tag2 =txt.String{1};
end