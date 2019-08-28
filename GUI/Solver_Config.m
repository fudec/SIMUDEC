function Solver_Config(hObject,eventdata)
global Tol MaxIt


Tolstr=num2str(Tol);
MaxItstr=num2str(MaxIt);
h=figure;
set(h,'name','Solver Parameters','numbertitle','off','Position', [200, 350, 200, 130],'Units','pixels','menubar','none','units','normalized','CloseRequestFcn',@cerrarx,...
    'Resize','off')
             
density= uibuttongroup(h,...
                  'Position', [0.1 0.45 0.86 0.5]);
Pxe=157;
Pxt=23;
Tolt=uicontrol('style','text','String','Tolerance');
Tolt.Position = [Pxt+5 90 125 20];

Tole=uicontrol('style','edit','string',Tolstr);
Tole.Position = [Pxe 91 35 20];

MaxIt=uicontrol('style','text','String','Maximum iterations');
MaxIt.Position = [Pxt+5 67 125 20];

MaxIte=uicontrol('style','edit','string',MaxItstr);
MaxIte.Position = [Pxe 71 35 20];

handles=[Tole MaxIte];

guardar= uicontrol('Parent',h,'style','push','string','Save','Callback',@getpar_Solver,...
                  'position',[35,32,125,22]);
guardar.UserData=handles;
Cerrar= uicontrol('Parent',h,'style','push','string','Close','Callback',@cerrar,...
                  'position',[35,5,125,22]); 
end