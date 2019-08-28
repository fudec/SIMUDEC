edifunction dibujsplit(hObject,~)

 global cx cy k ck Info cu  axesgnu a b elec  cuh  v state
    axis([0 a 0 b])
    state=1;
    delete(hObject.Parent)
    f_hid=figure;
    set(f_hid,'name','Separador','numbertitle','off','Position', [500,200,150,280],'Units','pixels','menubar','none','units','normalized','closereq',@Cancelar_callback)
    
   
bg = uibuttongroup(f_hid);
set(bg,'Visible','on',...
                  'Position',[0 0 1 1],...
                  'SelectionChangedFcn',@callback);

             
txt = uicontrol('Parent',bg,...
           'Style','text',...
           'Position',[25 245 100 25],...
           'String','Orientation');
       
r1 = uicontrol(bg,'Style',...
                  'radiobutton',...
                  'String','Izquierda',...
                  'Position',[30 205 120 50],...
                  'HandleVisibility','off');
              
r2 = uicontrol(bg,'Style','radiobutton',...
                  'String','Derecha',...
                  'Position',[30 170 120 50],...
                  'HandleVisibility','off');
              
tagtxt = uicontrol(bg,'Style','text',...
                  'String','Etiqueta',...
                  'Position',[35 135 80 30],...
                  'HandleVisibility','off');     

tag = uicontrol(bg,'Style','edit',...
                  'String','',...
                  'Position',[35 105 80 30],...
                  'HandleVisibility','off');          
Aceptar = uicontrol('Parent',bg,...
           'Style','push',...
           'String','Aceptar',...
           'Position',[15 40 120 25],...           
           'Callback',@Aceptar_callback);
Cancelar = uicontrol('Parent',bg,...
           'Style','push',...
           'Position',[15 15 120 25],...
           'String','Cancelar',...
           'Callback',@Cancelar_callback);
 waitfor(f_hid)
    
    function Cancelar_callback(~,~)
          state=0;
          delete(f_hid)
    end
    function Aceptar_callback(~,~)
         tagstr=[];
         tagstr=get(tag,'String');
        elec=bg.SelectedObject.String;
        if isempty(tagstr)
             warndlg('Ingresar etiqueta equipo');
        else
            delete(f_hid)
        end 
       
    end

    if state == 0
        return
    end
    
    function callback(~,~)
          
    end

    if isempty(elec) 
      elec='Izquierda';
    end
    
     try 
    [x,y] =getpts(axesgnu);
     catch
         return
     end
     
     if length(x) ~= 1
         return
     end

    if k==1
        cx=zeros(1);
        cy=zeros(1);
        ck=zeros(1);
    end
   
    cx(k:k+1)=x;
    cy(k:k+1)=y;
    
    ancho=32;
    alto=150;
    largo=60;
    
    Info(cu).tag='Spliter';
    if strcmp(elec,'Izquierda')== 1
        cxd=cx(k)-ancho/2-7;
        cyd=cy(k)-9;
        p3=plot(axesgnu,cxd,cyd,'sk', 'Markersize',10,'LineWidth',1);
        hold on
        Spliter_image=imread('SplitI_plot.jpg');
        p1=plot(cx(k)+48,cy(k)+40,'sk', 'Markersize',10,'LineWidth',1); %%% Sobre tama�o
        p2=plot(cx(k)+48,cy(k)-55,'sk', 'Markersize',10,'LineWidth',1); %%% Bajo tama�o
        
        Sobre = [cx(k)+48+5,cy(k)+40]; %%% Sumarle mitad tama�o marcador
        Bajo = [cx(k)+48+5,cy(k)-55];
        Info(cu).ioc=[Bajo 0;Sobre+5 0;cxd-5 cyd 1];

                
    end
    if strcmp(elec,'Derecha')== 1
        cxd=cx(k)+ancho/2+33;
        cyd=cy(k)-9;
        p3=plot(axesgnu,cxd,cyd,'sk', 'Markersize',10,'LineWidth',1);  
        hold on
        Spliter_image=imread('SplitD_plot.jpg');
        p1=plot(cx(k)-22,cy(k)+40,'sk', 'Markersize',10,'LineWidth',1); %%% Sobre tama�o
        p2=plot(cx(k)-22,cy(k)-55,'sk', 'Markersize',10,'LineWidth',1); %%% Bajo tama�o
        
        Sobre = [cx(k)-22-5,cy(k)+40]; %%% Restarle mitad tama�o marcador
        Bajo = [cx(k)-22-5,cy(k)-55];
        Info(cu).ioc=[Bajo 0;Sobre 0;cxd+5 cyd 1];

        
    end
    
    texy=cy(k)+65;
    texx=cx(k)+20;
       
    Spliter_image=imresize(Spliter_image, [largo*2.2 largo]);
    plot_h=image(cx(k)-ancho/2,cy(k)-alto/2,Spliter_image);
    hold on
    Hcuu=text(texx,texy,tagstr,'LineStyle','-','FontSize',9);
    
    c = uicontextmenu;
    plot_h.UIContextMenu=c;
    m1 = uimenu(c,'Label','Model','Callback',@Split_modelos);
    m3 = uimenu(c,'Label','Delete Module','Callback',@Eliminar_modulo_Split);
    setappdata(m1,'Index',strcat(tagstr,num2str(rand(1,1))));
    setappdata(plot_h,'elec',elec)
    
    
    plot_h.UIContextMenu.Children(1).UserData.c=cu;
    plot_h.UIContextMenu.Children(2).UserData.c=cu;
    plot_h.UserData.points=[p1 p2 p3 Hcuu]; %%%% Revisar entradas/salidas
    setappdata(plot_h,'Index',cu);
    
    
    Info(cu).h=plot_h;
    Info(cu).M=tagstr;
    Info(cu).tag2=tagstr;
    Info(cu).PasanteA=zeros(length(v),1);
    Info(cu).PasanteP=zeros(length(v),1);
    Info(cu).W=0;
    Info(cu).ro=0;
    Info(cu).TPH=0;
    Info(cu).F80=0;
    Info(cu).P80=0;
    Info(cu).FW=0;
    Info(cu).c=cu;
    m4.UserData=Info(cu);
     
    k=k+2;
    cuh=cuh+1;
    cu=cu+1;
    axis([0 a 0 b])
    set(gca,'xtick',[],'ytick',[])
    moveit2sep(plot_h)

end
