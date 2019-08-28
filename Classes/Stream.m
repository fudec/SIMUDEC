classdef Stream
    properties
        weigth=[];
        mark=0;
        Value
        Name
        WaterFlow
        SalidaMark
        EntradaMark
        P80
        Mass
        Water
        ro
        ww
        vv
    end
    methods
        function obj=Stream(weigth)
            obj.weigth=weigth;
        end
    end
end