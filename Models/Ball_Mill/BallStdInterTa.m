function y=BallStdInterTa(s,ta)
t=[1 1/1.25 1/1.5 1/10 1/100 1/250 1/500 1e-6];
t10interpV=ta*[2.687 1.631 1 0.9372 0.8070 0.6365 1e-6];


t10interpV=[100 t10interpV]/100;
for i=1:length(s)
    StamanosInterpolation(:,i)=s(i)*t;
%     [M I]=min(StamanosInterpolation(:,i));
%     StamanosInterpolation2(:,i)=[linspace(min(StamanosInterpolation(:,i)),StamanosInterpolation(I-2),100) linspace(min(StamanosInterpolation(:,i)),max(StamanosInterpolation(:,i)),100)];
%     t10interpV2(:,i)=interp1(StamanosInterpolation(:,i),log(t10interpV),StamanosInterpolation2(:,i),'pchip');
end
%     Pasanteinterp=zeros(length(s),length(s));
    for i=1:length(s)
        for k=1:length(s)
                Sboolean(k,i)=s(k) <= s(i);
        end
%         K=double(Sboolean(:,i));        
%         Stemp=s'.*K;
%         Pasanteinterp(:,i)=interp1(log(StamanosInterpolation(:,i)),log(t10interpV'),log(Stemp),'linear');
% %         plot(log10(StamanosInterpolation(:,i)),log10(t10interpV'),'or',log10(Stemp),Pasanteinterp(:,i),'k')
% %         axis([-4.5 2.5 -2.2 0]);
% %         hold on
        K=double(Sboolean(:,i));
        Stemp=s.*K; %%% Cuidado con la transpuesta, resulta matriz
        Stemp= Stemp(Stemp ~= 0);
        size(StamanosInterpolation(:,i));
        size(t10interpV');
        size(Stemp);
%         size(interp1((StamanosInterpolation(:,i)),(t10interpV'),(Stemp),'linear'))
        Pasanteinterp(:,i)=[zeros(i-1,1);interp1((StamanosInterpolation(:,i)),(t10interpV'),(Stemp),'linear')];
    end
    for i=1:length(Pasanteinterp(:,1))
        for j=1:length(Pasanteinterp(1,:))
            if i == j
%                 Pasanteinterp(i,j)=100;
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
%     Pasanteinterp=Pasanteinterp/100;
    y=Pasanteinterp;

end
    
    