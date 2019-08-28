function y=NuevaInterT10SAG2(s,t10)

% M=[2.8 3.3 5.4 21.2 49.6;5.7 7.2 10.3 45 74.9;8.1 10.8 15.7 61.4 85.2];
t=[0 1/75 1/50 1/25 1/4 1/2 1];
% t=[1 1/2 1/25 1/50 1/75];
M=[0 2.33 3.06 4.98 23.33 50.53 100;0 6.89 9.41 15.62 61.58 92.49 100;0 10.32 14.71 25.88 82.86 96.47 100];
% M=[100 50.53 23.33 4.98 3.06 2.33;100 92.49 61.58 15.62 9.41 6.89;100 96.47 82.86 25.88 14.71 10.32];
% M=[10.32 14.71 25.88 82.86 96.47 100;6.89 9.41 15.62 61.58 92.49 100;2.33 3.06 4.98 23.33 50.53 100];
%%%% TODO MALO ESTA WEA, NAH QUE VER

% for i=length(t):-1:2
%     t10interpV(i)=t10interpV(i)-t10interpV(i-1);
% end
t10interpV(1)=0;
% t10interpV=t10interpV/100;

StamanosInterpolation=zeros(length(t),length(s));

% for i=1:length(s)
% 
% end
    Pasanteinterp=zeros(length(s),length(s));
    for i=1:length(s)
            StamanosInterpolation(:,i)=s(i)*t;
            t10interpV=zeros(1,length(t));
            
        for j=1:length(t)
            t10interpV(j)=interp1([10 30 50],[M(1,j) M(2,j) M(3,j)],t10(i),'pchip');
            if t10interpV(j) < 0
                t10interpV(j)= 0;
            end
        end
        
        for k=1:length(s)
                Sboolean(k,i)=s(k) <= s(i);
        end
        
        K=double(Sboolean(:,i));        
        Stemp=s.*K;
        Stemp= Stemp(Stemp ~= 0);
%         interp1((StamanosInterpolation(:,i)),(t10interpV'),(Stemp),'pchip','extrap')
        Pasanteinterp(:,i)=[zeros(i-1,1);interp1((StamanosInterpolation(:,i)),(t10interpV'),(Stemp),'linear')];
%         plot((StamanosInterpolation(:,1)),(t10interpV'),'*r',Stemp,interp1((StamanosInterpolation(:,1)),(t10interpV'),Stemp,'linear'),'k')
%         hold on
    end
    
% Pasanteinterp=exp(Pasanteinterp);
    for i=1:length(s)
        for j=1:length(s)
            if i == j
                Pasanteinterp(i,j)=100;
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
    Pasanteinterp=Pasanteinterp/100;
    Pasanteinterp(end,end)=0.999;
    y=Pasanteinterp;
end