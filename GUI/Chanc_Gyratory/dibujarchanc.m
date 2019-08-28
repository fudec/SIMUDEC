function dibujarchanc(hObject,~)
    global cx cy k ck Info cu v a b axesgnu  
   
     state=1;
     delete(hObject.Parent)
     axis([0 a 0 b])
     f_chanc=figure;
     set(f_chanc,'name','Gyratory Crusher','numbertitle','off','Position', [500,200,150,180],'Units','pixels','menubar','none','units','normalized','closereq',@Cancelar_callback,...
         'Resize','off')
    
   
bg = uibuttongroup(f_chanc);
set(bg,'Visible','on',...
                  'Position',[0 0 1 1]);

             
txt = uicontrol('Parent',bg,...
           'Style','text',...
           'Position',[25 245 100 25],...
           'String','Orientation');
   
              
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
 waitfor(f_chanc)
    
    function Cancelar_callback(~,~)
          state=0;
          delete(f_chanc)
    end
    function Aceptar_callback(~,~)
         tagstr=[];
         tagstr=get(tag,'String');
        if isempty(tagstr)
             warndlg('Ingresar etiqueta equipo');
        else
            delete(f_chanc)
        end 
    end

    if state == 0
        return
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

    largo=105;
    alto=largo/1.3;
        
    Info(cu).tag='Crusher';
    Info(cu).val=rand(length(v));
       
    l(1)=cx(k);
    l(2)=cx(k)+largo;
    l(3)=cy(k);
    
    Chanc_image=imread('Chancador_plot.jpg'); %%% Im�genes se leen rotadas
    hold on
    p1=plot(cx(k),cy(k)+alto/1.2,'s', 'Markersize',13,'LineWidth',1,'color', 105*ones(3,1)/256); %% Entrada
    p2=plot(cx(k),cy(k)-alto/2,'s', 'Markersize',13,'LineWidth',1,'color',160*ones(3,1)/256); %% Salida
    cxd = [cx(k)-largo/2-5,cy(k)];
    cyd = [cx(k)+largo/2+5,cy(k)];
    
    Info(cu).ioc=[cxd 1;cyd 0];
    
    Chanc_image=imresize(Chanc_image, [largo alto]);
    Chanc_image=imrotate(Chanc_image,180);
    texy=cy(k)+alto/2;
    texx=cx(k)+largo/2;
    Mcuu=text(texx,texy,tagstr,'LineStyle','-','FontSize',9);
    
    plot_h=image(l(1)-alto/2,abs(l(3)-alto/2),Chanc_image);
    c = uicontextmenu;
    plot_h.UIContextMenu=c;
    p1.Tag=tagstr;
    p2.Tag=tagstr;
    plot_h.Tag=tagstr;
    Info(cu).Container=[];
    
    m1 = uimenu(c,'Label','Add Model','Callback',@Crusher_modelos);
    m2 = uimenu(c,'Label','Edit Model','Callback',@Crusher_modelos_edit);
    m3 = uimenu(c,'Label','Delete Module','Callback',@Eliminar_modulo_Crusher);
    m4 = uimenu(c,'Label','Results','Callback',@Crusher_Result_GUI);
    m5 = uimenu(c,'Label','Edit Tag','Callback',@editar_etiqueta);
    setappdata(m1,'Index',strcat(tagstr,num2str(rand(1,1))));
    setappdata(m2,'Index',strcat(tagstr,num2str(rand(1,1))));
    setappdata(m3,'Index',strcat(tagstr,num2str(rand(1,1))));
    setappdata(m4,'Index',strcat(tagstr,num2str(rand(1,1))));
    setappdata(m5,'Index',strcat(tagstr,num2str(rand(1,1))));
    
    plot_h.UIContextMenu.Children(1).UserData.c=cu;
    plot_h.UIContextMenu.Children(2).UserData.c=cu;
    plot_h.UIContextMenu.Children(3).UserData.c=cu;
    plot_h.UIContextMenu.Children(4).UserData.c=cu;
    plot_h.UIContextMenu.Children(5).UserData.c=cu; 
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
    cu=cu+1;
    axis(axesgnu,[0 a 0 b])
    axesgnu.XTick=('');
    axesgnu.YTick=('');
    
end