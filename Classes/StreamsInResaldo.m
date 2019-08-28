classdef StreamsIn
    properties
        S=[]
        n=[]
    end
    methods
        function obj=StreamsIn(n,varargin)
            if iscell(varargin{1}) == 1
                if n == 1
                    r=varargin{1};
                    obj.S=r(1);
                    obj.n=n;
                end
                if n == 2
                    r=varargin{1};
                    obj.S{1}=r{1};
                    obj.S{2}=r{2};
                    obj.n=n;
                end
            else
                if n == 1
                    obj.S{1}=varargin{1};
                    obj.n=n;
                end
                if n == 2
                    obj.S{1}=varargin{1};
                    obj.S{2}=varargin{2};
                    obj.n=n;
                end
            end
        end
    end
end
