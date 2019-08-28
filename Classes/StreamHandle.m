classdef StreamHandle < handle
    properties
        Stream
        weigth
        Index
    end
    methods
        function obj=StreamHandle(Stream)          
                obj.Stream=Stream;
                obj.weigth=Stream.weigth;
        end
    end
end