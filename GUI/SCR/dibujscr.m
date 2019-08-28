function dibujscr(hObject,~)

 global cx cy k ck Info cu  axesgnu a b elec  cuh  v state
    state=1;
    delete(hObject.Parent)
    axis([0 a 0 b])
    f_hid=figure;
    set(f_hid,'name','Screener','numbertitle','off','Position', [500,200,150,280],'Units','pixels','menubar','none','units','normalized','closereq',@Cancelar_callback)
    
   
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
           'String','Accept',...
           'Position',[15 40 120 25],...           
           'Callback',@Aceptar_callback);
Cancelar = uicontrol('Parent',bg,...
           'Style','push',...
           'Position',[15 15 120 25],...
           'String','Cancel',...
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
             warndlg('Input Tag');
        else
            delete(f_hid)
        end 
       
    end

    if state == 0
        return
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
   
    cx(k)=x;
    cy(k)=y;
    
    ancho=32;
    alto=150;
    largo=90;
  
    
    Info(cu).tag='Screener';
    hold on
 
    if strcmp(elec,'Izquierda')== 1
        cxd=cx(k)-ancho/2;
        cyd=cy(k)+20;
        p3=plot(axesgnu,cxd,cyd,'sk', 'Markersize',10,'LineWidth',1);
        SCR_image=imread('SCR_I_plot.jpg');
        p1=plot(cx(k)+80,cy(k)-35,'sk', 'Markersize',10,'LineWidth',1); %%% Sobre tama�o
        p2=plot(cx(k)+10,cy(k)-alto/1.7,'sk', 'Markersize',10,'LineWidth',1); %%% Bajo tama�o
        
        Sobre = [cx(k)+80,cy(k)-35];
        Bajo = [cx(k)+10,cy(k)-alto/1.7];
        Info(cu).ioc=[Bajo 0;Sobre+5 0;cxd-5 cyd 1];
                
    end
    if strcmp(elec,'Derecha')== 1
        cxd=cx(k)+75;
        cyd=cy(k)+20;
        p3=plot(axesgnu,cxd,cyd,'sk', 'Markersize',10,'LineWidth',1);  
        hold on
        SCR_image=imread('SCR_D_plot.jpg');
        p1=plot(cx(k)-23,cy(k)-35,'sk', 'Markersize',10,'LineWidth',1); %%% Sobre tama�o
        p2=plot(cx(k)+50,cy(k)-alto/1.7,'sk', 'Markersize',10,'LineWidth',1); %%% Bajo tama�o
        
        Sobre = [cx(k)-23,cy(k)-35];
        Bajo = [cx(k)+50,cy(k)-alto/1.7];
        Info(cu).ioc=[Bajo 0;Sobre 0;cxd+5 cyd 1];

        
    end
    
 
    texy=cy(k)+15;
    texx=cx(k)+20;
       
    SCR_image=imresize(SCR_image, [largo largo]);
    SCR_image=imrotate(SCR_image, 180 ); 
    plot_h=image(cx(k)-ancho/2,cy(k)-alto/2,SCR_image);
    
    Hcuu=text(texx,texy,tagstr,'LineStyle','-','FontSize',9);
    Info(cu).Container=[];
    Info(cu).Index = strcat(tagstr,num2str(rand(1,1)));
    c = uicontextmenu;
    plot_h.UIContextMenu=c;
    m1 = uimenu(c,'Label','Add Model','Callback',@SCR_modelos);
    m2 = uimenu(c,'Label','Edit Model','Callback',@SCR_modelos_edit);
    m3 = uimenu(c,'Label','Delete Module','Callback',@Eliminar_modulo_SCR);
    m4 = uimenu(c,'Label','Resuls','Callback',@SCR_Result_GUI);
    m5 = uimenu(c,'Label','Edit Tag','Callback',@editar_etiqueta_sep);
    
    setappdata(m1,'Index',Info(cu).Index);
    setappdata(m2,'Index',Info(cu).Index);
    setappdata(m3,'Index',Info(cu).Index); 
    setappdata(m4,'Index',Info(cu).Index);
    setappdata(m5,'Index',Info(cu).Index);
    p1.UserData = Info(cu).Index;
    p2.UserData = Info(cu).Index;
    p3.UserData = Info(cu).Index;
    Hcuu.UserData = Info(cu).Index;
    
    plot_h.UIContextMenu.Children(1).UserData.Index=Info(cu).Index;
    plot_h.UIContextMenu.Children(2).UserData.Index=Info(cu).Index;
    plot_h.UIContextMenu.Children(3).UserData.Index=Info(cu).Index;
    plot_h.UIContextMenu.Children(4).UserData.Index=Info(cu).Index;
    plot_h.UIContextMenu.Children(5).UserData.Index=Info(cu).Index;
        plot_h.UserData.points=[p1 p2 p3 Hcuu];

    
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
