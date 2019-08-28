function Mover_entrada(source,eventdata)

global cu Info axesgnu a b cuf Resultados_push r
source
x=source.UserData

delete(Info(x).h.UserData.points);
delete(Info(x).h);

h = msgbox('Elegir nueva posición','');
waitfor(h)
 axis([0 a 0 b])
 
    [x,y] =getpts(axesgnu);
      
    Info(cu).ioc=[x(1) y(1) 1;x(2) y(2) 0];
    p=plot(x(2),y(2),'>k', 'Markersize',7);
    hold on
    axis([0 a 0 b])
    l=line(x,y,'Color','black');
    texx=x(1)+abs(x(1)-x(2))/2;
    texy=y(1)+0.2;
    str=sprintf('F %d',cuf);
    plot_h=text(texx,texy,str,'LineStyle','-','EdgeColor','black');
    
    c=uicontextmenu;
    plot_h.UIContextMenu=c;
    m1 = uimenu(c,'Label','Mover Entrada','Callback',@Mover_entrada);
    m2 = uimenu(c,'Label','Eliminar Entrada','Callback',@Elimnar_modulo);
    plot_h.UIContextMenu.Children(1).UserData=cu;
    plot_h.UIContextMenu.Children(2).UserData=cu;
    plot_h.UserData.points=[p l];
    Info(cu).h=plot_h;
 
    set(Resultados_push,'Enable','off')
    set(r,'Enable','off')

end