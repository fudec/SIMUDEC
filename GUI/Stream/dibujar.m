function dibujar(hObject,~)
    global cx cy k  Info cu  axesgnu cuf a b  TagIdentifier G RC_text  wcunt 

     delete(hObject.Parent);
     axis(axesgnu,[0 a 0 b])  
    
     try 
        [x,y] =getpts(axesgnu);
     catch
         return
     end
 
     if length(x) ~= 2
         return
     end
       
     delete(RC_text)
     RC_text=[];
     G=0;
     TagIdentifier=TagIdentifier+1;
    
     
    if k==1
        cx=zeros(1,k+1);
        cy=zeros(1,k+1);
    end
    
 cIdx=cu;
 wIdx=0;
 if wcunt > 1
            Index=0;
            vector=0;
            for i=1:cu-1
                if strcmp(Info(i).tag,'Stream') || strcmp(Info(i).tag,'Input')== 1
                    Index=Index+1;
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
    
Idx=0;
if cuf > 1
            Index=0;
            vector=0;
            for i=1:cu-1
                if strcmp(Info(i).tag,'Stream')
                    Index=Index+1;
                    vector(Index)=Info(i).CatNum;
                end
            end
            vector=sort(vector);
            Max=max(vector);
                if cuf-1 < Max
                    for i=1:length(vector)
                            if i ~= vector(i)
                                Idx=i;
                                break
                            end
                    end

                else
                    Idx=cuf;
                end
else
        Idx=cuf;
end

    Info(cIdx).Stream.Name=sprintf('F%d',Idx);
    Info(cIdx).CatNum=Idx;
    cx(k:k+1)=x;
    cy(k:k+1)=y;
    Info(cIdx).k=[TagIdentifier 2];
    Info(cIdx).ioc=[cx(k) cy(k) 1;cx(k+1) cy(k+1) 0;zeros(1,3)];
    Info(cIdx).tag='Stream';
    Info(cIdx).Stream=Stream(wIdx);
    Info(cIdx).Stream.Name=sprintf('F%d',Idx);
    Info(cIdx).c=cIdx;
    
    m=abs((cy(k+1)-cy(k))/(cx(k+1)-cx(k)));
    d=((cy(k+1)-cy(k))^2+(cx(k+1)-cx(k))^2)^0.5;
    alfa=atand(m);
       
    if m < inf && m > 0
        
        if  cy(k+1) > cy(k)
            l=d*sind(alfa);
            
            if cx(k+1) > cx(k)
                l1=line([cx(k) cx(k)],[cy(k) cy(k)+l],'Color',150*ones(3,1)/256);
                hold on
                l2=line([cx(k) cx(k+1)],[cy(k)+l cy(k)+l],'Color',150*ones(3,1)/256);
                p1=plot(cx(k+1),cy(k+1),'>', 'Markersize',7,'Color',100*ones(3,1)/256);
                str=sprintf('F %d',Idx);
                texy=cy(k)+0.9*l;
                texx=(cx(k+1)-cx(k))*0.2+cx(k);
                plot_h=text(texx,texy,str,'LineStyle','-','EdgeColor',130*ones(3,1)/256);
                
            elseif cx(k+1) <  cx(k)
                l1=line([cx(k) cx(k)],[cy(k) cy(k)+l],'Color',150*ones(3,1)/256);
                hold on
                l2=line([cx(k) cx(k+1)],[cy(k)+l cy(k)+l],'Color',150*ones(3,1)/256);
                p1=plot(cx(k+1),cy(k+1),'<', 'Markersize',7,'Color',100*ones(3,1)/256);
                str=sprintf('F %d',Idx);
                texy=cy(k)+0.9*l;
                texx=cx(k)-0.2*(cx(k)-cx(k+1));
                plot_h=text(texx,texy,str,'LineStyle','-','EdgeColor','black');
            end

        end
        if cy(k+1) < cy(k)
            A=d*cosd(alfa);
            if cx(k+1) > cx(k)
                l1=line([cx(k) cx(k)+A],[cy(k) cy(k)],'Color',150*ones(3,1)/256);
                hold on
                l2=line([cx(k)+A cx(k+1)],[cy(k) cy(k+1)],'Color',150*ones(3,1)/256);
                p1=plot(cx(k+1),cy(k+1),'>', 'Markersize',7,'Color',100*ones(3,1)/256);
                str=sprintf('F %d',Idx);
                texy=cy(k)-0.1*(cy(k)-cy(k+1));
                texx=cx(k)+0.84*A;
                plot_h=text(texx,texy,str,'LineStyle','-','EdgeColor','black');
            
            elseif cx(k+1) <  cx(k)
                l1=line([cx(k) cx(k)-A],[cy(k) cy(k)],'Color',150*ones(3,1)/256);
                hold on
                l2=line([cx(k)-A cx(k+1)],[cy(k) cy(k+1)],'Color',150*ones(3,1)/256);
                p1=plot(cx(k+1),cy(k+1),'<', 'Markersize',7,'Color',100*ones(3,1)/256);
                str=sprintf('F %d',Idx);
                texy=cy(k)-0.1*(cy(k)-cy(k+1));
                texx=cx(k)-0.84*A;
                plot_h=text(texx,texy,str,'LineStyle','-','EdgeColor','black');
            end
            
        end
    
    elseif m == 0
        
        l1=line([cx(k) cx(k+1)],[cy(k) cy(k+1)],'Color',150*ones(3,1)/256);
        hold on
        l2=line([0 0],[0 0],'Color',150*ones(3,1)/256);
        str=sprintf('F %d',Idx);
        texy=cy(k)-0.1*(cy(k)-cy(k+1));
        
        if cx(k+1) > cx(k)
                p1=plot(cx(k+1),cy(k+1),'>', 'Markersize',7,'Color',100*ones(3,1)/256);
                texx=(cx(k+1)-cx(k))*0.2+cx(k);
                plot_h=text(texx,texy,str,'LineStyle','-','EdgeColor',130*ones(3,1)/256);
        elseif cx(k+1) <  cx(k)       
                p1=plot(cx(k+1),cy(k+1),'<', 'Markersize',7,'Color',100*ones(3,1)/256);
                texx=cx(k)-0.2*(cx(k)-cx(k+1));
                plot_h=text(texx,texy,str,'LineStyle','-','EdgeColor','black');
        end
    
    elseif m == inf
        A=d*cosd(alfa);
        hold on
        l1=line([cx(k) cx(k+1)],[cy(k) cy(k+1)],'Color',150*ones(3,1)/256);
        hold on
        l2=line([0 0],[0 0],'Color',150*ones(3,1)/256);
        str=sprintf('F %d',Idx);
        texx=cx(k)-0.84*A;
        hold on  
        if  cy(k+1) > cy(k)
            l=d*sind(alfa);                           
                hold on
                texy=cy(k)+0.9*l;
                plot_h=text(texx,texy,str,'LineStyle','-','EdgeColor',130*ones(3,1)/256);
                p1=plot(cx(k+1),cy(k+1),'^', 'Markersize',7,'Color',100*ones(3,1)/256);

        elseif cy(k+1) < cy(k)
                hold on            
                p1=plot(cx(k+1),cy(k+1),'v', 'Markersize',7,'Color',100*ones(3,1)/256);
                texy=cy(k)-0.1*(cy(k)-cy(k+1));
                plot_h=text(texx,texy,str,'LineStyle','-','EdgeColor','black');
            
        end
        
    end
    hold on
    p2=plot(cx(k),cy(k),'.', 'Markersize',25,'Color',105*ones(3,1)/256);
    hold on
    c = uicontextmenu;
    plot_h.UIContextMenu=c;
    Info(cIdx).Container=[];
    Info(cIdx).Index = strcat(tagstr,num2str(rand(1,1)));
    
    m = uimenu(c,'Label','Delete Stream','Callback',@Eliminar_modulof);
    setappdata(m1,'Index',Info(cIdx).Index);
    
    
    plot_h.UIContextMenu.Children(1).UserData.Index=Info(cIdx).Index;
    plot_h.UIContextMenu.Children(2).UserData.Index=Info(cIdx).Index;
    plot_h.UIContextMenu.Children(3).UserData.Index=Info(cIdx).Index;
    plot_h.UIContextMenu.Children(4).UserData.Index=Info(cIdx).Index;
    plot_h.UserData.points=[p1 p2 l1 l2];
    plot_h.UserData.image=1; %%%%%%%%%%%%%% Revisar
    plot_h.UserData.Index=Info(cIdx).Index;
    Info(cIdx).h=plot_h;
    
    hold on
    k=k+2;
    moveit2f(plot_h);
    cu=cu+1;
    cuf=cuf+1;
    wcunt=wcunt+1;
 end 
    
