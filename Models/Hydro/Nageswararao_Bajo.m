function Out=Nageswararao_Bajo(X,In)

x=X(1:end-1,1);
win=X(end,1);

global v ros rol Info
s=v/1000;
P=sum(x);
Parametros=In;
Dc=Parametros.Dc;
Di=Parametros.Di;
Do=Parametros.Do;
Du=Parametros.Du;
Lc=Parametros.Lc;
theta=Parametros.theta;
KQ0=Parametros.KQ0;
Kd0=Parametros.Kd0;
Kw1=Parametros.Kw1;
Kv1=Parametros.Kv1;
beta=Parametros.beta;
beta_=Parametros.beta;
alfa=Parametros.alfa;
N=Parametros.N;

P=P/N;
win=win/N;
rop=(P+win*rol)/(P/ros+win);
Q=P/ros+win;
Cv=(P/ros)/(P/ros+win);
lambda=10^(1.82*Cv)/(8.05*(1-Cv)^2);

g=9.81;
Pressure=(Q/(KQ0*Dc^-0.1*(Do/Dc)^0.68*(Di/Dc)^0.45*(Lc/Dc)^0.2*theta^-0.1*Dc^2))^2*rop;
d50=Dc*(Kd0*Dc^-0.65*(Do/Dc)^0.52*(Du/Dc)^-0.47*(Di/Dc)^-0.5*(Lc/Dc)^0.2*theta^0.15*(Pressure/(rop*g*Dc))^-0.22*lambda^0.93);
Rf=Kw1*(Do/Dc)^-1.19*(Du/Dc)^2.40*(Di/Dc)^-0.5*(Lc/Dc)^0.22*theta^-0.24*(Pressure/(rop*g*Dc))^-0.53*lambda^0.27;
Rv=Kv1*(Di/Dc)^-0.25*(Lc/Dc)^0.22*theta^-0.24*(Do/Dc)^-0.94*(Du/Dc)^2.40*(Pressure/(rop*g*Dc))^-0.53*lambda^-0.31;
w=P/(P+win);

csim=((1+beta*beta_*(s/d50))*(exp(alfa)-1))./(exp(alfa*beta_*s/d50)+exp(alfa)-2);
n=length(csim);

for i=1:n
    if isnan(csim(i)) || csim(i) > 1
        csim(i) = 1;
    end
end
C=1-Rf;
S1=csim*(C);
S1=eye(n)-diag(S1);
y=S1*x;
water=Rf*win*N;


Out=[y;water];
I = get_index_info(Parametros.Index);
Info(I).Container.d50 = d50;
end