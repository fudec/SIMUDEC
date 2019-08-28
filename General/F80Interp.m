function F80=F80Interp(x,s)

R=Pasante(x);

for i=1:length(R)
    R(i)=R(i)+1e-8*i;
end
    F80=interp1(R,s,80,'pchip');
end