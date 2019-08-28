function Chancado_Group(~,~)
global Colorf

warndlg('Non available')
return

Chancado_Group_Figure=figure;
set(Chancado_Group_Figure,'name','Crushing','numbertitle','off','Position', [300,200,70,265],'menubar','none',...
    'Color',Colorf,'Resize','off')

Chanc_image=imread('Chancador_ico.png');
Chanc_image=imresize(Chanc_image, [50 50]);
Chanc_push= uicontrol(Chancado_Group_Figure,'style','push','Callback',@dibujarchanc,...
                 'position',[30,180,50,50],'CData',Chanc_image,'BackgroundColor','white','TooltipString','Gyratory Crusher');
             
ChancM_image=imread('Jaw_ico.png');
ChancM_image=imresize(ChancM_image, [50 50]);
ChancM_push= uicontrol(Chancado_Group_Figure,'style','push','Callback',@dibujarchancM,...
                 'position',[30,120,50,50],'CData',ChancM_image,'BackgroundColor','white','TooltipString','Jaw Crusher');
             
HPGR_image=imread('HPGR_ico.png');
HPGR_image=imresize(HPGR_image, [50 50]);
HPGR_push= uicontrol(Chancado_Group_Figure,'style','push','Callback',@dibujarHPGR,...
                 'position',[30,60,50,50],'CData',HPGR_image,'BackgroundColor','white','TooltipString','HPGR');

end