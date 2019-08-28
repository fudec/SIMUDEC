classdef StreamsOut
    properties
        S=[]
        n=[]
    end
    methods
        function obj=StreamsOut(n,varargin)
            if n == 1
                obj.S{1}=varargin(1);
                obj.n=n;
            elseif n == 2
                obj.S{1}=varargin{1};
                obj.S{2}=varargin{2};
                obj.n=n;
            end
        end
    end
end