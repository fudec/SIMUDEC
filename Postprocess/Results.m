function Results(~,~)

global v  e v1 X  a b cuf
a=1366;
b=1280;
if isempty(X(1).Length)
    Message='There are not results';
    exito = warndlg(Message);
    return
end

for o=1:X(1).Length
    X(o).P80=F80(X(o).Streams.Stream.Value(1:end-1),v);
end
for l=1:X(1).Length
    X(l).c=X(l).F;
end

n=X(1).Length;
for z=e+1:e+v1
    X(z-1).tag=sprintf('Flujo %d',z);
end

   c=200;
   d=400;

   f5=figure('name','Results','numbertitle','off','Position', [300, 150, c, d],'menubar','none');
    


for m=1:X(1).Length 
    str(m)=cellstr(X(m).Streams.Stream.Name);
end

    
   lb = uicontrol(f5,'Style','listbox',...
                'String',str,...
                'Position',[30 90 130 280],'Value',1,'Max',cuf,'Min',0);
   Guardar_graf= uicontrol(f5,'style','push','string','Accept','Callback',@pushcallback,...
                 'position',[30,30,130,40]);
   Pos=[a b];
   set(lb,'UserData',Pos);
 function y=pushcallback(hObject,event)
lb.UserData
Pos=lb.UserData;
a=Pos(1);
b=Pos(2);
items = get(lb,'String');
index_selected = get(lb,'Value');
mm=size(items);
for i=1:mm(1)
    Resultados_Flujos(i).String=items(i);
    Resultados_Flujos(i).value=X(i).c;
end

f6=figure('Name','Results','numbertitle','off','menubar','none');
set(f6,'Position',[0 0 a b]);
axesgraf=axes(f6,'Position',[0.11,0.125,0.88,0.83],'XGrid','on','YGrid','on','Box','on');
max(index_selected)
length(index_selected)
for z=1:length(index_selected)    
%     if i==index_selected(i)
        format short
        semilogx(v,Pasante(X(z).Streams.Stream.Value(1:end-1)),'DisplayName',strcat(X(z).Streams.Stream.Name,sprintf(' , Masa = %0.2d',sum(X(z).Streams.Stream.Value))),'marker','v');
        hLeg(z)=legend('-DynamicLegend');
        hLeg(z).ItemHitFcn = @action1;
        xlabel('Tamaño [um] (log)');
        ylabel('Cumulative passing [%]');
        hold on
%     end
    grid on
    axis([0 v(1) 0 101]);
end

 end
function action1(src,event)
% This callback toggles the visibility of the line

if strcmp(event.Peer.Visible,'on')   % If current line is visible
    event.Peer.Visible = 'off';      %   Set the visibility to 'off'
else                                 % Else
    event.Peer.Visible = 'on';       %   Set the visibility to 'on'
end
end

end
    