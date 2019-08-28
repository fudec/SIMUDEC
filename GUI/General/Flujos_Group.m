function Flujos_Group(~,~)

global Colorf Flujos_Group_Figure

if isempty(Flujos_Group_Figure) || ~isvalid(Flujos_Group_Figure)
    Flujos_Group_Figure=figure;
set(Flujos_Group_Figure,'name','Classification','numbertitle','off','Position', [300,200,70,330],'menubar','none',...
    'Color',Colorf,'Resize','off')
set(Flujos_Group_Figure,'name','Streams','numbertitle','off','Position', [300,200,70,330],'menubar','none',...
    'Color',Colorf,'Resize','off')

Flujo_image=imread('Flujo.jpg');
Flujo_image=imresize(Flujo_image, [50 50]);
Flujo_push= uicontrol(Flujos_Group_Figure,'style','push','Callback',@dibujar,...
                 'position',[30,240,50,50],'CData',Flujo_image,'TooltipString','Stream','BackgroundColor','white');  

Flujoe_image=imread('Flujoe.jpg');
Flujoe_image=imresize(Flujoe_image, [50 50]);
Flujoe_push= uicontrol(Flujos_Group_Figure,'style','push','Callback',@dibujare2,...
                 'position',[30,180,50,50],'CData',Flujoe_image,'TooltipString','Input Stream','BackgroundColor','white');
             
Sum_image=imread('Sumador_ico.jpg');
Sum_image=imresize(Sum_image, [50 50]);           
Sum_push= uicontrol(Flujos_Group_Figure,'style','push','Callback',@dibujsum2,...
                 'position',[30,120,50,50],'CData',Sum_image,'TooltipString','Sum','BackgroundColor','white');
             
Sumidero_image=imread('Sumidero_ico.jpg');
Sumidero_image=imresize(Sumidero_image, [50 50]);           
Sumidero_push= uicontrol(Flujos_Group_Figure,'style','push','Callback',@dibujarsumidero,...
                 'position',[30,60,50,50],'CData',Sumidero_image,'TooltipString','Sumidero','BackgroundColor','white');

             
set(Flujos_Group_Figure.CurrentAxes,'Visible','off')
else
    uistack(Flujos_Group_Figure, 'top')
    set(Flujos_Group_Figure.CurrentAxes,'Visible','off')
end
             
end