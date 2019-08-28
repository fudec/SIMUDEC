function [y,water]=HGPR(x,win,Info)
%%% Precrusher 
xc=0.5*((D+xg)-((D+xg)^2-(4*rog*d*xg/roc)^0.5));

n=length(v);

K1p=44.5;
K2p=xc;
K3p=2.3;
Cp=zeros(n,1);
t10p=12.18;
for i=1:n
    if v1(i) < K1p
        Cp(i) = 0;
    elseif (v1(i) >= K1p) && ( v1(i) <= K2p) 
        Cp(i) =1-((K2p-v(i))/(K2p-K1p))^K3p;
    elseif v1(i) > K2p
        Cp(i) = 1;
    end
end
I=eye(n);
Cp=diag(Cp);

B=NuevaInterT10(v,t10p);
pp=(I-Cp)*(I-B*Cp)^-1*x';
%%%% Fraction to edge and compression
fr=gama*xg/L;
fe=fr*pp;
fc=(1-fr)*pp;
%%%%% EDge zone &&&&&&&&&&&&
K1e=K1p;
K2e=xg;
K3e=K3p;
Ce=zeros(n,1);
t10e=12.18;
for i=1:n
    if v1(i) < K1e
        Ce(i) = 0;
    elseif (v1(i) >= K1e) && ( v(i) <= K2e) 
        Ce(i) =1-((K2e-v(i))/(K2e-K1e))^K3e;
    elseif v1(i) > K2e
        Ce(i) = 1;
    end
end
I=eye(n);
Ce=diag(Ce);

B=NuevaInterT10(v,t10e);
pe=(I-Ce)*(I-B*Ce)^-1*fe';

%%%% Compression zone %%%%%%%55
K1c=0;
K2c=xg;
K3c=2.3;
Cc=zeros(n,1);
t10c=12.18;
for i=1:n
    if v1(i) < K1c
        Cc(i) = 0;
    elseif (v1(i) >= K1c) && ( v1(i) <= K2c) 
        Cc(i) =1-((K2c-v(i))/(K2c-K1c))^K3c;
    elseif v1(i) > K2c
        Cc(i) = 1;
    end
end
I=eye(n);
Cc=diag(Cc);

B=NuevaInterT10(v,t10c);
pc=(I-Cc)*(I-B*Cc)^-1*fc';

y=pc+pe;
water=win;
end