 
clear all
s=[287368 143684 87930 62176 35921 21997 15554 10984 7978 5641 3989 2812 2003 1416 1001 714 505 357 252 178 126 89 63 45];
F=[100.00 100.00 95.48 89.44 80.01 61.72 38.35 32.90 27.69 25.02 22.44 20.31 18.41 16.68 15.20 13.68 12.42 11.19 10.08 9.05 8.12 7.27 6.51 5.82];
n=length(F);
s=s/1000;
OF=100;
CSS=10;


% Transformación a fracción
f(1)=(100-F(1))/100;
f=zeros(n-1,1);
for i=2:n
    f(i)=(F(i-1)-F(i))/100;
end
f=transpose(f);

% Matriz de fractura
Lambda=2;
B1=zeros(n);
s(n+1)=0;
        for i=1:n
            for t=1:n
                if i >= t
                    B1(i,t)=((1-exp(-(s(i)/s(t))^Lambda))-(1-exp(-(s(i+1)/s(t))^Lambda)))/(1-exp(-1));
                else 
                    B1(i,t)=0;
                end
            end
        end  
        
Beta=2;
    B2=zeros(n);
        for u=1:n-1
            for v=1:n
                if u >= v
                    B2(u,v)=(1-exp(-(s(u)/s(v))^Beta))-(1-exp(-(s(u+1)/s(v))^Beta));
                else
                    B2(u,v)=0;
                end
            end
        end
  
s(n+1)=[];
Alfa=(0.8723+0.0045*CSS-0.26);

B=Alfa*B1+(1-Alfa)*B2

% Matriz casificación

    % k1
    k1=(0.67*CSS);

    % Spline T(t)
    x=[100 250 400];
    y=[-0.0486 -0.085 -0.259];
    xx=0:500;
    yy=spline(x,y,xx);
    p=polyfit(xx,yy,3);
    y1=xx.*p(3)+xx.^2.*p(2)+xx.^3.*p(1)+p(4);
    plot(x,y,'o',xx,yy,xx,y1,'y');
    T=OF*p(3)+OF^2*p(2)+OF^3*p(1)+p(4);

    % q

  suma=0;
for i=1:n;
    if s(i)>24.5
        suma=suma+f(i);
    else
    end
    q=suma;
end

    
    % k2
    k2=(1.121*CSS+58.67*q+25.4*T);




%% 
Gamma=6;

        fun = @(s) (s<k1).*0+((k1<s) & (s<k2)).*((s/(k2-k1))-(k2/(k2-k1))+1)+(s>k2).*1;
  %% C(i,i)
  
 C_=zeros(n,1);
      for i=1:n
          s(n+1)=0;
          C_(i)=(1/(-s(i+1)+s(i)))*integral(fun,s(i+1),s(i));
      end
      
      C=diag(C_);
      
I=eye(n);
% Producto bajo tamaño, p caracterizado
format short
Z=sparse((I-B*C));
Z1=sparse((I-C));
f=f';
p=Z1*inv(Z)*f;


fsum=sum(f);
ffino=1-fsum;
f=[f;ffino];

psum=sum(p);
pfino=1-psum;
p=[p;pfino];


% Alimentación bajo tamañao, alimentación caracterizada


% Porcentajes pasantes
F(n)=f(n)*100;
P(n)=p(n)*100;
for i=n+1:-1:2
    F(i)=F(i-1)+f(i-1)*100;
    P(i)=P(i-1)+p(i-1)*100;
end

% Gráficos     
for i=n:-1:1
    if f(i) == 0
        dpl=s(i+1);
        break
    end
end
p
semilogx(s,F,'r',s,P,'b')
legend('Alimentación','Descarga')

xlabel('Tamaño')
ylabel('Porcentaje pasante')

axis([0.1 s(1)*1.05 0 100])

grid on

%set (figure(1), 'Units', 'normalized', 'Position', [0,0,1,1]) 







        