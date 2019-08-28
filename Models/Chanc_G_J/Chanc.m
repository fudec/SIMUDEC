function y=chanc(x)
OF=sum(x);
CSS=10;
% s=[287368 143684 87930 62176 35921 21997 15554 10984 7978 5641 3989 2812 2003 1416 1001 714 505 357 252 178 126 89 63 45];
s=[21997 15554 10984 7978 5641 3989 2812 2003 1416 1001 714 505 357 252 178 126 89 63 45 19];

s=s/1000;
n=length(x);
f=x/OF;


%% Cálculo constantes

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
%     k2=(1.121*CSS+58.67*q+25.4*T);
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
%% Matriz B
%B1
Lambda=5.1;
    B1=zeros(n);
    s(n+1)=0;
        for i=1:n
            for t=1:n
                if i >= t
                    B1(i,t)=(1-exp(-(s(i)/s(t))^Lambda))/(1-exp(-1))-(1-exp(-(s(i+1)/s(t))^Lambda))/(1-exp(-1));
                else 
                    B1(i,t)=0;
                end
            end
        end
       s(n+1)=[]; 
       
%B2
Beta=1.252;
x_=3.05;
    B2=zeros(n);
    s(n+1)=0;
        for u=1:n
            for v=1:n
                if u >= v
                    B2(u,v)=1-exp(-(s(u)/x_)^Beta)-(1-exp(-(s(u+1)/x_)^Beta));
                else
                    B2(u,v)=0;
                end
            end
        end
    s(n+1)=[];
x0=0;

%Alfa
Alfa=(0.8723+0.0045*CSS-0.26);

% B
B=Alfa*B1+(1-Alfa)*B2;
b=zeros(n,n);
for i=1:n-1;
    for j=1:n
        if i>j
                b(i,j)=B(i,j)-B(i+1,j);
        elseif i>j && i ==n
                b(i,j)=B(i,j);
        end
    end
end

I=eye(n);
Z=(I-B*C);
Z1=(I-C);
p=(Z1*inv(Z))*f';

p=p*OF;
P=Pasante(p);
F=Pasante(OF*f);
y=p;
end


                





