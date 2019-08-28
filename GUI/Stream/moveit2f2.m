function moveit2f2(h)
global Info RC_text pos

gui = getappdata(gcf,'Move');

set(h,'ButtonDownFcn',@startmovit);

setappdata(h,'Move',gui);
gui=struct;

function startmovit(src,evnt)
if strcmp(get(h.Parent.Parent,'SelectionType'),'open') == 1 || strcmp(get(h.Parent.Parent,'SelectionType'),'alt') == 1
    return
end
gui = getappdata(gcf,'Move');

set(gcf,'PointerShapeCData',nan(16,16));
set(gcf,'Pointer','custom');

gui.currenthandle = src;
thisfig = gcbf();
set(thisfig,'WindowButtonMotionFcn',@movit);
set(thisfig,'WindowButtonUpFcn',@stopmovit);

% Store starting point of the object
gui.startpoint = [get(gui.currenthandle,'XData') get(gui.currenthandle,'YData') ];
gui.startpointp1 = [get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')];
gui.startpointp2 = [get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')];
gui.startpointl1 = [get(gui.currenthandle.UserData.points(3),'XData') get(gui.currenthandle.UserData.points(3),'YData')];
gui.startpointl2 = [get(gui.currenthandle.UserData.points(4),'XData') get(gui.currenthandle.UserData.points(4),'YData')];
gui.startpointtxt = get(h,'Position');
gui.startpointtxt(3)=[];
gui.startpoint = get(gca,'CurrentPoint');


setappdata(gui.currenthandle,'Move',{get(gui.currenthandle,'XData') get(gui.currenthandle,'YData')});
setappdata(gui.currenthandle,'Movep1',{get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')});
setappdata(gui.currenthandle,'Movep2',{get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')});
setappdata(gui.currenthandle,'Movel1',{get(gui.currenthandle.UserData.points(3),'XData') get(gui.currenthandle.UserData.points(3),'YData')});
setappdata(gui.currenthandle,'Movel2',{get(gui.currenthandle.UserData.points(4),'XData') get(gui.currenthandle.UserData.points(4),'YData')});
Position=get(h,'Position');
Position(3)=[];
setappdata(gui.currenthandle,'Movetxt',Position);
setappdata(gcf,'gui',gui);
end

function y=movit(src,evnt)

    delete(RC_text)
    RC_text=[];
    
if strcmp(get(h.Parent.Parent,'SelectionType'),'open') == 1 || strcmp(get(h.Parent.Parent,'SelectionType'),'alt') == 1
    return
end

gui.move=getappdata(gui.currenthandle,'Move');
gui.move=cell2mat(gui.move);
gui.movep1=getappdata(gui.currenthandle,'Movep1');
gui.movep1=cell2mat(gui.movep1);
gui.movep2=getappdata(gui.currenthandle,'Movep2');
gui.movep2=cell2mat(gui.movep2);
gui.movel1=getappdata(gui.currenthandle,'Movel1');
gui.movel1=cell2mat(gui.movel1);
gui.movel2=getappdata(gui.currenthandle,'Movel2');
gui.movel2=cell2mat(gui.movel2);
gui.movetxt=getappdata(gui.currenthandle,'Movetxt');

try
 if isequal(gui.startpoint,[])
    return
 end
catch
end

% Do "smart" positioning of the object, relative to starting point...
pos = get(gca,'CurrentPoint')-gui.startpoint;
posp1 = [get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')]-gui.startpointp1;
posp2 = [get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')]-gui.startpointp2;
posl1 = [get(gui.currenthandle.UserData.points(3),'XData') get(gui.currenthandle.UserData.points(3),'YData')]-gui.startpointl1;
posl2 = [get(gui.currenthandle.UserData.points(4),'XData') get(gui.currenthandle.UserData.points(4),'YData')]-gui.startpointl2;
Postxttemp=get(h,'Position');
Postxttemp(3)=[];
postxt = Postxttemp-gui.startpointtxt;
get(gui.currenthandle.UserData.points(1),'XData')

% pos = get(gca,'CurrentPoint')-gui.startpoint;
XYData= getappdata(gui.currenthandle,'Move');
XYDatap1= getappdata(gui.currenthandle,'Movep1');
XYDatap2= getappdata(gui.currenthandle,'Movep2');
XYDatal1= getappdata(gui.currenthandle,'Movel1');
XYDatal2= getappdata(gui.currenthandle,'Movel2');
XYDatatxt= getappdata(gui.currenthandle,'Movetxt');


set(gui.currenthandle,'XData',XYData{1} + pos(1,1));
set(gui.currenthandle,'YData',XYData{2} + pos(1,2));

set(gui.currenthandle.UserData.points(1),'XData',XYDatap1{1} + pos(1,1));
set(gui.currenthandle.UserData.points(1),'YData',XYDatap1{2} + pos(1,2));

set(gui.currenthandle.UserData.points(2),'XData',XYDatap2{1} + pos(1,1));
set(gui.currenthandle.UserData.points(2),'YData',XYDatap2{2} + pos(1,2));

set(gui.currenthandle.UserData.points(3),'XData',XYDatal1{1} + pos(1,1));
set(gui.currenthandle.UserData.points(3),'YData',XYDatal1{2} + pos(1,2));

set(gui.currenthandle.UserData.points(4),'XData',XYDatal2{1} + pos(1,1));
set(gui.currenthandle.UserData.points(4),'YData',XYDatal2{2} + pos(1,2));


% set(h,'Position',[XYDatatxt(1) + pos(1,1) XYDatatxt(2)+pos(1,2) 0]);

drawnow;
% Store gui object
setappdata(gcf,'Move',gui);
end

function stopmovit(src,evnt)

A=exist('pos')
if A == 0
thisfig = gcbf();
set(gcf,'Pointer','arrow');
set(thisfig,'WindowButtonUpFcn','');
set(thisfig,'WindowButtonMotionFcn','');
drawnow;
    return
end
if strcmp(get(h.Parent.Parent,'SelectionType'),'open') == 1 || strcmp(get(h.Parent.Parent,'SelectionType'),'alt') == 1
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
cx=get(h.UserData.points(1),'XData'); %p1
cy=get(h.UserData.points(1),'YData');
% 
cx1=get(h.UserData.points(2),'XData'); %p2
cy1=get(h.UserData.points(2),'YData');

Info(k).ioc=[cx cy 1;cx1 cy1 0];
gui.currenthandle=[];
setappdata(gcf,'Move',[]);
end
end
