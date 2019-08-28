function Out = SCR_Model_Simple_Bajo(X,In)
global v ros rol

x=X(1:end-1,1);
win=X(end,1);
s=v/1000;
N = 1;
Rf = 0.5;
d50=55;
beta=1.02;
beta_=1;
alfa=1.61;
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
end
