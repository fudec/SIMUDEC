function moveit2sum(h)
global Info a b

gui = getappdata(gcf,'Move');
axis([0 a 0 b])
n=h.UserData.n;
set(h,'ButtonDownFcn',@startmovit);
setappdata(h,'Move',gui);

gui=struct;
k=h.UIContextMenu.Children(1).UserData;

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


if n == 2
gui.startpoint = [get(gui.currenthandle,'XData') get(gui.currenthandle,'YData') ];
gui.startpointp1 = [get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')];
gui.startpointp2 = [get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')];
gui.startpointp3 = [get(gui.currenthandle.UserData.points(3),'XData') get(gui.currenthandle.UserData.points(3),'YData')];

gui.startpoint = get(gca,'CurrentPoint');


setappdata(gui.currenthandle,'Move',{get(gui.currenthandle,'XData') get(gui.currenthandle,'YData')});
setappdata(gui.currenthandle,'Movep1',{get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')});
setappdata(gui.currenthandle,'Movep2',{get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')});
setappdata(gui.currenthandle,'Movep3',{get(gui.currenthandle.UserData.points(3),'XData') get(gui.currenthandle.UserData.points(3),'YData')});


setappdata(gcf,'gui',gui);
elseif n == 3
    
gui.startpoint = [get(gui.currenthandle,'XData') get(gui.currenthandle,'YData') ];
gui.startpointp1 = [get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')];
gui.startpointp2 = [get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')];
gui.startpointp3 = [get(gui.currenthandle.UserData.points(3),'XData') get(gui.currenthandle.UserData.points(3),'YData')];
gui.startpointp4 = [get(gui.currenthandle.UserData.points(4),'XData') get(gui.currenthandle.UserData.points(4),'YData')];

gui.startpoint = get(gca,'CurrentPoint');

setappdata(gui.currenthandle,'Move',{get(gui.currenthandle,'XData') get(gui.currenthandle,'YData')});
setappdata(gui.currenthandle,'Movep1',{get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')});
setappdata(gui.currenthandle,'Movep2',{get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')});
setappdata(gui.currenthandle,'Movep3',{get(gui.currenthandle.UserData.points(3),'XData') get(gui.currenthandle.UserData.points(3),'YData')});    
setappdata(gui.currenthandle,'Movep4',{get(gui.currenthandle.UserData.points(4),'XData') get(gui.currenthandle.UserData.points(4),'YData')});    

setappdata(gcf,'gui',gui);

elseif n == 4
    
gui.startpoint = [get(gui.currenthandle,'XData') get(gui.currenthandle,'YData') ];
gui.startpointp1 = [get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')];
gui.startpointp2 = [get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')];
gui.startpointp3 = [get(gui.currenthandle.UserData.points(3),'XData') get(gui.currenthandle.UserData.points(3),'YData')];
gui.startpointp4 = [get(gui.currenthandle.UserData.points(4),'XData') get(gui.currenthandle.UserData.points(4),'YData')];
gui.startpointp5 = [get(gui.currenthandle.UserData.points(5),'XData') get(gui.currenthandle.UserData.points(5),'YData')];

gui.startpoint = get(gca,'CurrentPoint');


setappdata(gui.currenthandle,'Move',{get(gui.currenthandle,'XData') get(gui.currenthandle,'YData')});
setappdata(gui.currenthandle,'Movep1',{get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')});
setappdata(gui.currenthandle,'Movep2',{get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')});
setappdata(gui.currenthandle,'Movep3',{get(gui.currenthandle.UserData.points(3),'XData') get(gui.currenthandle.UserData.points(3),'YData')});    
setappdata(gui.currenthandle,'Movep4',{get(gui.currenthandle.UserData.points(4),'XData') get(gui.currenthandle.UserData.points(4),'YData')});    
setappdata(gui.currenthandle,'Movep5',{get(gui.currenthandle.UserData.points(5),'XData') get(gui.currenthandle.UserData.points(5),'YData')});    

setappdata(gcf,'gui',gui);

end

end


function movit(~,~)
    
if strcmp(get(h.Parent.Parent,'SelectionType'),'open') == 1 || strcmp(get(h.Parent.Parent,'SelectionType'),'alt') == 1
    return
end   

gui=getappdata(gcf,'gui');

if n == 2
    
gui.move=getappdata(gui.currenthandle,'Move');
gui.move=cell2mat(gui.move);
gui.movep1=getappdata(gui.currenthandle,'Movep1');
gui.movep1=cell2mat(gui.movep1);
gui.movep2=getappdata(gui.currenthandle,'Movep2');
gui.movep2=cell2mat(gui.movep2);
gui.movep3=getappdata(gui.currenthandle,'Movep3');
gui.movep3=cell2mat(gui.movep3);

elseif n == 3
    
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


elseif n == 4
    
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
gui.movep5=getappdata(gui.currenthandle,'Movep5');
gui.movep5=cell2mat(gui.movep5);

end


try
 if isequal(gui.startpoint,[])
    return
 end
catch
end

pos = get(gca,'CurrentPoint')-gui.startpoint;

if n == 2
    
% posp1 = [get(gui.currenthandle.UserData.points(1),'XData') get(gui.currenthandle.UserData.points(1),'YData')]-gui.startpointp1;
% posp2 = [get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')]-gui.startpointp2;
% posp2 = [get(gui.currenthandle.UserData.points(2),'XData') get(gui.currenthandle.UserData.points(2),'YData')]-gui.startpointp2;

XYData= getappdata(gui.currenthandle,'Move');
XYDatap1= getappdata(gui.currenthandle,'Movep1');
XYDatap2= getappdata(gui.currenthandle,'Movep2');
XYDatap3= getappdata(gui.currenthandle,'Movep3');

set(gui.currenthandle,'XData',XYData{1} + pos(1,1));
set(gui.currenthandle,'YData',XYData{2} + pos(1,2));

set(gui.currenthandle.UserData.points(1),'XData',XYDatap1{1} + pos(1,1));
set(gui.currenthandle.UserData.points(1),'YData',XYDatap1{2} + pos(1,2));

set(gui.currenthandle.UserData.points(2),'XData',XYDatap2{1} + pos(1,1));
set(gui.currenthandle.UserData.points(2),'YData',XYDatap2{2} + pos(1,2));

set(gui.currenthandle.UserData.points(3),'XData',XYDatap3{1} + pos(1,1));
set(gui.currenthandle.UserData.points(3),'YData',XYDatap3{2} + pos(1,2));

elseif n == 3
    
XYData= getappdata(gui.currenthandle,'Move');
XYDatap1= getappdata(gui.currenthandle,'Movep1');
XYDatap2= getappdata(gui.currenthandle,'Movep2');
XYDatap3= getappdata(gui.currenthandle,'Movep3');
XYDatap4= getappdata(gui.currenthandle,'Movep4');


set(gui.currenthandle,'XData',XYData{1} + pos(1,1));
set(gui.currenthandle,'YData',XYData{2} + pos(1,2));

set(gui.currenthandle.UserData.points(1),'XData',XYDatap1{1} + pos(1,1));
set(gui.currenthandle.UserData.points(1),'YData',XYDatap1{2} + pos(1,2));

set(gui.currenthandle.UserData.points(2),'XData',XYDatap2{1} + pos(1,1));
set(gui.currenthandle.UserData.points(2),'YData',XYDatap2{2} + pos(1,2));

set(gui.currenthandle.UserData.points(3),'XData',XYDatap3{1} + pos(1,1));
set(gui.currenthandle.UserData.points(3),'YData',XYDatap3{2} + pos(1,2));

set(gui.currenthandle.UserData.points(4),'XData',XYDatap4{1} + pos(1,1));
set(gui.currenthandle.UserData.points(4),'YData',XYDatap4{2} + pos(1,2));

elseif n == 4
    
XYData= getappdata(gui.currenthandle,'Move');
XYDatap1= getappdata(gui.currenthandle,'Movep1');
XYDatap2= getappdata(gui.currenthandle,'Movep2');
XYDatap3= getappdata(gui.currenthandle,'Movep3');
XYDatap4= getappdata(gui.currenthandle,'Movep4');
XYDatap5= getappdata(gui.currenthandle,'Movep5');


set(gui.currenthandle,'XData',XYData{1} + pos(1,1));
set(gui.currenthandle,'YData',XYData{2} + pos(1,2));

set(gui.currenthandle.UserData.points(1),'XData',XYDatap1{1} + pos(1,1));
set(gui.currenthandle.UserData.points(1),'YData',XYDatap1{2} + pos(1,2));

set(gui.currenthandle.UserData.points(2),'XData',XYDatap2{1} + pos(1,1));
set(gui.currenthandle.UserData.points(2),'YData',XYDatap2{2} + pos(1,2));

set(gui.currenthandle.UserData.points(3),'XData',XYDatap3{1} + pos(1,1));
set(gui.currenthandle.UserData.points(3),'YData',XYDatap3{2} + pos(1,2));

set(gui.currenthandle.UserData.points(4),'XData',XYDatap4{1} + pos(1,1));
set(gui.currenthandle.UserData.points(4),'YData',XYDatap4{2} + pos(1,2));

set(gui.currenthandle.UserData.points(5),'XData',XYDatap5{1} + pos(1,1));
set(gui.currenthandle.UserData.points(5),'YData',XYDatap5{2} + pos(1,2));

end
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
if n == 2
    
cx=get(gui.currenthandle.UserData.points(1),'XData');
cy=get(gui.currenthandle.UserData.points(1),'YData');
% 
cx1=get(gui.currenthandle.UserData.points(2),'XData');
cy1=get(gui.currenthandle.UserData.points(2),'YData');

cx2=get(gui.currenthandle.UserData.points(3),'XData');
cy2=get(gui.currenthandle.UserData.points(3),'YData');
% largo=110;
Info(k).ioc=[cx cy 1;cx1 cy1 1;cx2 cy2 0];

elseif n == 3
    
cx=get(gui.currenthandle.UserData.points(1),'XData');
cy=get(gui.currenthandle.UserData.points(1),'YData');
% 
cx1=get(gui.currenthandle.UserData.points(2),'XData');
cy1=get(gui.currenthandle.UserData.points(2),'YData');

cx2=get(gui.currenthandle.UserData.points(3),'XData');
cy2=get(gui.currenthandle.UserData.points(3),'YData');

cx3=get(gui.currenthandle.UserData.points(4),'XData');
cy3=get(gui.currenthandle.UserData.points(4),'YData');

Info(k).ioc=[cx cy 1;cx1 cy1 1;cx2 cy2 1;cx3 cy3 0];

elseif n == 4
    
cx=get(gui.currenthandle.UserData.points(1),'XData');
cy=get(gui.currenthandle.UserData.points(1),'YData');
% 
cx1=get(gui.currenthandle.UserData.points(2),'XData');
cy1=get(gui.currenthandle.UserData.points(2),'YData');

cx2=get(gui.currenthandle.UserData.points(3),'XData');
cy2=get(gui.currenthandle.UserData.points(3),'YData');

cx3=get(gui.currenthandle.UserData.points(4),'XData');
cy3=get(gui.currenthandle.UserData.points(4),'YData');

cx4=get(gui.currenthandle.UserData.points(5),'XData');
cy4=get(gui.currenthandle.UserData.points(5),'YData');

Info(k).ioc=[cx cy 1;cx1 cy1 1;cx2 cy2 1;cx3 cy3 1;cx4 cy4 0];
end
gui.currenthandle=[];
setappdata(gcf,'Move',[]);
end


end