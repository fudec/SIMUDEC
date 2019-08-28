function y=EcsInter(C,s,f,T10)
S=[14.50 20.63 28.89 41.10 57.80];
vS1=[0.35 0.30 0.25 0.20 0.15;0.8 0.7 0.5 0.4 0.3;1.2 1 0.8 0.6 0.4];

for i=1:length(vS1(1,:))
        T10In(i)=interp1([10 20 30]',[vS1(1,i) vS1(2,i) vS1(3,i)],T10,'spline');
end
        Ecs=interp1(S,log(T10In),s,'spline');
        plot(S,T10In,'or',s,exp(Ecs),'k')
%         Ecs2=interp2([10*ones(length(s),1) 20*ones(length(s),1) 30*ones(length(s),1)],[s' s' s'],vS1,T10,s)
Ecs=exp(Ecs);
Pk=0;
Pk2=0;
C=diag(C);
for i=1:3
    TnInt(i,:)=interp1(S,log(vS1(i,:)),s,'pchip');
end
TnInt=exp(TnInt);
for i=1:length(TnInt(1,:))
        Ecs2(i)=interp1([10 20 30]',log([TnInt(1,i) TnInt(2,i) TnInt(3,i)]),T10,'pchip');
end
Ecs2=exp(Ecs2);

for i=1:length(s)
    Pk=Pk+C(i)*f(i)*Ecs(i);
end
for i=1:length(s)
    Pk2=Pk2+C(i)*f(i)*Ecs2(i);
end
y=Pk;
% plot(T10_por,vS1,'k',T10,Ecsi,'or')