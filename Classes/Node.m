classdef Node
    properties
        Si=[];
        Simark=[]
        Siweigth=[];
        So=[];
        Somark=[]
        Soweigth=[];
        mark=0;
        Index=[];
        SumWIn=[];
        SumWOut=[];
        Ecuacion=[]
        Order=[];
        Err
        ErrW
        OldValue
        NewValue
        OldValueW
        NewValueW
        EcuacionWater
        FlujoIn
        FlujoInW
        FlujoOut
        FlujoOutW
        Rebalse
        Descarga
        P80
        F80
        FlujoOutPasante
        FlujoInPasante
        P80Descarga
        P80Rebalse
        F80Alimentacion
        DescargaPasante
        RebalsePasante
        AlimentacionPasante
        Power
        ModelParameters
        Info
        Container
        c
        InIdx
        OutIdx
    end
        methods 
            function obj=Node(Index,So,Ecuacion,Si)
                if Si.n==1
                    r=Si.S{1};
                    obj.Si{1}=r;
                    rs=So.S{1};
                    obj.So=rs{1};
                    obj.Index=Index;
                    obj.Ecuacion=Ecuacion;
                    obj.Simark(1)=obj.Si{1}.mark;
                    obj.Siweigth(1)=obj.Si{1}.weigth;
                    obj.SumWIn=sum(obj.Siweigth);
                    obj.Somark=obj.So.mark;
                    obj.Soweigth=obj.So.weigth;
                    obj.SumWOut=obj.So.weigth;
                else
                for i=1:Si.n
                    r=Si.S{i};
                    obj.Si{i}=r;
                    rs=So.S{1};
                    obj.So=rs{1};
                    obj.Index=Index;
                    obj.Ecuacion=Ecuacion;
                    obj.Simark(i)=obj.Si{i}.mark;
                    obj.Siweigth(i)=obj.Si{i}.weigth;
                    obj.SumWIn=sum(obj.Siweigth);
                    obj.Somark=obj.So.mark;
                    obj.Soweigth=obj.So.weigth;
                    obj.SumWOut=obj.So.weigth;
                end
                end
             end
        end
end
    