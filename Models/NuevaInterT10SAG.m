function y=NuevaInterT10SAG(s,t10)
M=[2.33 3.06 4.98 23.33 50.53;6.89 9.41 15.62 61.58 92.49;10.32 14.71 25.88 82.86 96.47];
t=[1/75 1/50 1/25 1/4 1/2];
t10interpV=zeros(1,length(t));
        for i=1:length(t)
            t10interpV(i)=interp1([10 30 50],[M(1,i) M(2,i) M(3,i)],t10,'pchip');
        end
        

t10interpV=t10interpV/100;
StamanosInterpolation=zeros(length(t),length(s));

for i=1:length(s)
    StamanosInterpolation(:,i)=s(i)*t;
end
    Pasanteinterp=zeros(length(s),length(s));
    for i=1:length(s)
        for k=1:length(s)
                Sboolean(k,i)=s(k) < s(i);
        end
        K=double(Sboolean(:,i));        
        Stemp=s'.*K;
        Pasanteinterp(:,i)=interp1((StamanosInterpolation(:,i)),(t10interpV'),(Stemp),'pchip');
    end
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
    
    