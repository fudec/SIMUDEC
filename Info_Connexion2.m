function [OrderGroup_,flag]=Info_Connexion2(OrderGroup)
global Info 

Delta=2e2;
DeltaSumidero=15;
Exponent=0.5;
v = 10000;
c = 0;
OrderGroup_=OrderGroup;
for j =1:length(Info)
    for i =1 : length(OrderGroup_)            
            if any(v == i )              
                continue
            end           
        if strcmp(Info(j).tag,'Input') || strcmp(Info(j).tag,'Stream')
            if OrderGroup_(i).Nodes.Siweigth == Info(j).Stream.weigth
                                for t =1:length(Info)                                  
                                    if strcmp(Info(t).tag,'Ball Mill') || strcmp(Info(t).tag,'SAG') || strcmp(Info(t).tag,'Crusher') || strcmp(Info(t).tag,'HPGR') 
                                        if ((Info(j).ioc(2,1)-Info(t).ioc(1,1))^2+(Info(j).ioc(2,2)-Info(t).ioc(1,2))^2)^Exponent < Delta*1
                                                        OrderGroup_(i).Nodes.Info = Info(t);
                                                        OrderGroup_(i).Nodes.Container = Info(t).Container;
                                                        Info(t).Node=OrderGroup_(i).Nodes;
                                                        c=c+1;
                                                        v(c) = i;
                                        end

                                    end
                   
                                end
            end
        end
    end
end

for j = 1:length(Info)   
    for i = 1 :length(OrderGroup_)
        i
            if any(v == i)
                55
                break
            end     
            i
            
        if strcmp(Info(j).tag,'Input') || strcmp(Info(j).tag,'Stream')
            if OrderGroup_(i).Nodes.Siweigth == Info(j).Stream.weigth
                                for t =1:length(Info)
                                    if strcmp(Info(t).tag,'Hydrocyclone') || strcmp(Info(t).tag,'Screener') || strcmp(Info(t).tag,'Spliter')
                                        ((Info(j).ioc(1,1)-Info(t).ioc(3,1))^2+(Info(j).ioc(1,2)-Info(t).ioc(3,2))^2)^Exponent                                      
                                             if ((Info(j).ioc(1,1)-Info(t).ioc(3,1))^2+(Info(j).ioc(1,2)-Info(t).ioc(3,2))^2)^Exponent < 2.4*Delta                                        
                                                        OrderGroup_(i).Nodes.Info = Info(t);
                                                        OrderGroup_(i).Nodes.Container = Info(t).Container;
                                                        Info(t).Node=OrderGroup_(i).Nodes;
                                                        c=c+1;
                                                        v(c) = i;
                                             end
                                    end
                                end
            end
       end
    end
end


    for j=1:length(Info)
        if ~strcmp(Info(j).tag,'Stream') && ~strcmp(Info(j).tag,'Input') && ~strcmp(Info(j).tag,'Sum')
                if isempty(Info(j).Container)
                    warndlg(sprintf('Module %s does not have valid model',Info(j).tag2))
                    flag=1;
                    return
                end
        else
            flag=0;
        end
    end


% for i = 1:length(OrderGroup_)
%     if isempty(OrderGroup_(i).Nodes.Container)
%         for j=1:length(OrderGroup_)
%             if OrderGroup_(j).Nodes.Siweigth == OrderGroup_(i).Nodes.Siweigth
%                 OrderGroup_(i).Nodes.Container = OrderGroup_(j).Nodes.Container;
%             end
%         end
%     end
% end
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