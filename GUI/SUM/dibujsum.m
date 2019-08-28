function dibujsum(hObject,eventdata)

global cx cy k ck Info cu cu2 axesgnu a b  TagIdentifier RC_text

delete(hObject.Parent)
defaultValue = 2;
titleBar = 'Número de entradas';
userPrompt = 'Número de entradas';
caUserInput = inputdlg(userPrompt, titleBar, 1, {num2str(defaultValue)});

if isempty(caUserInput)
    return
end
n = round(str2double(cell2mat(caUserInput)));
if n < 2
    wrn=warndlg('Número mínimo entradas:1','Advertencia');
    waitfor(wrn)
    caUserInput = inputdlg(userPrompt, titleBar, 1, {num2str(defaultValue)});
    if isempty(caUserInput)
        return
    end

elseif n > 4
    
    wrn=warndlg('Número máximo de entradas:4','Advertencia');
    waitfor(wrn)
    caUserInput = inputdlg(userPrompt, titleBar, 1, {num2str(defaultValue)});
    if isempty(caUserInput)
        return
    end
              
end

    axis([0 a 0 b])
    try
    [x,y] =getpts(axesgnu); %%%%%%%%% Crear getpst como function, nargin
    catch
        return
    end
 
     if length(x) ~= 1
         return
     end
    delete(RC_text)
    RC_text=[];
    
    TagIdentifier=TagIdentifier+1; 
    if k==1
        cx=zeros(1,k+1);
        cy=zeros(1,k+1);
        ck=zeros(1,k+1);
    end
   
    cx(k)=x;
    cx(k+1)=x;
    cy(k)=y;
    cy(k+1)=y;
    magnitud=40;
    alto = magnitud;
    Info(cu).tag='Sumador';
    
if n ==2 
    
    
    l(2)=cx(k+1);
    l(1)=cx(k);
    l(3)=cy(k);
  
    cy(k+1)=cy(k+1)+10;
    cy1=l(3)+magnitud/4;    
    
    MarkerS=12;
    p1=plot(cx(k+1)+24,cy(k+1)+30,'sk', 'Markersize',MarkerS,'LineWidth',1,'color', 160*ones(3,1)/256);
    hold on
    p2=plot(cx(k)-magnitud/1.55,cy(k)+20,'sk', 'Markersize',MarkerS,'LineWidth',1,'color', 160*ones(3,1)/256);
    p3=plot(cx(k)-magnitud/1.55,cy1+60,'sk', 'Markersize',MarkerS,'LineWidth',1,'color', 160*ones(3,1)/256);
    
%     plot_h=plot(cx(k+1)+30,cy(k+1)+95,'.k', 'Markersize',25);
    
  
    Sum_image=imread('Sumador_plot.jpg');
    Sum_image=imresize(Sum_image, [magnitud*3.3 magnitud]);
    plot_h=image(l(1)-magnitud/2,abs(l(3)-magnitud/2),Sum_image);
    
    c=uicontextmenu;
    m1 = uimenu(c,'Label','Eliminar Módulo','Callback',@Eliminar_modulo_mo);

    plot_h.UIContextMenu=c;
    plot_h.UIContextMenu.Children.UserData=cu;
%     plot_h.UserData.image=Sum_image;
    plot_h.UserData.points=[p1 p2 p3];
    Info(cu).h=plot_h;

    cx(k+1)=cx(k+1)+magnitud/2;
    cx(k)=cx(k)-magnitud/2;

    Info(cu).ioc=[cx(k)-magnitud/1.55+MarkerS/2 cy(k)+20+MarkerS/2 1;cx(k)-magnitud/1.55+MarkerS/2 cy1+60+MarkerS/2 1;cx(k+1)+24+MarkerS/2 cy(k+1)+30+MarkerS/2 0];
    Info(cu).k=[TagIdentifier 5];
    Info(cu).M='SUM';
    axis([0 a 0 b])
    set(gca,'xtick',[],'ytick',[])
    
elseif n==3 
    
 
    cy1=cy(k)+alto/3;
    cy2=cy(k)-alto/3;
    Info(cu).ioc=[cx(k) cy(k) 1;cx(k) cy1 1;cx(k) cy2 1;cx(k+1) cy(k+1) 0];
    Info(cu).tag='Sumador';
    l(2)=cx(k+1);
    l(1)= cx(k);
    l(3)=cy(k);
       
    Sum_image=imread('Sumador_plot.jpg');
    Sum_image=imresize(Sum_image, [magnitud*3.3 magnitud]);
    plot_h=image(l(1)-magnitud/2,abs(l(3)-magnitud/2),Sum_image);
    hold on

    plot(cx(k+1),cy(k+1),'ok', 'Markersize',10)
    hold on
    alto=0.8;
    largo=abs(l(2)-l(1));
    plot(cx(k),cy1,'ok', 'Markersize',10)
    plot(cx(k),cy2,'ok', 'Markersize',10)
    plot(cx(k),cy(k),'ok', 'Markersize',10)   
    text(cx(k)+largo/2,cy(k),'\Sigma')
    pos=[l(1) abs(l(3)-alto/2) largo alto];
    rectangle('Position',pos)
    axis([0 a 0 b])
    pos=[l(1) abs(l(3)-alto/2) largo alto];
    rectangle('Position',pos)
    set(gca,'xtick',[],'ytick',[])
    hold on
     
    
elseif n==4
    
    cy1=cy(k)+alto/3;
    cy2=cy(k)-alto/3;
    cy3=cy(k)+alto/2;
    l(2)=cx(k+1);
    l(1)= cx(k);
    l(3)=cy(k);
    
    Sum_image=imread('Sumador_plot.jpg');
    Sum_image=imresize(Sum_image, [magnitud*3.3 magnitud]);
    plot_h=image(l(1)-magnitud/2,abs(l(3)-magnitud/2),Sum_image);
    hold on

    alto=0.8;
    largo=abs(l(2)-l(1));
    cx3=cx(k)+largo/2;
    Info(cu).ioc=[cx(k) cy(k) 1;cx(k) cy1 1;cx(k) cy2 1;cx3 cy3 1;cx(k+1) cy(k+1) 0];
    Info(cu).tag='Sumador';
    plot(cx(k+1),cy(k+1),'ok', 'Markersize',10)
    plot(cx3,cy3,'ok', 'Markersize',10)
    plot(cx(k),cy1,'ok', 'Markersize',10)
    plot(cx(k),cy2,'ok', 'Markersize',10)
    plot(cx(k),cy(k),'ok', 'Markersize',10)
    text(cx(k)+largo/2,cy(k),'\Sigma')
    pos=[l(1) abs(l(3)-alto/2) largo alto];
    rectangle('Position',pos)
    axis([0 a 0 b])
    pos=[l(1) abs(l(3)-alto/2) largo alto];
    rectangle('Position',pos)
    set(gca,'xtick',[],'ytick',[])
    hold on
     
end
     k=k+2;
     cu2=cu2+1;
     moveit2sum(plot_h)
     cu=cu+1;
end
