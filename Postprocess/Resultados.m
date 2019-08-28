function Resultados(~,~)

global v x e v1 X  a b s Info coso
a=1366;
b=1280;
if isempty(X(1).Length)
    Message='There are not results';
    exito = warndlg(Message);
    return
end
t=length(x)/length(v); %%%%% N�mero de vectores
delta=length(v); %%%%%% Length vector i
cuff=length(X);
% X(1).c=x(1:delta);
% if t >= 2
%     for ii=2:t
%         X(ii).c=x((ii-1)*delta+1:ii*delta);
%     end
% else
%    
% end
% X(5).F=Pasante(X(5).F);
for o=1:X(1).Length
    X(o).P80=F80(X(o).Streams.Stream.Value(1:end-1),v);
end
for l=1:X(1).Length
    X(l).c=X(l).F;
end

% n=length(X(1).c);
% 
% for j=1:t
%      SumX=sum(X(j).c);
%      X(j).c=X(j).c/SumX;
%      X(j).c(n)=X(j).c(n)*100;
% end
% 
% for j=1:t
%     for r=n-1:-1:1
%       X(j).c(r)=X(j).c(r+1)+X(j).c(r)*100;
%     end
% end

n=X(1).Length;
for z=e+1:e+v1
    X(z-1).tag=sprintf('Flujo %d',z);
end

   c=200;
   d=400;

   f5=figure('name','Results','numbertitle','off','Position', [300, 150, c, d],'menubar','none');
    
% for i=1:length(Info)
%     if isfield(Info(i),'en') == 1
%         if isfield(Info(i).en,'val') == 1          
%             Info(i).en.valP=Info(i).en.val;
%                 
% %             for mm=1:length(Info(i).en.valP)
%                 SumX=sum(Info(i).en.valP);               
%                 Info(i).en.valP=Info(i).en.valP/SumX*100;
%                 for r=n-1:-1:1
%                     Info(i).en.valP(r)=Info(i).en.valP(r+1)+Info(i).en.valP(r);
%                 end
% %             end
%             
%         end
%     end
% end
%   Info(1).en.valP          
% for j=v1+1:v1+e
%     str(j)=cellstr(sprintf('Entrada %d',Info(j-v1).en.k));
% %     X(j).c=Info(j-v1).en.valP;
% end

for m=1:X(1).Length %% Mientras tanto
    str(m)=cellstr(X(m).Streams.Stream.Name);
end
   
%    str=evalin('base','X(:).tag')
    
   lb = uicontrol(f5,'Style','listbox',...
                'String',str,...
                'Position',[30 90 130 280],'Value',1,'Max',cuff,'Min',0);
   Guardar_graf= uicontrol(f5,'style','push','string','Acept','Callback',@pushcallback,...
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
    