function y=F86(x,s)
R=Pasante(x);

F_abajo80=0;

for i=1:length(s);
    
    if R(i)> 86
       
        F_arriba80(i)=R(i);
   
    elseif R(i)< 86
        
        F_abajo80(i)=R(i);
    else            
        d75exp=R(i);
    end
end
if F_abajo80 == 0
    cexpinf75 =0; %Valor dado para el caso en que no haya cexp<0.25
    posicion_dn75=length(s);
else
    [cexpinf75,posicion_dn75]=max(F_abajo80);
end

[cexpsup75,posicion_up75]=min(F_arriba80);

Pend=(cexpsup75-cexpinf75)/(s(posicion_up75)-s(posicion_dn75));
f80 = (86-cexpsup75)/Pend+s(posicion_up75);
y=f80;
end