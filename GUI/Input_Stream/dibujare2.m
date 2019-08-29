
function dibujare2(hObject,~)

global cx cy k ck Info cu  ec  v a b TagIdentifier RC_text axesgnu wcunt m

state = 1;

delete(hObject.Parent)
if isempty(v)
    warndlg('There is not sizes vector','Warning');
    return     
end
rrr=figure;
set(rrr,'name','Input Stream','numbertitle','off','Position', [200, 350, 200, 150],'Units','pixels','menubar','none','units','normalized','Resize','off','CloseRequestFcn',@cerrare)

function cerrare(~,~)
    data = rrr.Children(3).UserData;
    
    if isempty(data)
        choice = questdlg('Not saved anythin yet. Continue?', 'Warning', 'Yes','No','No');
        switch choice
            case 'Yes'
            delete(rrr)
            state = 0;
             case 'No'
             return      
        end
    else
        delete(rrr)
        return
    end
end

bg = uibuttongroup(rrr);
set(bg,'Visible','on',...
                  'Position',[0 0 1 1],...
                  'SelectionChangedFcn',@bselection);
r1 = uicontrol(bg,'Style',...
                  'radiobutton',...
                  'String','w/w%',...
                  'Position',[10 120 20 30],...
                  'HandleVisibility','off');
              
r2 = uicontrol(bg,'Style','radiobutton',...
                  'String','Water',...
                  'Position',[10 80 20 30],...
                  'HandleVisibility','off');
              
 Agregar_Button= uicontrol('style','push','string','Size distribution','Callback',@AgregarEntrada,...
                 'position',[30,40,150,20]);
             Agregar_Button.UserData=cu;

 w_Text=uicontrol('Parent',bg,...
           'Style','text',...
           'Position',[80 120 25 25],...
           'String','%w');
 Water_Text=uicontrol('Parent',bg,...
           'Style','text',...
           'Position',[70 80 50 25],...
           'String','Water [m3/h]');
 
 Water_Edit= uicontrol('Parent',rrr,...
           'Style','edit',...
           'Position',[130 80 50 25],...
           'String','0'); 

 w_Edit = uicontrol('Parent',rrr,...
           'Style','edit',...
           'Position',[130 120 50 25],...
           'String','0');
       
 set(w_Edit,'Enable','on');
 set(Water_Edit,'Enable','off');
 
function bselection(~,event)   
        selec=get(event.NewValue,'String');
       if isequal(selec,'Water') 
               set(Water_Edit,'Enable','on')
               set(w_Edit,'Enable','off')              
       else
               set(Water_Edit,'Enable','off')
               set(w_Edit,'Enable','on')             
       end
 end
Cerrar = uicontrol('Parent',rrr,'style','push','string','Close','Callback',@cerrare,...
      'position',[2,2,100,22]);
Water_Edit.UserData=cu;
aceptar=uicontrol;           
aceptar.UserData.Edit=[Water_Edit w_Edit];
aceptar.UserData.m = m;
SaveB= aceptar;
set(aceptar,'Parent',rrr,...
           'Style','push',...
           'Position',[103 2 100 22],...
           'String','Save',...
           'Callback',@getPEN);

waitfor(rrr)
if state == 0
    return
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


     try 
     [x,y] =getpts(axesgnu);
     catch
         return
     end
     
     if length(x) ~= 2
         return
     end
     axis([0 a 0 b])
     delete(RC_text);
     RC_text=[];

    
    Info(cu).en.val=m;
    TagIdentifier=TagIdentifier+1;
   
   
    
    if k==1
        cx=zeros(1);
        cy=zeros(1);
        ck=zeros(1);
    end
   
    cx(k:k+1)=x;
    cy(k:k+1)=y;
cIdx=cu;
wIdx=0;
if wcunt > 1
            Index=0;
            vector=0;
            for i=1:cu
                if strcmp(Info(i).tag,'Entrada') || strcmp(Info(i).tag,'Flujo')== 1
                    Index=Index+1;
                    Info(i).CatNum
                    vector(Index)=Info(i).CatNum;
                end
            end
            vector=sort(vector);
            Max=max(vector);
                if wcunt-1 < Max
                    for i=1:length(vector)
                            if i ~= vector(i)
                                wIdx=i;
                                break
                            end
                    end

                else
                    wIdx=wcunt;
                end
else
        wIdx=wcunt;
end

if ec > 1
            Index=0;
            vector=0;
            for i=1:cu
                if strcmp(Info(i).tag,'Entrada')
                    Index=Index+1;
                    Info(i).CatNum
                    vector(Index)=Info(i).CatNum;
                end
            end
            vector=sort(vector);
            Max=max(vector);
                if ec-1 < Max
                    for i=1:length(vector)
                            if i ~= vector(i)
                                Idx=i;
                                break
                            end
                    end

                else
                    Idx=ec;
                end
else
        Idx=ec;
end
    Info(cIdx).CatNum=Idx;
    Info(cIdx).k=[TagIdentifier 1];
    Info(cIdx).ioc=[cx(k) cy(k) 1;cx(k+1) cy(k+1) 0;zeros(1,3)];
    Info(cIdx).tag='Input';
%     Info(cu).water=Water;
    Info(cIdx).Stream=Stream(wIdx);
    Info(cIdx).Stream.Name=sprintf('E%d',Idx);
    
    Info(cu).Container=[];
    Info(cIdx).Stream.Value=m;
    Info(cIdx).c=cIdx;
    Info(cIdx).Index = strcat('Input',num2str(rand(1,1)));
%     
    m=abs((cy(k+1)-cy(k))/(cx(k+1)-cx(k)));
    d=((cy(k+1)-cy(k))^2+(cx(k+1)-cx(k))^2)^0.5;
    alfa=atand(m);
       
    if m < inf && m > 0
        
        if  cy(k+1) > cy(k)
%             px=[cx(k) cy(k)+d*cos(alfa)];
            l=d*sind(alfa);
            
            if cx(k+1) > cx(k)
                l1=line([cx(k) cx(k)],[cy(k) cy(k)+l],'Color',150*ones(3,1)/256);
                hold on
                l2=line([cx(k) cx(k+1)],[cy(k)+l cy(k)+l],'Color',150*ones(3,1)/256);
                hold on
                p1=plot(cx(k+1),cy(k+1),'>', 'Markersize',7,'Color',100*ones(3,1)/256);
                hold on
                str=sprintf('E%d',Idx);
                texy=cy(k)+0.9*l;
                texx=(cx(k+1)-cx(k))*0.2+cx(k);
                plot_h=text(texx,texy,str,'LineStyle','-','EdgeColor',130*ones(3,1)/256);
                
            elseif cx(k+1) <  cx(k)
                l1=line([cx(k) cx(k)],[cy(k) cy(k)+l],'Color',150*ones(3,1)/256);
                hold on
                l2=line([cx(k) cx(k+1)],[cy(k)+l cy(k)+l],'Color',150*ones(3,1)/256);
                hold on
                p1=plot(cx(k+1),cy(k+1),'<', 'Markersize',7,'Color',100*ones(3,1)/256);
                hold on
                str=sprintf('E%d',Idx);
                texy=cy(k)+0.9*l;
                texx=cx(k)-0.2*(cx(k)-cx(k+1));
                plot_h=text(texx,texy,str,'LineStyle','-','EdgeColor','black');
            end

        end
        if cy(k+1) < cy(k)
            l=d*sind(alfa);
            A=d*cosd(alfa);
            if cx(k+1) > cx(k)
                hold on
                l1=line([cx(k) cx(k)+A],[cy(k) cy(k)],'Color',150*ones(3,1)/256);
                hold on
                l2=line([cx(k)+A cx(k+1)],[cy(k) cy(k+1)],'Color',150*ones(3,1)/256);
                hold on
                p1=plot(cx(k+1),cy(k+1),'>', 'Markersize',7,'Color',100*ones(3,1)/256);
                hold on
                str=sprintf('E%d',Idx);
                texy=cy(k)-0.1*(cy(k)-cy(k+1));
                texx=cx(k)+0.84*A;
                plot_h=text(texx,texy,str,'LineStyle','-','EdgeColor','black');
            
            elseif cx(k+1) <  cx(k)
                l1=line([cx(k) cx(k)-A],[cy(k) cy(k)],'Color',150*ones(3,1)/256);
                hold on
                l2=line([cx(k)-A cx(k+1)],[cy(k) cy(k+1)],'Color',150*ones(3,1)/256);
                hold on
                p1=plot(cx(k+1),cy(k+1),'<', 'Markersize',7,'Color',100*ones(3,1)/256);
                hold on
                str=sprintf('E%d',Idx);
                texy=cy(k)-0.1*(cy(k)-cy(k+1));
                texx=cx(k)-0.84*A;
                plot_h=text(texx,texy,str,'LineStyle','-','EdgeColor','black');
            end
            
        end
    elseif m == 0
        A=d*cosd(alfa);
        p1=plot(cx(k+1),cy(k+1),'<', 'Markersize',7,'Color',100*ones(3,1)/256);
        hold on
        l1=line([cx(k) cx(k+1)],[cy(k) cy(k+1)],'Color',150*ones(3,1)/256);
        hold on
        l2=line([0 0],[0 0],'Color',150*ones(3,1)/256);
        str=sprintf('E%d',Idx);
        texy=cy(k)-0.1*(cy(k)-cy(k+1));
        texx=cx(k)-0.84*A;
        plot_h=text(texx,texy,str,'LineStyle','-','EdgeColor','black');
        hold on
    elseif m == inf
        A=d*cosd(alfa);
        p1=plot(cx(k+1),cy(k+1),'<', 'Markersize',7,'Color',100*ones(3,1)/256);
        hold on
        l1=line([cx(k) cx(k+1)],[cy(k) cy(k+1)],'Color',150*ones(3,1)/256);
        hold on
        l2=line([0 0],[0 0],'Color',150*ones(3,1)/256);
        str=sprintf('E%d',Idx);
        texy=cy(k)-0.1*(cy(k)-cy(k+1));
        texx=cx(k)-0.84*A;
        plot_h=text(texx,texy,str,'LineStyle','-','EdgeColor','black');
        hold on     
    end
       hold on
    p2=plot(cx(k),cy(k),'.', 'Markersize',7,'Color',105*ones(3,1)/256);
    Info(cIdx).Container=[];
    Info(cIdx).Index = strcat(tagstr,num2str(rand(1,1)));
    hold on
    c = uicontextmenu;
    plot_h.UIContextMenu=c;
    
    m3 = uimenu(c,'Label','Delete Input','Callback',@Eliminar_moduloe);
    m4 = uimenu(c,'Label','Edit Input','Callback',@Editar_Entrada);
    setappdata(m1,'Index',Info(cIdx).Index);
    
    plot_h.UIContextMenu.Children(1).UserData.Index=Info(cu).Index;
    plot_h.UIContextMenu.Children(2).UserData.Index=Info(cu).Index;
    plot_h.UIContextMenu.Children(3).UserData.Index=Info(cu).Index;
    plot_h.UIContextMenu.Children(4).UserData.Index=Info(cu).Index;
    
    plot_h.UserData.points=[p1 p2 l1 l2];
    plot_h.UserData.image=1; %%%%%%%%%%%%%% Revisar
    plot_h.UserData.Index=Info(cIdx).Index;
    Info(cIdx).h=plot_h;
    hold on

    k=k+2;
    moveit2f(plot_h);
    cu=cu+1;
    ec=ec+1;
    wcunt=wcunt+1;
    m=[];

 end 
    

 