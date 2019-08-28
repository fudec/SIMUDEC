function moveit2mol(h)
global Info pos

gui = getappdata(gcf,'Move');

set(h,'ButtonDownFcn',@startmovit);

setappdata(h,'Move',gui);
gui=struct;

k = get_index(h.UIContextMenu.Children(1));

function startmovit(src,~)
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

gui.startpoint = [get(gui.currenthandle,'XData') get(gui.currenthandle,'YData') ];
gui.startpointp1 = [get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')];
gui.startpointp2 = [get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')];
gui.startpointtxt = get(gui.currenthandle.UserData.points(3),'Position');
gui.startpointtxt(3)=[];
gui.startpoint = get(gca,'CurrentPoint');


setappdata(gui.currenthandle,'Move',{get(gui.currenthandle,'XData') get(gui.currenthandle,'YData')});
setappdata(gui.currenthandle,'Movep1',{get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')});
setappdata(gui.currenthandle,'Movep2',{get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')});
Position=get(gui.currenthandle.UserData.points(3),'Position');
Position(3)=[];
setappdata(gui.currenthandle,'Movetxt',Position);

setappdata(gcf,'gui',gui);

end

function movit(~,~)
    
if strcmp(get(h.Parent.Parent,'SelectionType'),'open') == 1 || strcmp(get(h.Parent.Parent,'SelectionType'),'alt') == 1
    return
end

gui=getappdata(gcf,'gui');

gui.move=getappdata(gui.currenthandle,'Move');
gui.move=cell2mat(gui.move);
gui.movep1=getappdata(gui.currenthandle,'Movep1');
gui.movep1=cell2mat(gui.movep1);
gui.movep2=getappdata(gui.currenthandle,'Movep2');
gui.movep2=cell2mat(gui.movep2);
gui.movetxt=getappdata(gui.currenthandle,'Movetxt');


try
 if isequal(gui.startpoint,[])
    return
 end
catch
end

pos = get(gca,'CurrentPoint')-gui.startpoint;
posp1 = [get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')]-gui.startpointp1;
posp2 = [get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')]-gui.startpointp2;
Postxttemp=get(gui.currenthandle.UserData.points(3),'Position');
Postxttemp(3)=[];
postxt = Postxttemp-gui.startpointtxt;
get(gui.currenthandle.UserData.points(1),'XData')


XYData= getappdata(gui.currenthandle,'Move');
XYDatap1= getappdata(gui.currenthandle,'Movep1');
XYDatap2= getappdata(gui.currenthandle,'Movep2');
XYDatatxt= getappdata(gui.currenthandle,'Movetxt');


set(gui.currenthandle,'XData',XYData{1} + pos(1,1));
set(gui.currenthandle,'YData',XYData{2} + pos(1,2));

set(gui.currenthandle.UserData.points(1),'XData',XYDatap1{1} + pos(1,1));
set(gui.currenthandle.UserData.points(1),'YData',XYDatap1{2} + pos(1,2));

set(gui.currenthandle.UserData.points(2),'XData',XYDatap2{1} + pos(1,1));
set(gui.currenthandle.UserData.points(2),'YData',XYDatap2{2} + pos(1,2));

set(gui.currenthandle.UserData.points(3),'Position',[XYDatatxt(1) + pos(1,1) XYDatatxt(2)+pos(1,2) 0]);

drawnow;
setappdata(gcf,'Move',gui);
end

function stopmovit(~,~)
A=exist('pos');
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

thisfig = gcbf();
gui = getappdata(gcf,'Move');
set(gcf,'Pointer','arrow');
set(thisfig,'WindowButtonUpFcn','');
set(thisfig,'WindowButtonMotionFcn','');
drawnow;

cx=get(h.UserData.points(1),'XData');
cy=get(h.UserData.points(1),'YData');

cx1=get(h.UserData.points(2),'XData');
cy1=get(h.UserData.points(2),'YData');
largo=110;
Info(k).ioc=[cx+largo/2 cy 1;cx1 cy1 0];
gui.currenthandle=[];
setappdata(gcf,'Move',[]);
end

end