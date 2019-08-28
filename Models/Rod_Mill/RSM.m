function [y,water]=RSM(x,win,In)
global Info v ros rol 
v2=v(1:end-1);
k=In.c;
TPH=sum(x);
Parametros=In.Container;
MC=Parametros.MC;
Pa=Parametros.Pa;

D_ori=Parametros.D_ori;
D_sim=Parametros.D_sim;

L_ori=Parametros.L_ori;
L_sim=Parametros.L_sim;

CS_ori=Parametros.CS_ori;
CS_sim=Parametros.CS_sim;

FL_ori=Parametros.FL_ori;
FL_sim=Parametros.FL_sim;

WI_ori=Parametros.WI_ori;
WI_sim=Parametros.WI_sim;



XC=Parametros.XC;
SI=Parametros.SI;
IN=Parametros.IN;

Vr=Parametros.Vr;

FACTA=(D_sim/D_ori)^2.5*(L_sim/L_ori);
FACTB=((1-FL_sim)*FL_sim)/((1-FL_ori)*FL_ori);
FACTC=CS_sim/CS_ori;
MC_sim=MC*FACTA*FACTB*FACTC;
FACTD=log(Pa/F90(x,v))/log(sqrt(2));
E=(MC_sim/sum(x))^2/3+FACTD;

C=zeros(length(v2),1);
C(1)=1;
for i=2:length(v2)
    C(i)=C(i-1)/2;
end
C=diag(C);
m=length(x);
n=m;
v(n+1)=0;
for i=1:n
    for j=1:n
        if i >= j
            A(i,j)=(1-exp(-(v(i)/v(j))))/(1-exp(-1))-(1-exp(-(v(i+1)/v(j))))/(1-exp(-1));
        end
    end
end
v(n+1)=[];
length(v2)
A(:,n)=[];
A(n,:)=[];

I=eye(n-1,n-1);
S=zeros(length(v2),1);
for i=1:length(v2)
    if v2(i) > XC
        S(i)=SI*v2(i)/1000+IN;
    elseif v2(i) < XC
        S(i)= SI*XC/1000+IN;
    end
end

for i=1:length(v2)
    if S(i) > 1
        S(i) = 1;
    elseif S(i) < 0
        S(i) = 0;
    end
end

% FACTE=-0.8*log(WI_sim/WI_ori);
% FACTF=log(S./(1-S))+FACTE;
% FACTG=exp(FACTF);
% S=(FACTG./(1-FACTG));
FACTS=(WI_ori/WI_sim)^0.8;
S=S*FACTS;
for i=1:length(v2)
    if S(i) > 1
        S(i) = 1;
    elseif S(i) < 0
        S(i) = 0;
    end
end

S=diag(S);
X=(I-C)*(A*S+I-S)*(I-C*(A*S+I-S))^-1;
m=length(X(:,1));
n=length(X(1,:));
T=length(v2);
E=2;
if mod(E,1) ~=  0
    v_=round(E);
    if v_ == 0
        v_=1;
    end
    if v_-E >0
        v_1=v_-1;
        v_2=v_;
    elseif E-v_ > 0
        v_1=v_;
        v_2=v_+1;
    end
    f1=x(1:end-1);
    f2=x(1:end-1);
    X1=X;
    for i=1:v_1
        if i == m
            break
        end
        if i > 1
            X1(m,:)=zeros(1,m);
            X1(:,n)=zeros(n,1);
            for y=m-1:-1:1
                for j=n-1:-1:1
                    X1(y+1,j+1)=X1(y,j);
                end
            end
            X1(:,i-1)=zeros(1,m);
        end
        size(X1)
        size(f1)
        p1=X1*f1;
        f1=p1;

    end
    f1(T+1)=TPH-sum(f1);
    p1(T+1)=TPH-sum(p1);
    X2=X;
    for i=1:v_2
        if i == m
            break
        end
        if i > 1
            X2(m,:)=zeros(1,m);
            X2(:,n)=zeros(n,1);
            for y=m-1:-1:1
                for j=n-1:-1:1
                    X2(y+1,j+1)=X2(y,j);
                end
            end
            X2(:,i-1)=zeros(1,m);
        end
        p2=X2*f2;
        f2=p2;

    end
    f2(T+1)=TPH-sum(f2);
    p2(T+1)=TPH-sum(p2);

        pdef=zeros(1,length(p1));
        for i=1:length(p1)
            pdef(i)=interp1([v_1 v_2],[p1(i) p2(i)],E);
        end


    P1=Pasante(p1);
    P2=Pasante(p2);
    Pdef=Pasante(pdef);

elseif mod(E,1) == 0
    
    f1=x(1:end-1);
    X1=X;
    for i=1:E
        if i == m
            break
        end
        if i > 1
            X1(m,:)=zeros(1,m);
            X1(:,n)=zeros(n,1);
            for y=m-1:-1:1
                for j=n-1:-1:1
                    X1(y+1,j+1)=X1(y,j);
                end
            end
            X1(:,i-1)=zeros(1,m);
        end
        p1=X1*f1;
        f1=p1;

    end
    f1(T+1)=TPH-sum(f1);
    p1(T+1)=TPH-sum(p1);
    P1=Pasante(p1);
    Pdef=P1;
    pdef=p1;
    
end
  Potencia=1.752*D_sim^(1/3)*(6.3-5.4*Vr)*CS_sim;
  y=pdef';
  water=win;
  Info(k).PasanteA=Pasante(x);
  Info(k).PasanteP=Pdef;
  Info(k).W=sum(x)/(win+sum(x))*100;
  coso2=sum(x);
  coso_=win;
  Info(k).ro=(sum(x)+win)/(win/rol+sum(x)/ros);
  Info(k).TPH=sum(x)+win;
  Info(k).F80=F80(x,v);
  Info(k).P80=F80(p1,v);
  Info(k).FW=water;
  Info(k).Potencia=Potencia;
end
