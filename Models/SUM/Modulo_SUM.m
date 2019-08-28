function Out=Modulo_SUM(X,In)

    suma=0;
        for i=1:length(X(1,:))
            suma=suma+X(1:end-1,i);
        end
    y=suma;
    
    sumaw=0;
        for i=1:length(X(1,:))
            sumaw=sumaw+X(end,i);
        end
    water=sumaw;
    Out=[y;water];
    
end
