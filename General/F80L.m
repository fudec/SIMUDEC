function y=F80Log(x,s)
global cosos
R=Pasante(x);
F_abajo80=0;
F_arriba80=0;
for i=1:length(s);   
    if R(i)> 80
        F_arriba80(i)=R(i);
    elseif R(i)< 80
        F_abajo80(i)=R(i);
    else            
        y=R(i);
        return
    end
end
if F_abajo80 == 0
    F80inf =0; %Valor dado para el caso en que no haya F80inf < 80
    posicion_F80inf=length(s);
else
    [F80inf,posicion_F80inf]=max(F_abajo80);
end
    MinFinf=min(F_arriba80);
    MinFinf = round(MinFinf);
    if MinFinf == 100
        ciencount=ciencounter(F_arriba80);
        [F80sup,posicion_F80sup]=min(F_arriba80);
        posicion_F80sup=posicion_F80sup+ciencount-1;
    else
        [F80sup,posicion_F80sup]=min(F_arriba80);
    end
Pend=(F80sup-F80inf)/(s(posicion_F80sup)-s(posicion_F80inf));
f80 = (80-F80sup)/Pend+s(posicion_F80sup);
y=f80;
end