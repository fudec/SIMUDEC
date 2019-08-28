function y=SumaWFun(x)
            suma=0;
            n=length(x);
            for i=1:n
                if x(i).Nodes.Index ~= 0
                    suma=suma+1;
                end
            end
            y=suma;
end