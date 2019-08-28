function dibujarsumidero(hObject,~)
    global cx cy k ck Info cu v a b axesgnu  TagIdentifier 
    
     Message='Unavailable';
     exito = warndlg(Message);
     return
     delete(hObject.Parent)
     axis([0 a 0 b])
     hold on
     try 
        [x,y] =getpts(axesgnu);
     catch
         return
     end
     
     if length(x) ~= 1
         return
     end
    TagIdentifier=TagIdentifier+1;
   
    if k==1
        cx=zeros(1);
        cy=zeros(1);
        ck=zeros(1);
    end
   
    cx(k)=x;
    cy(k)=y;
    
    largo=60;
    cx(k+1)=cx(k)+largo;
    cy(k+1)=cy(k);
    
        
    Info(cu).tag='Sumidero';
    Info(cu).val=rand(length(v));
    
    l(2)=cx(k+1);
    l(1)= cx(k);
    l(3)=cy(k);
    alto=110;
    MarkerS=12;
    p1=plot(cx(k)-largo/2,cy(k)+alto/1.5,'s', 'Markersize',1,'LineWidth',0.1,'color', 160*ones(3,1)/256);
    hold on
    p2=plot(cx(k+1)-largo/2.5,cy(k+1)-alto/3,'s', 'Markersize',MarkerS,'LineWidth',1,'color',160*ones(3,1)/256);
    hold on
    
    
    Molc_image=imread('Sumidero_plot_D.jpg');
    Molc_image=imresize(Molc_image, [alto largo]);
    plot_h=image(l(1)-largo/2,abs(l(3)-alto/2),Molc_image);
    
    cx(k+1)=cx(k+1)-largo/2.5+MarkerS/2;
    cx(k)=cx(k)-largo/2;
    cy(k)=cy(k)+alto/1.5-MarkerS/2;
    cy(k+1)=cy(k+1)-alto/3+MarkerS/2;
    Info(cu).ioc=[cx(k) cy(k) 1;cx(k+1) cy(k+1) 0];
    Info(cu).M='Sumidero';

    
    str='Sumidero';
%     texy=cy(k)+alto/2;
%     texx=cx(k)+alto/2;
    
%     Mcuu=text(texx,texy,str,'LineStyle','-','FontSize',9);
    
    c = uicontextmenu;
    plot_h.UIContextMenu=c;
    p1.Tag=str;
    p2.Tag=str;
    Mcuu.Tag=str;
    plot_h.Tag=str;
    
    m1 = uimenu(c,'Label','Eliminar M�dulo','Callback',@Eliminar_modulo_mo);

    setappdata(p1,'TagIdentifier',[TagIdentifier 3])
    setappdata(plot_h,'TagIdentifier',[TagIdentifier 3])
%     setappdata(Mcuu,'TagIdentifier',[TagIdentifier 3])
    setappdata(p2,'TagIdentifier',[TagIdentifier 3])
    setappdata(c,'TagIdentifier',[TagIdentifier 3])
    setappdata(m1,'Index',cu);
    
    plot_h.UIContextMenu.Children.UserData=cu;
    plot_h.UserData.points=[p1 p2];
    
        
  
    hold on
    moveit2sum(plot_h)
    k=k+2;
    cu=cu+1;
    axis(axesgnu,[0 a 0 b])
    axesgnu.XTick=('');
    axesgnu.YTick=('');
    
