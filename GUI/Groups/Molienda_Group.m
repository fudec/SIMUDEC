function Molienda_Group(~,~)
global Colorf Molienda_Group_Figure

if isempty(Molienda_Group_Figure) || ~isvalid(Molienda_Group_Figure)
    Molienda_Group_Figure=figure;
    
    set(Molienda_Group_Figure,'name','Grinding','numbertitle','off','Position', [300,200,70,265],'menubar','none',...
        'Color',Colorf,'Resize','off')

    Molc_image=imread('Molinoc_ico.jpg');
    Molc_image=imresize(Molc_image, [50 50]);          
    Molc_push= uicontrol(Molienda_Group_Figure,'style','push','Callback',@dibujarmolc2,...
                     'position',[30,180,50,50],'CData',Molc_image,'BackgroundColor','white','TooltipString','Ball Mill');

    SAG_image=imread('SAG_ico.jpg');
    SAG_image=imresize(SAG_image, [50 50]);
    SAG_push= uicontrol(Molienda_Group_Figure,'style','push','Callback',@dibujarsag,...
                     'position',[30,120,50,50],'CData',SAG_image,'BackgroundColor','white','TooltipString','SAG Mill'); 

    MolR_image=imread('MolinoR_ico.jpg');
    MolR_image=imresize(MolR_image, [50 50]);          
    MolR_push= uicontrol(Molienda_Group_Figure,'style','push','Callback',@dibujarmolR,...
                     'position',[30,60,50,50],'CData',MolR_image,'BackgroundColor','white','TooltipString','Rod Mill');
set(Molienda_Group_Figure.CurrentAxes,'Visible','off')
else
    uistack(Molienda_Group_Figure, 'top')
    set(Molienda_Group_Figure.CurrentAxes,'Visible','off')
end

end