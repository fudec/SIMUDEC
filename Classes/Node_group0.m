function y=Node_group0(n)
            S00=Stream(0);
            S0=StreamsOut(1,S00);
            S0I=StreamsIn(1,S00);
            obj=Node_group;
            for i=1:n
                obj(i).Nodes=Node(0,S0,0,S0I);
            end
            y=obj;
end
