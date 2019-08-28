function y=F100(x,s)
R=Pasante(x)

F_abajo100=0;
F_arriba100=0;
for i=1:length(s)
    
    if R(i)> 100
       
        F_arriba100(i)=R(i);
   
    elseif R(i)< 100
        
        F_abajo100(i)=R(i);
    else            
        f80=R(i);
    end
end
if F_abajo100 == 0
    cexpinf75 =0; %Valor dado para el caso en que no haya cexp<0.25
    posicion_dn75=length(s);
else
    [cexpinf75,posicion_dn75]=max(F_abajo100);
end
if F_arriba100 == 0
    f80=s(1);
else
[cexpsup75,posicion_up75]=min(F_arriba100);

Pend=(cexpsup75-cexpinf75)/(s(posicion_up75)-s(posicion_dn75));
f80 = (100-cexpsup75)/Pend+s(posicion_up75);
end
y=f80;
end