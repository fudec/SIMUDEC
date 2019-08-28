function Clasificacion_Group(~,~)
global Colorf Clasifiacion_Group_Figure

if isempty(Clasifiacion_Group_Figure) || ~isvalid(Clasifiacion_Group_Figure)
    Clasifiacion_Group_Figure=figure;
set(Clasifiacion_Group_Figure,'name','Classification','numbertitle','off','Position', [300,200,70,330],'menubar','none',...
    'Color',Colorf,'Resize','off')

Hidro_image=imread('HidroI_ico.jpg');
Hidro_image=imresize(Hidro_image, [50 50]);       
Hidro_push= uicontrol(Clasifiacion_Group_Figure,'style','push','Callback',@dibujhid,...
                 'position',[30,240,50,50],'CData',Hidro_image,'TooltipString','Hydrocyclone','BackgroundColor','white');
  
SCR_image=imread('SCR_ico.jpg');
SCR_image=imresize(SCR_image, [50 50]);
SCR_push= uicontrol(Clasifiacion_Group_Figure,'style','push','Callback',@dibujscr,...
                 'position',[30,180,50,50],'CData',SCR_image,'TooltipString','Screener','BackgroundColor','white');
             
Tromel_image=imread('Tromel_ico.png');
Tromel_image=imresize(Tromel_image, [50 50]);
Tromel_push= uicontrol(Clasifiacion_Group_Figure,'style','push','Callback',@dibujtromel,...
                 'position',[30,120,50,50],'CData',Tromel_image,'TooltipString','Trommel','BackgroundColor','white');

Separador_image=imread('Spliter_ico.jpg');
Separador_image=imresize(Separador_image, [50 50]);           
Separador_push= uicontrol(Clasifiacion_Group_Figure,'style','push','Callback',@dibujsplit,...
                 'position',[30,60,50,50],'CData',Separador_image,'TooltipString','Spliter','BackgroundColor','white');
             
             
set(Clasifiacion_Group_Figure.CurrentAxes,'Visible','off')
else
    uistack(Clasifiacion_Group_Figure, 'top')
    set(Clasifiacion_Group_Figure.CurrentAxes,'Visible','off')
end


end