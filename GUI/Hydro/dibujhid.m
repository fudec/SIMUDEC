function dibujhid(hObject,~)

 global cx cy k ck Info cu  axesgnu a b elec  cuh  v 
     
    state=1;
    delete(hObject.Parent)
    axis([0 a 0 b])
    f_hid=figure;
    set(f_hid,'name','Hydrocyclone','numbertitle','off','Position', [500,200,150,280],'Units','pixels','menubar','none','units','normalized','closereq',@Cancelar_callback)
    
   
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
                  'String','Left',...
                  'Position',[30 205 120 50],...
                  'HandleVisibility','off');
              
r2 = uicontrol(bg,'Style','radiobutton',...
                  'String','Right',...
                  'Position',[30 170 120 50],...
                  'HandleVisibility','off');
              
tagtxt = uicontrol(bg,'Style','text',...
                  'String','Tag',...
                  'Position',[35 135 80 30],...
                  'HandleVisibility','off');     

tag = uicontrol(bg,'Style','edit',...
                  'String','',...
                  'Position',[35 105 80 30],...
                  'HandleVisibility','off');          
Aceptar = uicontrol('Parent',bg,...
           'Style','push',...
           'String','Acept',...
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
      elec='Left';
    end
    class(elec)
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
      
    Info(cu).tag='Hydrocyclone';
    p1=plot(cx(k),cy(k)-alto/2,'sk', 'Markersize',10,'LineWidth',1); %%% Sobre tama�o
    Bajo = [cx(k),cy(k)-alto/2];
    hold on
    p2=plot(cx(k),cy(k)+alto/2,'sk', 'Markersize',10,'LineWidth',1); %%% Bajo tama�o
    Sobre = [cx(k),cy(k)+alto/2];

   
    if strcmp(elec,'Left')== 1
        cxd=cx(k)-ancho/2;
        cyd=cy(k)+50;
        p3=plot(axesgnu,cxd,cyd,'sk', 'Markersize',10,'LineWidth',1);
        Hidro_image=imread('HidroI_plot.jpg');
    end
    if strcmp(elec,'Right')== 1
        cxd=cx(k)+ancho/2;
        cyd=cy(k)+50;
        p3=plot(axesgnu,cxd,cyd,'sk', 'Markersize',10,'LineWidth',1);
        Hidro_image=imread('HidroD_plot.jpg');
    end
     
    texy=cy(k)-alto/2;
    texx=cx(k)+10;
    
    Hidro_image=imresize(Hidro_image, [alto ancho]);
    Hidro_image=imrotate(Hidro_image, 180 ); 
    plot_h=image(cx(k)-ancho/2,cy(k)-alto/2,Hidro_image);
    
    Hcuu=text(texx,texy,tagstr,'LineStyle','-','FontSize',9);
    Info(cu).Container=[];
    Info(cu).Index = strcat(tagstr,num2str(rand(1,1)));
    c = uicontextmenu;
    plot_h.UIContextMenu=c;
    m1 = uimenu(c,'Label','Add Model','Callback',@Hidro_modelos);
    m2 = uimenu(c,'Label','Edit Model','Callback',@Hidrociclon_modelos_edit);
    m3 = uimenu(c,'Label','Delete Module','Callback',@Eliminar_modulo_mo);
    m4 = uimenu(c,'Label','Results','Callback',@Hidro_Result_GUI);
    m5 = uimenu(c,'Label','Edit Tag','Callback',@editar_etiqueta);

    setappdata(m1,'Index',Info(cu).Index);
    setappdata(m2,'Index',Info(cu).Index);
    setappdata(m3,'Index',Info(cu).Index); %%%% No es el mismo
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
 

    axis([0 a 0 b])
    axesgnu.XTickLabel={''};
    axesgnu.YTickLabel={''};
   
    Info(cu).ioc=[Bajo 0;Sobre 0;cxd cyd 1];
    axis([0 a 0 b])
    set(gca,'xtick',[],'ytick',[])
    hold on
    
    hold on
    k=k+2;
    cuh=cuh+1;
    cu=cu+1;
    moveit2sep(plot_h)
    return
end
