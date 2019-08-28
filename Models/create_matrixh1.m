function mo1=create_matrixh1(source,eventdata)

global Info v Hidrociclon_container

        
        Handles=get(source,'UserData');
        d50=get(Handles(1),'String');
        alfa=get(Handles(2),'String');
        Cortocircuito=get(Handles(3),'String');
        
        x=get(Handles(1),'UserData');
        
  
        Hidrociclon_container(x).d50=d50;
        Hidrociclon_container(x).alfa=alfa;
        Hidrociclon_container(x).Cortocircuito=Cortocircuito;

        
        d50=str2double(d50);
        alfa=str2double(alfa);
        Cortocircuito=str2double(Cortocircuito);
        
%         alfa=1.5725/log(alfa);
%         x0=d50*(0.693)^(-1/alfa);
        
        c=(exp(alfa*(v/d50))-1)./(exp(alfa*(v/d50))+exp(alfa)-2);
        s=Cortocircuito+(1-Cortocircuito).*c;
        s=diag(s);
 
   

Info(x).m=s;

end