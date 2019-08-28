function Out=Tromel_Model_Sobre(X,Container)
global v ros rol

s=v/1000;

%   Beta_= 1;
%   Rf = Container.Rf;
%   Beta = Container.Beta;
%   
%   alfa = Container.alfa;

%%%%%%%%%%%%5 BATERIA MOLINOS, RECORDAR, recordar   2lmjiahnsjifdnbasjdnsajdnaskd
%%%%%%%%%%%%askjdnaijskd


x=X(1:end-1);
x';
win=X(end);
P=sum(x);
rop=(P+win*rol)/(P/ros+win);
Q=P/ros+win;

N = 1;
w=P/(P+win);
Rf = 0.996;
beta=1.02;
beta_=1;
alfa=1.61;
d50 = 10;
csim=((1+beta*beta_*(s/d50))*(exp(alfa)-1))./(exp(alfa*beta_*s/d50)+exp(alfa)-2);
n=length(csim);

for i=1:n
    if isnan(csim(i)) || csim(i) > 1
        csim(i) = 1;
    end
end

C=1-Rf;
S1=csim*(C);
S1=diag(S1);
y=S1*x;
water=(1-Rf)*win*N;

Out=[y;water];
end
    