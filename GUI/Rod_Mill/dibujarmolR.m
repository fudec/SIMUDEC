function dibujarmolR(hObject, ~)
    global cx cy k ck Info cu v a b axesgnu vk  cumR TagIdentifier vcmuR
    
    delete(hObject.Parent);
    [x,y] =getpts(axesgnu);
    
    if length(x) ~= 1
         return
    end
    TagIdentifier=TagIdentifier+1;

if cumR > 1
            Index=0;
            vector=0;
            for i=1:cu-1
                if strcmp(Info(i).tag,'Molino Rodillo')
                    Index=Index+1;
                    Info(i).CatNum
                    vector(Index)=Info(i).CatNum;
                end
            end
            vector=sort(vector);
            Max=max(vector);
                if cumR < Max
                    for i=1:length(vector)
                            if i ~= vector(i)
                                Idx=i;
                                break
                            end
                    end

                else
                    Idx=cumR+1;
                end
else
        Idx=cumR+1;
end
    
    if k==1
        cx=zeros(1);
        cy=zeros(1);
        ck=zeros(1);
    end
   
    cx(k)=x;
    cy(k)=y;
    
    largo=110;
    cx(k+1)=cx(k)+largo;
    cy(k+1)=cy(k);
    
    
    
    Info(cu).tag='Molino Rodillo';
    Info(cu).val=rand(length(v));
    l(2)=cx(k+1);
    l(1)= cx(k);
    l(3)=cy(k);
    p1=plot(axesgnu,cx(k)-largo/2,cy(k),'s', 'Markersize',12,'LineWidth',1,'color', 160*ones(3,1)/256);
    hold on
    p2=plot(axesgnu,cx(k+1)-largo/2,cy(k+1),'s', 'Markersize',15,'LineWidth',1,'color',160*ones(3,1)/256);
    hold on
    
    
    cx(k+1)=cx(k+1)-largo/2;
    cx(k)=cx(k+1)-largo/2;
    Info(cu).ioc=[cx(k) cy(k) 1;cx(k+1) cy(k+1) 0];
 
    
    alto=largo;
    pos=[l(1) abs(l(3)-alto/2) largo alto];
    
    Molc_image=imread('MolR_I.png');
    Molc_image=imresize(Molc_image, [largo largo]);
    plot_h=image(l(1)-alto/2,abs(l(3)-alto/2),Molc_image);
    
    
    str=sprintf('MR%d',Idx);
    texy=cy(k)+alto/2;
    texx=cx(k)+alto/2;
    
    Mcuu=text(axesgnu,texx,texy,str,'LineStyle','-','FontSize',9);
    
    c = uicontextmenu;
%     plot_h=plot(cx(k),cy(k)+largo/2,'.k', 'Markersize',25);
    plot_h.UIContextMenu=c;
    p1.Tag=str;
    p2.Tag=str;
    Mcuu.Tag=str;
    plot_h.Tag=str;
    
    m1 = uimenu(c,'Label','Agregar Modelo','Callback',@MolinoR_modelos);
    m2 = uimenu(c,'Label','Editar Modelo','Callback',@Molinoc_modelos_edit);
    m3 = uimenu(c,'Label','Eliminar Módulo','Callback',@Eliminar_modulo_mo2);
    m4 = uimenu(c,'Label','Resultados','Callback',@ROD_Result_GUI);
    setappdata(m1,'Index',cu);
    plot_h.UIContextMenu.Children(1).UserData=cu;
    plot_h.UIContextMenu.Children(2).UserData=cu;
    plot_h.UIContextMenu.Children(3).UserData=cu;
    plot_h.UserData.points=[p1 p2 Mcuu];
    
    setappdata(p1,'TagIdentifier',[TagIdentifier 3])
    setappdata(plot_h,'TagIdentifier',[TagIdentifier 3])
    setappdata(Mcuu,'TagIdentifier',[TagIdentifier 3])
    setappdata(p2,'TagIdentifier',[TagIdentifier 3])
    setappdata(c,'TagIdentifier',[TagIdentifier 3])
    
    Info(cu).k=[TagIdentifier 3];
    Info(cu).CatNum=Idx;
    Info(cu).h=plot_h;
    Info(cu).M=str;
    Info(cu).tag2=str;
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
   
    hold on
    moveit2mol(plot_h)
    k=k+2;
    cumR=cumR+1;
    cu=cu+1;
    return
end