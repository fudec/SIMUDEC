function Out = Chancador_Model(X,In)
% v=[152 106 75 53 37.5 26.5 19 13.2 9.5 6.7 4.75 3.35 2.36 1.7 1.18 0.85 0.6 0.425 0.3 0.212 0.15 0.106 0.075 0.053 0.038 0.019];
% v=[175 152 106 75 53 37.5 26.5 19 13.2 9.5 6.7 4.75 3.35 2.36 1.7 1.18 0.85 0.6 0.425 0.3 0.212 0.15 0.106 0.075 0.053 0.038 0];
global v 
x=X(1:end-1);
win=X(end);
for i=1:length(v)-1
    v2(i)=(v(i)+v(i+1))/2;
end
% x=[zeros(1,3) 7.47 19.27 22.25 19.20 17.46 11.20 2.49 0.41 0.10 0.04 0.02 0.01*ones(1,11) 0.02];
% p=[zeros(1,4) 11.71 26.27 22.50 19.92 12.70 3.57 1.14 0.61 0.39 0.25 0.20 0.14 0.12 0.10 0.08 0.06 0.05 0.04 0.03 0.03 0.02 0.08];
v1=v;
TPH=sum(x);
CSS=100000;
Llen=725;
ET=25.5;
LHR=333.3;
A=[0.3 0.5 0.3 0 0];
B=[0.2 0.5 0 0 0 5.2];
K1=A(1)*CSS+A(2)*TPH+A(3)*F80(x,v)+A(4)*Llen+A(5);
K2=B(1)*CSS+B(2)*TPH+B(3)*F80(x,v)+B(4)*LHR+B(5)*ET+B(6);
n=length(v1);
% K1=44.5;
% K2=49.81;
K3=2.3;
C=zeros(n,1);
t10=18;
for i=1:n
    if v1(i) < K1
        C(i) = 0;
    elseif (v1(i) >= K1) && ( v1(i) <= K2) 
        C(i) =1-((K2-v1(i))/(K2-K1))^K3;
    elseif v1(i) > K2
        C(i) = 1;
    end
end

I=eye(n);
C=diag(C);
% xdata=f';
% ydata=zeros(n,1);
% alfa=(I-C);
% fun=@(x)(Breakage_chancador(x,v,C)*f'-p').^2;
% x0=[0.5 0 0];
B=NuevaInterT10(v1,t10);
p=((I-C)*(I-B*C)^-1)*x;

% lb=[0 0 0];
% ub=[1 5 5];
% options = optimoptions('lsqnonlin','algorithm','levenberg-marquardt');
% d=fsolve(fun,x0,options);
% x = lsqcurvefit(fun,x0,xdata,ydata);
% options = optimoptions('lsqnonlin','algorithm','trust-region-reflective');
% d=lsqnonlin(fun,x0,lb,ub,options);
power=EcsInter(C,v1',x',t10);
% % semilogx(s,Pasante(f),'r',s,Pasante(p),'k')
% v2=v1;
% kk=length(v2);
% P=Pasante(p);
% suma=0;
% for i=1:length(v2)
%     if P(i) == 100
%         suma=suma+1;
%     end
% end
% suma2=1;
% for i=1:length(v2)
%             if P(i) == 100
%             vector(suma2) = i;
%             suma2=suma2+1;
%             end
% end
% vector(end)=[];
% P(vector)=[];
% v2(vector)=[];
% P(end)=0;
% for i=1:length(P)
%     P(i)=P(i)+1e-8*i;
% end
% P80=interp1(P,log(v2),80,'pchip');
% P80=exp(P80);
% cc = figure;
% ax =axes(cc);
% semilogx(ax,v1,Pasante(x),'r',v1,Pasante(p),'k')
Out=[p;win];
end