function parametros(~,~)
global ros rol

h=figure;
set(h,'name','Parameters','numbertitle','off','Position', [200, 350, 200, 260],'Units','pixels','menubar','none','units','normalized','CloseRequestFcn',@cerrarx,...
    'Resize','off')
vector_tama= uibuttongroup(h,...
                  'Title','Sizes vector',...
                  'Position', [0.1 0.55 0.84 0.43]);

Vector_Button= uicontrol('style','push','string','Add sizes vector','Callback',@agregar_v,...
                 'position',[30,210,150,20]);
load_Vector_Button=uicontrol('style','push','string','Load sizes vector','Callback',@cargar_v,...
                 'position',[30,185,150,20]);
ed_Vector_Button= uicontrol('style','push','string','Edit sizes vector','Callback',@editar_v,...
                 'position',[30,160,150,20]);
             
densidad= uibuttongroup(h,...
                  'Title','Densities',...
                  'Position', [0.1 0.22 0.84 0.3]);
Pxe=160;
Pxt=23;
rost=uicontrol('style','text','String','Ore density [ton/m3]');
rost.Position = [Pxt+5 90 125 20];

rose=uicontrol('style','edit','string',sprintf('%d',ros));
rose.Position = [Pxe 94 22 20];

rolt=uicontrol('style','text','String','Liquid density [ton/m3]');
rolt.Position = [Pxt+5 67 125 20];

role=uicontrol('style','edit','string',sprintf('%d',rol));
role.Position = [Pxe 71 22 20];

handles=[rose role];

guardar= uicontrol('Parent',h,'style','push','string','Save','Callback',@getpar_densidades,...
                  'position',[35,32,125,22]);
guardar.UserData=handles;

Cerrar= uicontrol('Parent',h,'style','push','string','Close','Callback',@cerrar,...
                  'position',[35,5,125,22]); 
end


