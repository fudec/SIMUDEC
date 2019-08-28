function SCR1(x)
global Info

figure_modelo_hidro=figure;
figure_modelo_hidro.Position=[600 190 205 250];
set(figure_modelo_hidro,'numbertitle','off','menubar','none','name',Info(x).tag2)
set(figure_modelo_hidro,'Resize','off');

dimen_bg= uibuttongroup(figure_modelo_hidro,...
                  'Title','Parameters',...
                  'Position', [0.05 0.42 0.85 0.40]);
              
Info_image=imread('Info.ico');
Info_image=imresize(Info_image, [15 15]);
Info_button=uicontrol(figure_modelo_hidro,'style','push','CData',Info_image,'Position', [170 295 15 15],'BackgroundColor','white',...
    'tooltipstring','Meters');             

Px=95;

%%% Rf %%%%%%%%%%
Dcy=180;
Dcx=15;

Dc_edit=uicontrol(figure_modelo_hidro,'style','edit','string',0.66);
Dc_edit.Position = [Px Dcy 40 15];

Dc_text=uicontrol(figure_modelo_hidro,'style','text','string','Rf');
Dc_text.Position = [Dcx Dcy 60 15];

% %%%%%%%%%%%% alfa %%%%%%%%%%%%%%%%%%

Diy=165;
Dix=20;

Di_edit=uicontrol(figure_modelo_hidro,'style','edit','string',0.215);
Di_edit.Position = [Px Diy 40 15];

Di_text=uicontrol(figure_modelo_hidro,'style','text','string','alfa');
Di_text.Position = [Dix Diy 60 15];

% %%%%%%%%%%%% Vortex %%%%%%%%%%%%%%%%%%

Doy=150;
Dox=20;

Do_edit=uicontrol(figure_modelo_hidro,'style','edit','string',0.28);
Do_edit.Position = [Px Doy 40 15];

Do_text=uicontrol(figure_modelo_hidro,'style','text','string','d50');
Do_text.Position = [Dox Doy 60 15];

%%%%%%%%%%%%% Apex %%%%%%%%%%%%%%%%%%

Duy=135;
Dux=20;


Du_edit=uicontrol(figure_modelo_hidro,'style','edit','string',0.14);
Du_edit.Position = [Px Duy 40 15];

Du_text=uicontrol(figure_modelo_hidro,'style','text','string','beta');
Du_text.Position = [Dux Duy 60 15];

%%%%%%%%%%%%% Lc %%%%%%%%%%%%%%%%%%

Lcy=120;
Lcx=25;

Lc_edit=uicontrol(figure_modelo_hidro,'style','edit','string',0.449);
Lc_edit.Position = [Px Lcy 40 15];

Lc_text=uicontrol(figure_modelo_hidro,'style','text','string','beta*','TooltipString','beta*');
Lc_text.Position = [Lcx Lcy 40 15];


cerrar_mo1 = uicontrol('Parent',figure_modelo_hidro,...
           'Style','push',...
           'Position',[115 10 70 25],...
           'String','Cerrar',...
           'Callback',@cerrar);
aceptar_mo1=uicontrol;
Dc_edit.UserData=x;

aceptar_mo1.UserData=[Dc_edit Di_edit Do_edit  Du_edit...
     Lc_edit];

 set(aceptar_mo1,'Parent',figure_modelo_hidro,...
           'Style','push',...
           'Position',[20 10 70 25],...
           'String','Guardar',...
           'Callback',@getSCR1);
     
waitfor(figure_modelo_hidro)
end