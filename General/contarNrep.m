function y=contarNrep(v,x)
suma=0;
for i=1:length(v)
    if v(i) == x
        suma=suma+1;
    end
    y=suma;
end