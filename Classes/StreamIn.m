classdef StreamsIn
    properties
        S=[]
    end
    methods
        function obj=StreamsIn(S1,S2)
            obj.S(1)=S1;
            obj.S(2)=S2;
        end
    end
end
