function y=Pasante(x)
format shorte
n=length(x);
X=sum(x);
x_=x/X;
% T(n)=x(n)*100;
%     for i=n-1:-1:1
%         T(i)=T(i+1)+x_(i)*100;
%     end
    T(1)=100;
    for i=2:n
        T(i)=T(i-1)-x_(i)*100;
    end
    y=T;
    y(end)=0;
end