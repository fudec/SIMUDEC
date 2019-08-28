function [y,water]=Modulo_Sumidero(x,win,In)
suma=0;
        for i=1:length(x(1,:))
            suma=suma+x(:,i);
        end
    y=suma;
    sumaw=0;
        for i=1:length(win)
            sumaw=sumaw+win(i);
        end
    water=sumaw;
end