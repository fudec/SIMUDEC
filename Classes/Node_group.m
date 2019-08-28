classdef Node_group
    properties
        Nodes=[];
    end
    methods
       function r = suma(obj1,obj2)
         n=length(obj1);
        for i=1:n
            if isequal(obj2(i).Nodes.Index,0) == 1 
                obj2(i).Nodes = obj1(i).Nodes;
            end
        end
        r=obj2;
       end
       function r=resta(obj1,obj2)
         n=length(obj1);
        for i=1:n
            for j=1:n
               if isequal(obj1(i).Nodes.Index,obj2(j).Nodes.Index) == 1  && isequal(obj1(i).Nodes.Ecuacion,obj2(j).Nodes.Ecuacion) == 1           
                    obj1(i).Nodes = [];
                    S00=Stream(0);
                    S0=StreamsOut(1,S00);
                    S0I=StreamsIn(1,S00);
                    obj1(i).Nodes=Node(0,S0,0,S0I);
                end
            end
        end
           r=obj1;
       end
     end
end

