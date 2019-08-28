function out=isSalida(Inc)
cu=1;
    for i =1:length(Inc(:,1))
        temp = Inc(i,:);
        if isempty(temp(temp == -1))
            out(cu)= i;
            cu=cu+1;
        end
    end
end