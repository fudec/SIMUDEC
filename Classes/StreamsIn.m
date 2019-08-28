
classdef StreamsIn
    properties
        S=[]
        n=[]
    end
    methods
        function obj=StreamsIn(n,varargin)
            if iscell(varargin{1}) == 1
                for i=1:length(varargin{1})
                    r=varargin{1};
                    obj.S{i}=r{i};
                    obj.n=n;
                end

            else
                for i=1:length(varargin{1})
                    obj.S{i}=varargin{i};
                    obj.n=n;
                end
            end
        end
    end
end
