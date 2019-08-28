function Molienda_Group(~,~)
global Colorf

Molienda_Group_Figure=figure;
set(Molienda_Group_Figure,'name','Molienda','numbertitle','off','Position', [300,200,70,300],'menubar','none',...
    'Color',Colorf,'CloseRequestFcn',@cerrarx)
end