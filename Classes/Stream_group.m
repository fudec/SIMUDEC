classdef Stream_group
    properties
        Streams=[];
        F
        Length
        c
        tag
        P80
        Mass
        Water
        ro
        ps
    end
    methods
       function r = suma(obj1,obj2)
         n=length(obj1);
        for i=1:n
            if isequal(obj2(i).Streams.weigth,0) == 1 
                obj2(i).Streams = obj1(i).Streams;
            end
        end
        r=obj2;
       end
       function r=resta(obj1,obj2)
         n=length(obj1);
        for i=1:n
            for j=1:n
               if isequal(obj1(i).Streams.weigth,obj2(j).Streams.weigth) == 1             
                    obj1(i).Streams = [];
                    S00=Stream(0);
                    obj1(i).Streams=S00;
                end
            end
        end
           r=obj1;
       end
     end
end

