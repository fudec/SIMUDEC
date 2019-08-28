function [X,NumIt,It_V,Error_Vector,Errorf,OrderGroup_,time]=SOLVER2(OrderGroup,S,Tol,MaxIt,Inc,Mtol)
global  S2 v

n=length(OrderGroup);
m=length(S2);
h=0.001;
Err=1;
it=1;
w=0;
tic
VectorTemporal(:,1)=zeros(length(OrderGroup)*(length(v)+1),1);       
It_Vector(1)=1;


it=0;
itcu=0;
Error=10;
Error_Vector=0;
n=length(OrderGroup);
fit=figure;
axesit=axes(fit);
set(fit,'Name','Convergencia','numbertitle','off');
q=zeros(length(v)+1,1);

 while it <= MaxIt
        for i=1:n
            r=length(OrderGroup(i).Nodes.Si);
            if r == 1
                    q=zeros(length(v)+1,1);                  
                    OrderGroup(i).Nodes.OldValue=OrderGroup(i).Nodes.So.Stream.Value;
                    OrderGroup(i).Nodes.So.Stream.Value=(1-q).*OrderGroup(i).Nodes.Ecuacion(OrderGroup(i).Nodes.Si{1}.Stream.Value,OrderGroup(i).Nodes.Container)+q.*OrderGroup(i).Nodes.Si{1}.Stream.Value;
                    OrderGroup(i).Nodes.NewValue=OrderGroup(i).Nodes.So.Stream.Value;                   
            else
                Val_Temp=[];
                suma=0;
                    for o=1:r
                        Val_Temp=[Val_Temp OrderGroup(i).Nodes.Si{o}.Stream.Value];
                        suma=suma+OrderGroup(i).Nodes.Si{o}.Stream.Value;
                    end
                    q=zeros(length(v)+1,1);                   
                    OrderGroup(i).Nodes.OldValue=OrderGroup(i).Nodes.So.Stream.Value;
                    OrderGroup(i).Nodes.So.Stream.Value=(1-q).*OrderGroup(i).Nodes.Ecuacion(Val_Temp,OrderGroup(i).Nodes.Container)+q.*suma;
                    OrderGroup(i).Nodes.NewValue=OrderGroup(i).Nodes.So.Stream.Value;
            end              
        end
    
    if it > 1
        Error_=0;
        for i=1:n
            OrderGroup(i).Nodes.Err=norm(OrderGroup(i).Nodes.OldValue-OrderGroup(i).Nodes.NewValue,2);
            Error_=Error_+OrderGroup(i).Nodes.Err;
        end
        
    for i=1:n
        VNew((i-1)*(length(v)+1)+1:i*(length(v)+1),1)=OrderGroup(i).Nodes.NewValue;
        VOld((i-1)*(length(v)+1)+1:i*(length(v)+1),1)=OrderGroup(i).Nodes.OldValue;
    end
    %%%% Agregar balance  de masa
        Error=norm(VNew-VOld,2);
        VectorTemporal(:,it)=VNew;
        Error_Vector(it)=Error;
        It_Vector(it)=it;
    end
    
    if it == MaxIt
        sumIn=zeros(length(v)+1,1);
        sumOut=zeros(length(v)+1,1);
        
        IndexSalidas=isSalida(Inc);
        IndexEntradas=isEntrada(Inc);
        
        for m=1:length(S)
            for t=1:length(IndexSalidas)
                if m == IndexSalidas(t)
                    sumOut=sumOut+S(m).Streams.Stream.Value;
                end
            end
        end
        for m=1:length(S)
            for t=1:length(IndexEntradas)
                if m == IndexEntradas(t)
                    sumIn=sumIn+S(m).Streams.Stream.Value;
                end
            end
        end
            
                semilogy(axesit,It_Vector,Error_Vector,'k')
                xlabel('Iteration');
                ylabel('Error[log]');
                grid on
            
             Error_Vector(1)=100;
             [~,Idx]=min(Error_Vector);
        for j=1:n
            OrderGroup(j).Nodes.So.Stream.Value=VectorTemporal((j-1)*(length(v)+1)+1:j*(length(v)+1),Idx);
        end   
        
    end
    
    if Error <= Tol
        sumIn=zeros(length(v)+1,1);
        sumOut=zeros(length(v)+1,1);
        
        IndexSalidas=isSalida(Inc);
        IndexEntradas=isEntrada(Inc);
        
        for m=1:length(S)
            for t=1:length(IndexSalidas)
                if m == IndexSalidas(t)
                    sumOut=sumOut+S(m).Streams.Stream.Value;
                end
            end
        end
        for m=1:length(S)
            for t=1:length(IndexEntradas)
                if m == IndexEntradas(t)
                    sumIn=sumIn+S(m).Streams.Stream.Value;
                end
            end
        end
        
        if abs((sum(sumOut)-sum(sumIn))/sum(sumIn)) <= Mtol
            abs((sum(sumOut)-sum(sumIn))/sum(sumIn))
                semilogy(axesit,It_Vector,Error_Vector,'k')
                xlabel('Iteración');
                ylabel('Error[log]');
                grid on
            
             Error_Vector(1)=100;
             [~,Idx]=min(Error_Vector);
             
                for j=1:n
                    OrderGroup(j).Nodes.So.Stream.Value=VectorTemporal((j-1)*(length(v)+1)+1:j*(length(v)+1),Idx);
                end
        
        break
                  
        end
        
    end
         it=it+1;
end


    k=length(Error_Vector);
    Errorf=Error_Vector(k);
    r=length(S);
    for i=1:r
        S(i).F=Pasante(S(i).Streams.Stream.Value);
    end
    NumIt=it;
    It_V=It_Vector;
    X=S;
  
OrderGroup_=OrderGroup;
time=toc;
end