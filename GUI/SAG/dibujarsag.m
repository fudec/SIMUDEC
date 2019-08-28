function dibujarsag(hObject,~)
    global cx cy k ck Info cu v a b axesgnu  cumc elec
    
    warndlg('Non available')
return

   
     state=1;
     delete(hObject.Parent)
     axis([0 a 0 b])
     f_molc=figure;
     set(f_molc,'name','Molino Bolas','numbertitle','off','Position', [500,200,150,280],'Units','pixels','menubar','none','units','normalized','closereq',@Cancelar_callback)
    
   
bg = uibuttongroup(f_molc);
set(bg,'Visible','on',...
                  'Position',[0 0 1 1],...
                  'SelectionChangedFcn',@callback);

             
txt = uicontrol('Parent',bg,...
           'Style','text',...
           'Position',[25 245 100 25],...
           'String','Orientaci�n');
       
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
 waitfor(f_molc)
    
    function Cancelar_callback(~,~)
          state=0;
          delete(f_molc)
    end
    function Aceptar_callback(~,~)
         tagstr=[];
         tagstr=get(tag,'String');
        elec=bg.SelectedObject.String;
        if isempty(tagstr)
             warndlg('Ingresar etiqueta equipo');
        else
            delete(f_molc)
        end 
       
    end

    if state == 0
        return
    end
    
    function callback(hObject,~)
          
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

    largo=50;
        
    Info(cu).tag='Molino SAG';
    Info(cu).val=rand(length(v));
       
    l(1)=cx(k);
    l(2)=cx(k)+largo;
    l(3)=cy(k);
  
    alto=largo;
    if strcmp(elec,'Izquierda')
        Molc_image=imread('SAG_I_plot.jpg'); %%% Im�genes se leen rotadas
        hold on
        p1=plot(cx(k)-largo/2,cy(k)+60,'s', 'Markersize',13,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada
        p2=plot(cx(k)+largo/2,cy(k)+60,'s', 'Markersize',13,'LineWidth',1,'color',160*ones(3,1)/256); %% Salida
        cxd = [cx(k)-largo/2-13/2,cy(k)+60];
        cyd = [cx(k)+largo/2+13/2,cy(k)+60];
    
    elseif strcmp(elec,'Derecha')
        Molc_image=imread('SAG_D_plot.jpg');
        hold on
        p1=plot(cx(k)-largo/2,cy(k)+60,'s', 'Markersize',13,'LineWidth',1,'color',160*ones(3,1)/256); %% Entrada
        p2=plot(cx(k)+largo/2,cy(k)+60,'s', 'Markersize',13,'LineWidth',1,'color', 160*ones(3,1)/256); %% Salida
        cxd = [cx(k)-largo/2+13/2,cy(k)+60];
        cyd = [cx(k)+largo/2-13/2,cy(k)+60];
        
    end
    
        Info(cu).ioc=[cxd 1;cyd 0];
    
    Molc_image=imresize(Molc_image, [largo*3.5 largo]);
    Molc_image=imrotate(Molc_image,180);
    texy=cy(k)+alto/2;
    texx=cx(k)+largo/2;
    Mcuu=text(texx,texy,tagstr,'LineStyle','-','FontSize',9);
    Info(cu).Container=[];
    Info(cu).Index = strcat(tagstr,num2str(rand(1,1)));
    
    plot_h=image(l(1)-alto/2,abs(l(3)-alto/2),Molc_image);
    c = uicontextmenu;
    plot_h.UIContextMenu=c;
    p1.Tag=tagstr;
    p2.Tag=tagstr;
    plot_h.Tag=tagstr;
    
    m1 = uimenu(c,'Label','Add Model','Callback',@MolinoSAG_modelos);
    m2 = uimenu(c,'Label','Edit Model','Callback',@MolinoSAG_modelos_edit);
    m3 = uimenu(c,'Label','Delete Module','Callback',@Eliminar_modulo_SAG); 
    m4 = uimenu(c,'Label','Results','Callback',@mSAG_Result_GUI);
    m5 = uimenu(c,'Label','Edit Tag','Callback',@editar_etiqueta);
    setappdata(m1,'Index',Info(cu).Index);
    setappdata(m2,'Index',Info(cu).Index);
    setappdata(m3,'Index',Info(cu).Index); %%%% No es el mismo
    setappdata(m4,'Index',Info(cu).Index);
    setappdata(m5,'Index',Info(cu).Index);
    
    plot_h.UIContextMenu.Children(1).UserData.Index=Info(cu).Index;
    plot_h.UIContextMenu.Children(2).UserData.Index=Info(cu).Index;
    plot_h.UIContextMenu.Children(3).UserData.Index=Info(cu).Index;
    plot_h.UIContextMenu.Children(4).UserData.Index=Info(cu).Index;
    plot_h.UIContextMenu.Children(5).UserData.Index=Info(cu).Index;    
    plot_h.UserData.points=[p1 p2 Mcuu];
   
   
    Info(cu).CatNum=tagstr;
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
     
    hold on
    moveit2mol(plot_h)
    k=k+2;
    cumc=cumc+1;
    cu=cu+1;
    axis(axesgnu,[0 a 0 b])
    axesgnu.XTick=('');
    axesgnu.YTick=('');
    
end