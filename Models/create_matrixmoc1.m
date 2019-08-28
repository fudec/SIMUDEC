function mo1=create_matrixmoc1(source,eventdata)

global Info v Molinoc_container

        
        Handles=get(source,'UserData');
        Phi=get(Handles(1),'String');
        Upsilon=get(Handles(2),'String');
        Beta=get(Handles(3),'String');
        
        alfa=get(Handles(4),'String');
        a=get(Handles(5),'String');
        Mu=get(Handles(6),'String');
        Lambda=get(Handles(7),'String');
        
        x=get(Handles(1),'UserData');
  
        Molinoc_container(x).Phi=Phi;
        Molinoc_container(x).Upsilon=Upsilon;
        Molinoc_container(x).Beta=Beta;
        
        Molinoc_container(x).alfa=alfa;
        Molinoc_container(x).a=a;    
        Molinoc_container(x).Mu=Mu;
        Molinoc_container(x).Lambda=Lambda;
 
 
        
        Phi=str2num(Phi);
        Upsilon=str2num(Upsilon);
        Beta=str2num(Beta);
        
        alfa=str2num(alfa);
        a=str2num(a);
        Mu=str2num(Mu);
        Lambda=str2num(Lambda);
        
        
 
   
   n=length(v);    
   v(n+1)=0;
    for i=1:n
            for t=1:n
                if i >= t
                    B(i,t)=(Phi*(v(i)/v(t))^Upsilon+(1-Phi)*(v(i)/v(t))^Beta)-(Phi*(v(i+1)/v(t))^Upsilon+(1-Phi)*(v(i+1)/v(t))^Beta);
                else 
                    B(i,t)=0;
                end
            end
    end
    
   v(n+1)=[];
d0=1000;       
S=a*((v./d0).^alfa).*(1./(1+(v./Mu).^Lambda));
S=diag(S);

Info(x).m=1;

end