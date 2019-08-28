function y=NuevaInterT10(s,t10)

% M=[2.8 3.3 5.4 21.2 49.6;5.7 7.2 10.3 45 74.9;8.1 10.8 15.7 61.4 85.2];
t=[1/75 1/50 1/25 1/4 1/2 1];
M=[2.8 4.0 5.5 22.2 51.4 100;5.6 7.2 10.7 43.4 70.8 100;8.9 11.3 16.4 60.7 93 100];

t10interpV=zeros(1,length(t));
        for i=1:length(t)
            
            t10interpV(i)=interp1([10 30 50],[M(1,i) M(2,i) M(3,i)],t10,'pchip');
        end
for i=length(t):-1:2
    t10interpV(i)=t10interpV(i)-t10interpV(i-1);
end
t10interpV(1)=0;
t10interpV=t10interpV/100;

StamanosInterpolation=zeros(length(t),length(s));

for i=1:length(s)
    StamanosInterpolation(:,i)=s(i)*t;
end
    Pasanteinterp=zeros(length(s),length(s));
    for i=1:length(s)
        
        for k=1:length(s)
                Sboolean(k,i)=s(k) <= s(i);
        end
        K=double(Sboolean(:,i));        
        Stemp=s.*K;
        Stemp= Stemp(Stemp ~= 0);
%         interp1((StamanosInterpolation(:,i)),(t10interpV'),(Stemp),'pchip','extrap')
        Pasanteinterp(:,i)=[zeros(i-1,1);interp1((StamanosInterpolation(:,i)),(t10interpV'),(Stemp),'linear')];
%         semilogx((StamanosInterpolation(:,i)),(t10interpV'),'*r',Stemp,interp1((StamanosInterpolation(:,i)),(t10interpV'),Stemp,'linear'),'k')
%         hold on

    end
% Pasanteinterp=exp(Pasanteinterp);
    for i=1:length(s)
        for j=1:length(s)
            if i == j
                Pasanteinterp(i,j)=1;
            else
                if isnan(Pasanteinterp(i,j))
                    Pasanteinterp(i,j)=0;
                elseif i < j
                    Pasanteinterp(i,j)=0;
                end
            end
        end
    end
    for i=1:length(s)-1
        for j=1:length(s)
            if i >= j
                Pasanteinterp(i,j)=Pasanteinterp(i,j)-Pasanteinterp(i+1,j);
            end
        end
    end
    Pasanteinterp(end,end)=0.999;
    y=Pasanteinterp;
end
    
    