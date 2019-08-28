function y=RD(s,KnotsSize,KnotsValue)
% KnotsSize2=linspace(min(KnotsSize),max(KnotsSize),30);
% KnotsValue2=interp1(KnotsSize,KnotsValue,KnotsSize2,'pchip');

KnotsInterp=interp1(log(KnotsSize),log(KnotsValue),log(s),'pchip');
% KnotsInterp=exp(KnotsInterp);
% for i=1:length(KnotsInterp)
%     if KnotsInterp(i) < 0
%         KnotsInterp(i) = 0;
%     end
% end
% plot(KnotsSize2,KnotsValue2,s,KnotsInterp,'k')
% axis([0 30 0 max(KnotsValue)])
% KnotsInterp
% for i=1:length(KnotsInterp)
%     if KnotsInterp(i) ~= 0
%         KnotsInterp(i) = exp(KnotsInterp(i));
%     end
% end
KnotsInterp = exp(KnotsInterp);
loglog(KnotsSize,KnotsValue,'or',s,KnotsInterp,'k')
y=KnotsInterp;
% semilogx(s,KnotsInterp)
end