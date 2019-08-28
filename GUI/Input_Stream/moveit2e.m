function moveit2e(h)
global Info RC_text pos

gui = getappdata(gcf,'Move');

set(h,'ButtonDownFcn',@startmovit);

setappdata(h,'Move',gui);
gui=struct;

function startmovit(src,evnt)
    get(h.Parent.Parent,'SelectionType')
    
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
gui.startpoint = get(gui.currenthandle,'Position');
gui.startpoint(3) =[];
gui.startpointp1 = [get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')];
gui.startpointp2 = [get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')];
gui.startpointp3 = [get(gui.currenthandle.UserData.points(3),'XData') get(gui.currenthandle.UserData.points(3),'YData')];
gui.startpointp4 = [get(gui.currenthandle.UserData.points(4),'XData') get(gui.currenthandle.UserData.points(4),'YData')];
gui.startpoint = get(gca,'CurrentPoint');

post=get(gui.currenthandle,'Position');
post(3)=[];
setappdata(gui.currenthandle,'Move',{post});
setappdata(gui.currenthandle,'Movep1',{get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')});
setappdata(gui.currenthandle,'Movep2',{get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')});
setappdata(gui.currenthandle,'Movep3',{get(gui.currenthandle.UserData.points(3),'XData') get(gui.currenthandle.UserData.points(3),'YData')});
setappdata(gui.currenthandle,'Movep4',{get(gui.currenthandle.UserData.points(4),'XData') get(gui.currenthandle.UserData.points(4),'YData')});

setappdata(gcf,'gui',gui);


end


function y=movit(src,evnt)
    delete(RC_text)
    RC_text=[];
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
gui.movep3=getappdata(gui.currenthandle,'Movep3');
gui.movep3=cell2mat(gui.movep3);
gui.movep4=getappdata(gui.currenthandle,'Movep4');
gui.movep4=cell2mat(gui.movep4);
% gui.movetxt=cell2mat(gui.movetxt);


gui.startpoint

try
 if isequal(gui.startpoint,[])
    return
 end
catch
end

pos = get(gca,'CurrentPoint')-gui.startpoint;
posp1 = [get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')]-gui.startpointp1;
posp2 = [get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')]-gui.startpointp2;
posp3 = [get(gui.currenthandle.UserData.points(3),'XData') get(gui.currenthandle.UserData.points(3),'YData')]-gui.startpointp3;
posp4 = [get(gui.currenthandle.UserData.points(4),'XData') get(gui.currenthandle.UserData.points(4),'YData')]-gui.startpointp4;


get(gui.currenthandle.UserData.points(1),'XData');

XYData= getappdata(gui.currenthandle,'Move');
XYDatap1= getappdata(gui.currenthandle,'Movep1');
XYDatap2= getappdata(gui.currenthandle,'Movep2');
XYDatap3= getappdata(gui.currenthandle,'Movep3');
XYDatap4= getappdata(gui.currenthandle,'Movep4');

XYData=cell2mat(XYData);

set(gui.currenthandle,'Position',[XYData(1) + pos(1,1) XYData(2)+pos(1,2) 0]);


set(gui.currenthandle.UserData.points(1),'XData',XYDatap1{1} + pos(1,1));
set(gui.currenthandle.UserData.points(1),'YData',XYDatap1{2} + pos(1,2));

set(gui.currenthandle.UserData.points(2),'XData',XYDatap2{1} + pos(1,1));
set(gui.currenthandle.UserData.points(2),'YData',XYDatap2{2} + pos(1,2));

set(gui.currenthandle.UserData.points(3),'XData',XYDatap3{1} + pos(1,1));
set(gui.currenthandle.UserData.points(3),'YData',XYDatap3{2} + pos(1,2));


set(gui.currenthandle.UserData.points(4),'XData',XYDatap4{1} + pos(1,1));
set(gui.currenthandle.UserData.points(4),'YData',XYDatap4{2} + pos(1,2));




drawnow;
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
if strcmp(get(h.Parent.Parent,'SelectionType'),'open') == 1 || strcmp(get(h.Parent.Parent,'SelectionType'),'alt') == 1
    return
end    

thisfig = gcbf();
gui = getappdata(gcf,'Move');
set(gcf,'Pointer','arrow');
set(thisfig,'WindowButtonUpFcn','');
set(thisfig,'WindowButtonMotionFcn','');
drawnow;
k=h.UIContextMenu.UserData;
cx=get(gui.currenthandle.UserData.points(1),'XData');
cy=get(gui.currenthandle.UserData.points(1),'YData');
% % 
cx1=get(gui.currenthandle.UserData.points(2),'XData');
cy1=get(gui.currenthandle.UserData.points(2),'YData');

Info(k).ioc=[cx1 cy1 0;cx cy 1];
gui.currenthandle=[];
setappdata(gcf,'Move',[]);
end


end
