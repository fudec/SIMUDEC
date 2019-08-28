function moveit2mol(h)
global Info RC_text 



gui = getappdata(gcf,'Move');

% Make a fresh figure window
set(h,'ButtonDownFcn',@startmovit);
% for i=1:length(h.UserData.points)
%     set(h.UserData.points(i),'ButtonDownFcn',@startmovit);
% end

% Store gui object
setappdata(h,'Move',gui);
gui=struct;

function startmovit(src,evnt)
% Unpack gui object
get(h.Parent.Parent,'SelectionType')
if strcmp(get(h.Parent.Parent,'SelectionType'),'normal') == 1 || strcmp(get(h.Parent.Parent,'SelectionType'),'alt') == 1
    return
end
gui = getappdata(gcf,'Move');

% Remove mouse pointer
set(gcf,'PointerShapeCData',nan(16,16));
set(gcf,'Pointer','custom');
gui
% Set callbacks
gui.currenthandle = src
thisfig = gcbf();
set(thisfig,'WindowButtonMotionFcn',@movit);
set(thisfig,'WindowButtonUpFcn',@stopmovit);


% Store starting point of the object
gui.startpointp1 = [get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')];
gui.startpointp2 = [get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')];
gui.startpointp3=get(gui.currenthandle.UserData.points(3),'Position');
gui.startpointp3(3)=[];

gui.startpointtxt = get(gui.currenthandle,'Position');
gui.startpointtxt(3)=[];

gui.startpoint = get(gca,'CurrentPoint');


setappdata(gui.currenthandle,'Movep1',{get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')});
setappdata(gui.currenthandle,'Movep2',{get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')});
pp=get(gui.currenthandle.UserData.points(3),'Position');
pp(3)=[];
setappdata(gui.currenthandle,'Movep3',pp);

Position=get(gui.currenthandle,'Position');
Position(3)=[];
setappdata(gui.currenthandle,'Movetxt',Position);


% gui.currenthandle.UserData;
% Store gui object
setappdata(gcf,'gui',gui);
% setappdata(gui.currenthandle.UserData.points(1),'Movep1',gui);
% setappdata(gui.currenthandle.UserData.points(2),'Movep2',gui);
% setappdata(gui.currenthandle.UserData.points(3),'Movetxt',gui);

end




function y=movit(src,evnt)
% Unpack gui object

    delete(RC_text)
    RC_text=[];
    
if strcmp(get(h.Parent.Parent,'SelectionType'),'normal') == 1 || strcmp(get(h.Parent.Parent,'SelectionType'),'alt') == 1
    return
end

gui=getappdata(gcf,'gui');


gui.movep1=getappdata(gui.currenthandle,'Movep1');
gui.movep1=cell2mat(gui.movep1);
gui.movep2=getappdata(gui.currenthandle,'Movep2');
gui.movep2=cell2mat(gui.movep2);
gui.movep3=getappdata(gui.currenthandle,'Movep3');
% gui.movep3=cell2mat(gui.movep3);

gui.movetxt=getappdata(gui.currenthandle,'Movetxt');
% gui.movetxt=cell2mat(gui.movetxt);


gui.startpoint

try
 if isequal(gui.startpoint,[])
    return
 end
catch
end

% Do "smart" positioning of the object, relative to starting point...
pos = get(gca,'CurrentPoint')-gui.startpoint
posp1 = [get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')]-gui.startpointp1;
posp2 = [get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')]-gui.startpointp2;
p3=get(gui.currenthandle.UserData.points(3),'Position');
p3(3)=[];
posp3 = p3-gui.startpointp3;

Postxttemp=get(gui.currenthandle,'Position');
Postxttemp(3)=[];
postxt = Postxttemp-gui.startpointtxt;


% pos = get(gca,'CurrentPoint')-gui.startpoint;
XYDatap1= getappdata(gui.currenthandle,'Movep1');
XYDatap2= getappdata(gui.currenthandle,'Movep2');
XYDatap3= getappdata(gui.currenthandle,'Movep3');
XYDatatxt= getappdata(gui.currenthandle,'Movetxt');
alto=110;
largo=alto;
set(gui.currenthandle,'Position',[XYDatatxt(1) + pos(1,1) XYDatatxt(2)+pos(1,2) 0]);


set(gui.currenthandle.UserData.points(1),'XData',XYDatap1{1} + pos(1,1));
set(gui.currenthandle.UserData.points(1),'YData',XYDatap1{2} + pos(1,2));

set(gui.currenthandle.UserData.points(2),'XData',XYDatap2{1} + pos(1,1));
set(gui.currenthandle.UserData.points(2),'YData',XYDatap2{2} + pos(1,2));

set(gui.currenthandle.UserData.points(3),'Position',[XYDatap3(1) + pos(1,1) XYDatap3(2)+pos(1,2) largo-13 alto]);



drawnow;
% Store gui object
setappdata(gcf,'Move',gui);
end


function stopmovit(src,evnt)
A=exist('pos');
if A == 0
thisfig = gcbf();
set(gcf,'Pointer','arrow');
set(thisfig,'WindowButtonUpFcn','');
set(thisfig,'WindowButtonMotionFcn','');
drawnow;
    return
end
if strcmp(get(h.Parent.Parent,'SelectionType'),'normal') == 1 || strcmp(get(h.Parent.Parent,'SelectionType'),'alt') == 1
    return
end

% Clean up the evidence ...
thisfig = gcbf();
gui = getappdata(gcf,'Move');
set(gcf,'Pointer','arrow');
set(thisfig,'WindowButtonUpFcn','');
set(thisfig,'WindowButtonMotionFcn','');
drawnow;
k=h.UIContextMenu.Children(1).UserData;
cx=get(gui.currenthandle.UserData.points(1),'XData');
cy=get(gui.currenthandle.UserData.points(1),'YData');

cx1=get(gui.currenthandle.UserData.points(2),'XData');
cy1=get(gui.currenthandle.UserData.points(2),'YData');
largo=110;
Info(k).ioc=[cx+largo/2 cy 1;cx1 cy1 0];
gui.currenthandle=[];
% setappdata(gui.currenthandle,'Move',[]);
setappdata(gcf,'Move',[]);
end


end