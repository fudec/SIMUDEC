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
    end
        methods 
            function obj=Node(Index,So,Ecuacion,Si)
                if Si.n == 1
                        r=So.S{1};
                        obj.So=r{1};%% Acceder dos veces a Stream, tambén puede ser con {}()
                        obj.SumWOut=obj.So.weigth;
                        obj.Somark=obj.So.mark;
                        obj.Soweigth=obj.So.weigth;
                        
                        ro=Si.S{1};
                        obj.Si=ro;
                                               
                        obj.Simark=obj.Si.mark;
                        obj.Siweigth=obj.Si.weigth;
                        obj.SumWIn=obj.Si.weigth;
                        
                        obj.Index=Index;
                        obj.Ecuacion=Ecuacion;
                end
                if Si.n == 2
                    r1=Si.S{1};
                    r2=Si.S{2};
                    obj.Si{1}=r1;
                    obj.Si{2}=r2;
                    
                    rs=So.S{1};
                    obj.So=rs{1};
                    obj.SumWOut=obj.So.weigth;
%                     obj.SumWIn=obj.Si{1}.weigth+obj.Si{2}.weigth;
                    obj.Index=Index;
                    obj.Ecuacion=Ecuacion;
                    
                    obj.Simark(1)=obj.Si{1}.mark;
                    obj.Siweigth(1)=obj.Si{1}.weigth;
                    obj.Simark(2)=obj.Si{2}.mark;
                    obj.Siweigth(2)=obj.Si{2}.weigth;
                    obj.SumWIn=sum(obj.Siweigth);
                    
                    
                    obj.Somark=obj.So.mark;
                    obj.Soweigth=obj.So.weigth;
                end
        
                if Si.n == 3
                    obj.Si{1}=Si.S{1};
                    obj.Si{2}=Si.S{2};
                    obj.Si{3}=Si.S{3};
                    obj.So{1}=So;
                    So
                    obj.SumWOut=So.weigth;
                    obj.SumWIn=obj.Si{1}.weigth+obj.Si{2}.weigth+obj.Si{3}.weigth;
                    obj.Index=Index;
                    obj.Ecuacion=Ecuacion;
                end
                if Si.n == 4
                    obj.Si{1}=Si.S{1};
                    obj.Si{2}=Si.S{2};
                    obj.Si{3}=Si.S{3};
                    obj.Si{4}=Si.S{4};
                    obj.So{1}=So;
                    obj.SumWOut=So.weigth;
                    obj.SumWIn=obj.Si{1}.weigth+obj.Si{2}.weigth+obj.Si{3}.weigth+obj.Si{4}.weigth;
                    obj.Index=Index;
                    obj.Ecuacion=Ecuacion;
                end
             end
        end
end