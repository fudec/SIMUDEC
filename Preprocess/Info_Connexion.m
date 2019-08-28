function [OrderGroup_,flag]=Info_Connexion(OrderGroup,B)
global Info 

Delta=1.51e1;
DeltaSumidero=15;
Exponent=0.29;

OrderGroup_=OrderGroup;
for j =1:length(Info)
    for i =1 :length(OrderGroup_)
        if strcmp(Info(j).tag,'Input') || strcmp(Info(j).tag,'Stream')
            if OrderGroup_(i).Nodes.Siweigth == Info(j).Stream.weigth
                for k=1:length(B(:,1))
                    if B(k,i) == -1              
                                for t =1:length(Info)
                                    if strcmp(Info(i).tag,'Ball Mill') || strcmp(Info(i).tag,'SAG') || strcmp(Info(i).tag,'Crusher') || strcmp(Info(i).tag,'Hpgr')
                                        if  strcmp(Info(i).tag,'Input') || strcmp(Info(i).tag,'Stream') && ~strcmp(Info(t).tag,'Input') || ~strcmp(Info(t).tag,'Stream')
                                            if ((Info(i).ioc(2,1)-Info(t).ioc(2,1))^2+(Info(i).ioc(2,2)-Info(t).ioc(2,2))^2)^Exponent < Delta;                          
                                                OrderGroup_(k).Nodes.Info = Info(t);
                                                OrderGroup_(k).Nodes.Container = Info(t).Container;
                                                Info(t).Node=OrderGroup_(k).Nodes;
                                            end
                                        end
                                    else
                                        if  strcmp(Info(i).tag,'Input') || strcmp(Info(i).tag,'Stream') && ~strcmp(Info(t).tag,'Input') || ~strcmp(Info(t).tag,'Stream')
                                            if ((Info(i).ioc(2,1)-Info(t).ioc(3,1))^2+(Info(i).ioc(2,2)-Info(t).ioc(3,2))^2)^Exponent < Delta;                          
                                                OrderGroup_(k).Nodes.Info = Info(t);
                                                OrderGroup_(k).Nodes.Container = Info(t).Container;
                                                Info(t).Node=OrderGroup_(k).Nodes;
                                            end
                                        end
                                    end
                                end
                        continue
                    end
                end
            end
        end
    end
end
    for j=1:length(Info)
        if ~strcmp(Info(j).tag,'Stream') && ~strcmp(Info(j).tag,'Input')
                if isempty(Info(j).Container)
                    warndlg(sprintf('Module %s does not have valid model',Info(j).tag2))
                    flag=1;
                    return
                end
        else
            flag=0;
        end
    end


for i = 1:length(OrderGroup_)
    if isempty(OrderGroup_(i).Nodes.Container)
        for j=1:length(OrderGroup_)
            if OrderGroup_(j).Nodes.Siweigth == OrderGroup_(i).Nodes.Siweigth
                OrderGroup_(i).Nodes.Container = OrderGroup_(j).Nodes.Container;
            end
        end
    end
end
for j=1:length(OrderGroup)
    for i=1:length(Info)    
        if ~isempty(Info(i).Node)
            if isequal(Info(i).Node.Ecuacion,@Nageswararao_Bajo) || isequal(Info(i).Node.Ecuacion,@Nageswararao_Sobre)
                if Info(i).Node.Siweigth == OrderGroup_(j).Nodes.Siweigth
                    if Info(i).Node.So ~= OrderGroup_(j).Nodes.So
                        Info(i).Node.So = [Info(i).Node.So OrderGroup_(j).Nodes.So];
                    end
                end
            end
        end
    end
end
end