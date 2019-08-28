function dibujsum2(hObject,~)

global cx cy k ck Info cu cu2 axesgnu a b  

delete(hObject.Parent)
axis([0 a 0 b])
defaultValue = 2;
titleBar = 'Inputs Number';
userPrompt = 'Inputs Number';
caUserInput = inputdlg(userPrompt, titleBar, 1, {num2str(defaultValue)});

if isempty(caUserInput)
    return
end
n = round(str2double(cell2mat(caUserInput)));
if n < 2
    wrn=warndlg('Minumun Inputs:2','Warning');
    waitfor(wrn)
    caUserInput = inputdlg(userPrompt, titleBar, 1, {num2str(defaultValue)});
    if isempty(caUserInput)
        return
    end

elseif n > 4
    
    wrn=warndlg('Maximun Inputs: 4','Warning');
    waitfor(wrn)
    caUserInput = inputdlg(userPrompt, titleBar, 1, {num2str(defaultValue)});
    if isempty(caUserInput)
        return
    end      
end

     state=1;
     f_sum=figure;
     set(f_sum,'name','SUM','numbertitle','off','Position',  [500,200,150,280],'Units','pixels','menubar','none','units','normalized','closereq',@Cancelar_callback,...
         'Resize','off')
    
bg = uibuttongroup(f_sum);
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
 waitfor(f_sum)
 
    function Cancelar_callback(~,~)
          state=0;
          delete(f_sum)
    end

    function Aceptar_callback(~,~)
         tagstr=[];
         tagstr=get(tag,'String');
        elec=bg.SelectedObject.String;
        if isempty(tagstr)
             warndlg('Add Tag');
        else
            delete(f_sum)
        end 
       
    end

    if state == 0
        return
    end
    
    if isempty(elec) 
      elec='Izquierda';
    end
    try
    [x,y] =getpts(axesgnu); %%%%%%%%% Crear getpst como function, nargin
    catch
        return
    end
 
     if length(x) ~= 1
         return
     end
    
    if k==1
        cx=zeros(1,k+1);
        cy=zeros(1,k+1);
        ck=zeros(1,k+1);
    end
   
    cx(k)=x;
    cy(k)=y;    

if strcmp(elec,'Izquierda')

 if n == 2 
    
    magnitud=40;
    alto = magnitud;
    Punto_entrada_uno = [cx(k)-magnitud/1.55,cy(k)+20];
    Punto_entrada_dos = [cx(k)-magnitud/1.55,cy(k)+70];
    Punto_salida=[cx(k)+22,cy(k)+45];
      
    Marker=12;
    p1=plot(axesgnu,Punto_salida(1),Punto_salida(2),'sk', 'Markersize',Marker,'LineWidth',1.5,'color', 110*ones(3,1)/256); %% Salida
    hold on
    p2=plot(axesgnu,Punto_entrada_uno(1),Punto_entrada_uno(2),'sk', 'Markersize',Marker,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada uno
    p3=plot(axesgnu,Punto_entrada_dos(1),Punto_entrada_dos(2),'sk', 'Markersize',Marker,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada dos   
    
    c=uicontextmenu;
    m1 = uimenu(c,'Label','Eliminar M�dulo','Callback',@Eliminar_modulo_sum);
    setappdata(m1,'Index',strcat(tagstr,num2str(rand(1,1))));
    

    Info(cu).tag='Sum';
    Sum_image=imread('Sumador_plot.jpg');
    Sum_image=imresize(Sum_image, [magnitud*3.3 magnitud]);
    plot_h=image(axesgnu,cx(k)-magnitud/2,abs(cy(k)-magnitud/2),Sum_image);
    hold on
    
    plot_h.UIContextMenu=c;
    plot_h.UIContextMenu.Children.UserData=cu;
    p1.Tag=tagstr;
    p2.Tag=tagstr;
    plot_h.UserData.points=[p2 p3 p1];
    plot_h.Tag=tagstr;
    plot_h.UserData.n=n;
    
    Info(cu).h=plot_h;
    Info(cu).Container=[];
    Info(cu).ioc=[Punto_entrada_uno-Marker/2 1;Punto_entrada_dos-Marker/2 1;Punto_salida+Marker/2 0];
    axis([0 a 0 b])
    set(gca,'xtick',[],'ytick',[])
    
elseif n==3 
    
    magnitud=40;
    alto = magnitud;
    
    Punto_entrada_uno = [cx(k)-magnitud/1.55,cy(k)];
    Punto_entrada_dos = [cx(k)-magnitud/1.55,cy(k)+45];
    Punto_entrada_tres = [cx(k)-magnitud/1.55,cy(k)+90];
    Punto_salida=[cx(k)+22,cy(k)+45];
      
    Marker=12;
    p1=plot(Punto_salida(1),Punto_salida(2),'sk', 'Markersize',Marker,'LineWidth',1.5,'color', 110*ones(3,1)/256); %% Salida
    hold on
    p2=plot(Punto_entrada_uno(1),Punto_entrada_uno(2),'sk', 'Markersize',Marker,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada uno
    p3=plot(Punto_entrada_dos(1),Punto_entrada_dos(2),'sk', 'Markersize',Marker,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada dos
    p4=plot(Punto_entrada_tres(1),Punto_entrada_tres(2),'sk', 'Markersize',Marker,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada dos   

    c=uicontextmenu;
    m1 = uimenu(c,'Label','Eliminar M�dulo','Callback',@Eliminar_modulo_sum);
    setappdata(m1,'Index',strcat(tagstr,num2str(rand(1,1))));
    
    Info(cu).tag='Sum';
    Sum_image=imread('Sumador_plot.jpg');
    Sum_image=imresize(Sum_image, [magnitud*3.3 magnitud]);
    plot_h=image(axesgnu,cx(k)-magnitud/2,abs(cy(k)-magnitud/2),Sum_image);
    hold on
    
    plot_h.UIContextMenu=c;
    plot_h.UIContextMenu.Children.UserData=cu;
    p1.Tag=tagstr;
    p2.Tag=tagstr;
    plot_h.UserData.points=[p2 p3 p4 p1];
    plot_h.Tag=tagstr;
    plot_h.UserData.n=n;

    
    Info(cu).h=plot_h;
    Info(cu).Container=[];
    Info(cu).ioc=[Punto_entrada_uno-Marker/2 1;Punto_entrada_dos-Marker/2 1;Punto_entrada_tres-Marker/2 1;Punto_salida+Marker/2 0];
    
    axis([0 a 0 b])
    set(gca,'xtick',[],'ytick',[])
   
elseif n==4
    
    magnitud=40;
    alto = magnitud;    
    
    Punto_entrada_uno = [cx(k)-magnitud/1.55,cy(k)+20]; %%% Entrada atr�s
    Punto_entrada_dos = [cx(k)-magnitud/1.55,cy(k)+70]; %%% Entrada atr�s
    Punto_entrada_tres = [cx(k)-7,cy(k)-35]; %%% Entrada arriba
    Punto_entrada_cuatro = [cx(k)-7,cy(k)+120]; %%% Entrada abajo al sumar a componente y baja, ni idea??
    Punto_salida=[cx(k)+24,cy(k)+45];
    
    Marker=12;
    p1=plot(Punto_salida(1),Punto_salida(2),'sk', 'Markersize',Marker,'LineWidth',1.5,'color', 110*ones(3,1)/256); %% Salida
    hold on
    p2=plot(Punto_entrada_uno(1),Punto_entrada_uno(2),'sk', 'Markersize',Marker,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada uno
    p3=plot(Punto_entrada_dos(1),Punto_entrada_dos(2),'sk', 'Markersize',Marker,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada dos
    p4=plot(Punto_entrada_tres(1),Punto_entrada_tres(2),'sk', 'Markersize',Marker,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada dos   
    p5=plot(Punto_entrada_cuatro(1),Punto_entrada_cuatro(2),'sk', 'Markersize',Marker,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada dos     
    plot_h.UserData.points=[p2 p3 p4 p5 p1];
    
    c=uicontextmenu;
    m1 = uimenu(c,'Label','Eliminar M�dulo','Callback',@Eliminar_modulo_sum);
    setappdata(m1,'Index',strcat(tagstr,num2str(rand(1,1))));
    
    Info(cu).tag='Sum';
    Sum_image=imread('Sumador_plot.jpg');
    Sum_image=imresize(Sum_image, [magnitud*3.3 magnitud]);
    plot_h=image(axesgnu,cx(k)-magnitud/2,abs(cy(k)-magnitud/2),Sum_image);
    hold on
    
    plot_h.UIContextMenu=c;
    plot_h.UIContextMenu.Children.UserData=cu;
    p1.Tag=tagstr;
    p2.Tag=tagstr;
    plot_h.UserData.points=[p2 p3 p4 p5 p1];
    plot_h.Tag=tagstr;
    plot_h.UserData.n=n;

    
    Info(cu).h=plot_h;
    Info(cu).Container=[];
    
    Info(cu).ioc=[Punto_entrada_uno-Marker/2 1;Punto_entrada_dos-Marker/2 1;Punto_entrada_tres-Marker/2 1;Punto_salida+Marker/2 0]; 
 end

     moveit2sum(plot_h)

elseif strcmp(elec,'Derecha')
    
    if n == 2 
    
    magnitud=40;
    alto = magnitud;
    
    Punto_entrada_uno = [cx(k)+magnitud/1.55,cy(k)+20];
    Punto_entrada_dos = [cx(k)+magnitud/1.55,cy(k)+70];
    Punto_salida=[cx(k)-24,cy(k)+45];
      
    Marker=12;
    p1=plot(axesgnu,Punto_salida(1),Punto_salida(2),'sk', 'Markersize',Marker,'LineWidth',1.5,'color', 110*ones(3,1)/256); %% Salida
    hold on
    p2=plot(axesgnu,Punto_entrada_uno(1),Punto_entrada_uno(2),'sk', 'Markersize',Marker,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada uno
    p3=plot(axesgnu,Punto_entrada_dos(1),Punto_entrada_dos(2),'sk', 'Markersize',Marker,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada dos   
    
    c=uicontextmenu;
    m1 = uimenu(c,'Label','Eliminar M�dulo','Callback',@Eliminar_modulo_sum);
    setappdata(m1,'Index',strcat(tagstr,num2str(rand(1,1))));
    

    Info(cu).tag='Sum';
    Sum_image=imread('Sumador_plot.jpg');
    Sum_image=imresize(Sum_image, [magnitud*3.3 magnitud]);
    plot_h=image(axesgnu,cx(k)-magnitud/2,abs(cy(k)-magnitud/2),Sum_image);
    hold on
    
    plot_h.UIContextMenu=c;
    plot_h.UIContextMenu.Children.UserData=cu;
    p1.Tag=tagstr;
    p2.Tag=tagstr;
    plot_h.UserData.points=[p2 p3 p1];
    plot_h.Tag=tagstr;
    plot_h.UserData.n=n;
    
    Info(cu).h=plot_h;
    Info(cu).Container=[];
    Info(cu).ioc=[Punto_entrada_uno-Marker/2 1;Punto_entrada_dos-Marker/2 1;Punto_salida+Marker/2 0];
    axis([0 a 0 b])
    set(gca,'xtick',[],'ytick',[])
    
elseif n==3 
    
    magnitud=40;
    alto = magnitud;
    
    Punto_entrada_uno = [cx(k)+magnitud/1.55,cy(k)];
    Punto_entrada_dos = [cx(k)+magnitud/1.55,cy(k)+45];
    Punto_entrada_tres = [cx(k)+magnitud/1.55,cy(k)+90];
    Punto_salida=[cx(k)-24,cy(k)+45];
      
    Marker=12;
    p1=plot(Punto_salida(1),Punto_salida(2),'sk', 'Markersize',Marker,'LineWidth',1.5,'color', 110*ones(3,1)/256); %% Salida
    hold on
    p2=plot(Punto_entrada_uno(1),Punto_entrada_uno(2),'sk', 'Markersize',Marker,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada uno
    p3=plot(Punto_entrada_dos(1),Punto_entrada_dos(2),'sk', 'Markersize',Marker,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada dos
    p4=plot(Punto_entrada_tres(1),Punto_entrada_tres(2),'sk', 'Markersize',Marker,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada dos   

    c=uicontextmenu;
    m1 = uimenu(c,'Label','Eliminar M�dulo','Callback',@Eliminar_modulo_sum);
    setappdata(m1,'Index',strcat(tagstr,num2str(rand(1,1))));
    
    Info(cu).tag='Sum';
    Sum_image=imread('Sumador_plot.jpg');
    Sum_image=imresize(Sum_image, [magnitud*3.3 magnitud]);
    plot_h=image(axesgnu,cx(k)-magnitud/2,abs(cy(k)-magnitud/2),Sum_image);
    hold on
    
    plot_h.UIContextMenu=c;
    plot_h.UIContextMenu.Children.UserData=cu;
    p1.Tag=tagstr;
    p2.Tag=tagstr;
    plot_h.UserData.points=[p2 p3 p4 p1];
    plot_h.Tag=tagstr;
    plot_h.UserData.n=n;

    
    Info(cu).h=plot_h;
    Info(cu).Container=[];
    
    Info(cu).ioc=[Punto_entrada_uno-Marker/2 1;Punto_entrada_dos-Marker/2 1;Punto_entrada_tres-Marker/2 1;Punto_salida+Marker/2 0];
    
    axis([0 a 0 b])
    set(gca,'xtick',[],'ytick',[])
   
elseif n==4
    
    magnitud=40;
    alto = magnitud;    
    
    Punto_entrada_uno = [cx(k)+magnitud/1.55,cy(k)+20]; %%% Entrada atr�s
    Punto_entrada_dos = [cx(k)+magnitud/1.55,cy(k)+70]; %%% Entrada atr�s
    Punto_entrada_tres = [cx(k)+7,cy(k)-35]; %%% Entrada arriba
    Punto_entrada_cuatro = [cx(k)+7,cy(k)+120]; %%% Entrada abajo al sumar a componente y baja, ni idea??
    Punto_salida=[cx(k)- 24,cy(k)+45];
    p1=plot(Punto_salida(1),Punto_salida(2),'sk', 'Markersize',Marker,'LineWidth',1.5,'color', 110*ones(3,1)/256); %% Salida
    hold on
    
    Marker=12;
    p2=plot(Punto_entrada_uno(1),Punto_entrada_uno(2),'sk', 'Markersize',Marker,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada uno
    p3=plot(Punto_entrada_dos(1),Punto_entrada_dos(2),'sk', 'Markersize',Marker,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada dos
    p4=plot(Punto_entrada_tres(1),Punto_entrada_tres(2),'sk', 'Markersize',Marker,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada dos   
    p5=plot(Punto_entrada_cuatro(1),Punto_entrada_cuatro(2),'sk', 'Markersize',Marker,'LineWidth',1,'color', 160*ones(3,1)/256); %% Entrada dos     
    
    c=uicontextmenu;
    m1 = uimenu(c,'Label','Eliminar M�dulo','Callback',@Eliminar_modulo_sum);
    setappdata(m1,'Index',strcat(tagstr,num2str(rand(1,1))));
    
    Info(cu).tag='Sum';
    Sum_image=imread('Sumador_plot.jpg');
    Sum_image=imresize(Sum_image, [magnitud*3.3 magnitud]);
    plot_h=image(axesgnu,cx(k)-magnitud/2,abs(cy(k)-magnitud/2),Sum_image);
    hold on
    
    plot_h.UIContextMenu=c;
    plot_h.UIContextMenu.Children.UserData=cu;
    p1.Tag=tagstr;
    p2.Tag=tagstr;
    plot_h.UserData.points=[p2 p3 p4 p5 p1];
    plot_h.Tag=tagstr;
    plot_h.UserData.n=n;

    
    Info(cu).h=plot_h;
    Info(cu).Container=[];
    
    Info(cu).ioc=[Punto_entrada_uno-Marker/2 1;Punto_entrada_dos-Marker/2 1;Punto_entrada_tres-Marker/2 1;Punto_salida+Marker/2 0];

end
    
    axis([0 a 0 b])
    set(gca,'xtick',[],'ytick',[])
    
     k=k+2;
     cu2=cu2+1;
     moveit2sum(plot_h)
     cu=cu+1;
end
end
