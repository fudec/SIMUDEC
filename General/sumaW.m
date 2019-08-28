function y=SumaW(x)
suma=0;
            for i=1:n
                if W(i).Nodes.SumWIn ~= 0
                    suma=suma+1;
                end
            end
            y=suma;
end