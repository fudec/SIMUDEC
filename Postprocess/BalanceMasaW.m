function [ErrorGlobalMasa,ErrorGlobalWater,ErrorEntradasSalidasMasa,ErrorEntradasSalidasW,ErrorEntradasSalidasPorcentajeMasa,ErrorEntradasSalidasPorcentajeW,ErrorGlobalPorcentual,Nodesf_,ErrorGlobal]=BalanceMasaW(NodesF,S2,v)
global Info
Nodesf=NodesF;
s=length(Nodesf);
S00=Stream(0);
S0=StreamsOut(1,S00);
S0I=StreamsIn(1,S00);
% 
% for i=1:length(Nodesf)
%     if isequal(Nodesf(i).Nodes.Ecuacion,@Nageswararao) 
%         P80=F80(Nodesf(i).Nodes.FlujoOut,v);
%         FlujoOutPasante=Pasante(Nodesf(i).Nodes.FlujoOut);
%         F80_=F80(Nodesf(i).Nodes.FlujoIn,v);
%         FlujoInPasante=Pasante(Nodesf(i).Nodes.FlujoIn);
%     end
% end
% Nodesf(3).Nodes.Si.Stream

%%  Uni�n de nodos separados en clasdificacores
%%%%% Agregar caracter�sticas a uno de los nodos relacionados %%%%%%%%%
for i=1:s
    for j=1:s
        if length(Nodesf(i).Nodes.Si) == 1 && length(Nodesf(j).Nodes.Si) == 1
          if isprop(Nodesf(i).Nodes.Si{1},'Stream') && isprop(Nodesf(j).Nodes.Si{1},'Stream')
            if Nodesf(i).Nodes.Si{1}.Stream.weigth == Nodesf(j).Nodes.Si{1}.Stream.weigth
                if isequal(Nodesf(i).Nodes.Ecuacion,@Nageswararao_Bajo) && isequal(Nodesf(j).Nodes.Ecuacion,@Nageswararao_Sobre)...
                        || isequal(Nodesf(i).Nodes.Ecuacion,@Spliter_Model_Bajo) && isequal(Nodesf(j).Nodes.Ecuacion,@Spliter_Model_Sobre)...
                            || isequal(Nodesf(i).Nodes.Ecuacion,@SCR_Model_Bajo) && isequal(Nodesf(j).Nodes.Ecuacion,@SCR_Model_Sobre)...
                                || isequal(Nodesf(i).Nodes.Ecuacion,@Trommel_Model_Bajo) && isequal(Nodesf(j).Nodes.Ecuacion,@Trommel_Model_Sobre)
                            
                    Nodesf(i).Nodes.Rebalse=Nodesf(i).Nodes.So.Stream;
                    Nodesf(i).Nodes.Descarga=Nodesf(j).Nodes.So.Stream;
                    Nodesf(i).Nodes.FlujoIn=Nodesf(i).Nodes.Si{1}.Stream.Value;
                    Nodesf(i).Nodes.FlujoInW=Nodesf(i).Nodes.Si{1}.Stream.WaterFlow;
                    Nodesf(i).Nodes.So(1)=StreamHandle(Nodesf(i).Nodes.So.Stream);
                    Nodesf(i).Nodes.So(2)=StreamHandle(Nodesf(j).Nodes.So.Stream);
                    Nodesf(i).Nodes.FlujoOut=Nodesf(i).Nodes.So(1).Stream.Value+Nodesf(i).Nodes.So(2).Stream.Value;
                    Nodesf(i).Nodes.FlujoOutW=Nodesf(i).Nodes.So(1).Stream.Value+Nodesf(i).Nodes.So(2).Stream.Value;
                    Nodesf(j).Nodes=Node(0,S0,0,S0I);
%                     Nodesf(j).Nodes.P80=P80;
%                     Nodesf(j).Nodes.FlujoOutPasante=FlujoOutPasante;
%                     Nodesf(j).Nodes.F80=F80_;
%                     Nodesf(j).Nodes.FlujoInPasante=FlujoInPasante;
                end
            end
          end
        end
    end
end
%%%%% Eliminar Nodos innecesarios %%%%%%%%%
count=0;
vcount=[];
for i=1:s
    if Nodesf(i).Nodes.Index == 0
        count=count+1;
        vcount(count)=i;
    end
end
if isempty(vcount) ~= 0
    Nodesf(vcount)=[];
else
end
%%

for i=1:length(Nodesf)
    if length(Nodesf(i).Nodes.Si)==2   %%%%%5 Falta para mas sumatorias
        if isa(Nodesf(i).Nodes.Si,'StreamHandle') == 0
            vt1=Nodesf(i).Nodes.Si{1};
            vt2=Nodesf(i).Nodes.Si{2};
            Nodesf(i).Nodes.Si=[];
            Nodesf(i).Nodes.Si=StreamHandle(Stream(0));
            Nodesf(i).Nodes.Si(1)=StreamHandle(vt1);
            Nodesf(i).Nodes.Si(2)=StreamHandle(vt2);
        end        
    end
end
n=1;
ll=length(Nodesf);
while n <= ll
   if Nodesf(n).Nodes.Index == 0
       Nodesf(n) = [];
   end
   n=n+1;
   ll=length(Nodesf);
end

for i=1:length(Nodesf)
    if length(Nodesf(i).Nodes.Si) == 1 && length(Nodesf(i).Nodes.So) == 1
        Nodesf(i).Nodes.Err=sum(Nodesf(i).Nodes.Si{1}.Stream.Value-Nodesf(i).Nodes.So.Stream.Value);
        Nodesf(i).Nodes.ErrW=sum(Nodesf(i).Nodes.Si{1}.Stream.WaterFlow-Nodesf(i).Nodes.So.Stream.WaterFlow);
    end
    if length(Nodesf(i).Nodes.Si) > 1 && length(Nodesf(i).Nodes.So) == 1
        suma=0;
        sumaw=0;
        for y=1:length(Nodesf(i).Nodes.Si)  
            if iscell(Nodesf(i).Nodes.Si)
                suma=suma+Nodesf(i).Nodes.Si{y}.Stream.Value;
                sumaw=sumaw+Nodesf(i).Nodes.Si{y}.Stream.WaterFlow;
            else
                suma=suma+Nodesf(i).Nodes.Si(y).Stream.Stream.Value;
                sumaw=sumaw+Nodesf(i).Nodes.Si(y).Stream.Stream.WaterFlow;
            end
        end
        Nodesf(i).Nodes.Err=sum(suma-Nodesf(i).Nodes.So.Stream.Value);
        Nodesf(i).Nodes.ErrW=sum(sumaw-Nodesf(i).Nodes.So.Stream.WaterFlow);
    end
    if length(Nodesf(i).Nodes.Si) == 1 && length(Nodesf(i).Nodes.So) == 2
        Nodesf(i).Nodes.Err=sum(Nodesf(i).Nodes.Si{1}.Stream.Value-Nodesf(i).Nodes.So(1).Stream.Value-Nodesf(i).Nodes.So(2).Stream.Value);
        Nodesf(i).Nodes.ErrW=sum(Nodesf(i).Nodes.Si{1}.Stream.WaterFlow-Nodesf(i).Nodes.So(1).Stream.WaterFlow-Nodesf(i).Nodes.So(2).Stream.WaterFlow);
    end
   
end
s=length(Nodesf);
for i=1:s
%           if isprop(Nodesf(i).Nodes.Si,'Stream') == 1 && isprop(Nodesf(i).Nodes.So,'Stream') == 1
            if length(Nodesf(i).Nodes.Si) == 1 && length(Nodesf(i).Nodes.So) == 1            
                Nodesf(i).Nodes.FlujoIn=Nodesf(i).Nodes.Si{1}.Stream.Value;                                       
                Nodesf(i).Nodes.FlujoOut=Nodesf(i).Nodes.So.Stream.Value;
                Nodesf(i).Nodes.FlujoInW=Nodesf(i).Nodes.Si{1}.Stream.WaterFlow;                                       
                Nodesf(i).Nodes.FlujoOutW=Nodesf(i).Nodes.So.Stream.WaterFlow;
            elseif length(Nodesf(i).Nodes.Si) == 1 && length(Nodesf(i).Nodes.So) == 2
                Nodesf(i).Nodes.FlujoIn=Nodesf(i).Nodes.Si{1}.Stream.Value;                                       
                Nodesf(i).Nodes.FlujoOut=Nodesf(i).Nodes.So(1).Stream.Value+Nodesf(i).Nodes.So(2).Stream.Value;
                Nodesf(i).Nodes.FlujoInW=Nodesf(i).Nodes.Si{1}.Stream.WaterFlow;                                       
                Nodesf(i).Nodes.FlujoOutW=Nodesf(i).Nodes.So(1).Stream.WaterFlow+Nodesf(i).Nodes.So(2).Stream.WaterFlow;
            end
            
            if length(Nodesf(i).Nodes.Si) > 1 && length(Nodesf(i).Nodes.So) == 1
                g=length(Nodesf(i).Nodes.Si);
                suma=0;
                sumaw=0;
                for u=1:g
                    if iscell(Nodesf(i).Nodes.Si)
                        suma=suma+Nodesf(i).Nodes.Si{u}.Stream.Value;
                        sumaw=sumaw+Nodesf(i).Nodes.Si{u}.Stream.WaterFlow;
                    else
                        suma=suma+Nodesf(i).Nodes.Si(u).Stream.Stream.Value;
                        sumaw=sumaw+Nodesf(i).Nodes.Si(u).Stream.Stream.WaterFlow;
                    end
                end
                Nodesf(i).Nodes.FlujoIn=suma;
                Nodesf(i).Nodes.FlujoOut=Nodesf(i).Nodes.So.Stream.Value;
                Nodesf(i).Nodes.FlujoInW=sumaw;
                Nodesf(i).Nodes.FlujoOutW=Nodesf(i).Nodes.So.Stream.WaterFlow;
            end
%           end
          
end

for i=1:length(Nodesf)
    if ~isequal(Nodesf(i).Nodes.Ecuacion,@Nageswararao_Bajo) || ~isequal(Nodesf(i).Nodes.Ecuacion,@Spliter_Model_Bajo) || ~isequal(Nodesf(i).Nodes.Ecuacion,@SCR_Model_Bajo)
        Nodesf(i).Nodes.P80=F80(Nodesf(i).Nodes.FlujoOut,v);
        Nodesf(i).Nodes.FlujoOutPasante=Pasante(Nodesf(i).Nodes.FlujoOut);
        Nodesf(i).Nodes.F80=F80(Nodesf(i).Nodes.FlujoIn,v);
        Nodesf(i).Nodes.FlujoInPasante=Pasante(Nodesf(i).Nodes.FlujoIn);
    elseif isequal(Nodesf(i).Nodes.Ecuacion,@Nageswararao_) || isequal(Nodesf(i).Nodes.Ecuacion,@Spliter_Model_Bajo) || isequal(Nodesf(i).Nodes.Ecuacion,@SCR_Model_Bajo)
        Nodesf(i).Nodes.P80Descarga=F80(Nodesf(i).Nodes.Descarga.Value,v);
        Nodesf(i).Nodes.P80Rebalse=F80(Nodesf(i).Nodes.Rebalse.Value,v);
        Nodesf(i).Nodes.F80Alimentacion=F80(Nodesf(i).Nodes.FlujoIn,v);       
        Nodesf(i).Nodes.DescargaPasante=Pasante(Nodesf(i).Nodes.Descarga.Value);
        Nodesf(i).Nodes.RebalsePasante=Pasante(Nodesf(i).Nodes.Rebalse.Value);
        Nodesf(i).Nodes.AlimentacionPasante=Pasante(Nodesf(i).Nodes.FlujoIn);
    end
end


for i=1:length(S2)
    for j=1:length(Nodesf)
        if isfield(Info(j),'Stream')
         if ~isempty(Info(j).Stream) 
            if strcmp(S2(i).Streams.Stream,Info(j).Stream.Name)
                Info(j).Stream=S(i).Streams.Stream;
            end
         end
        end
    end
end
% Nodesf_=Nodesf;
ErrorGlobalMasa=0;
ErrorGlobalWater=0;
for i=1:length(Nodesf)
    ErrorGlobalMasa=ErrorGlobalMasa+Nodesf(i).Nodes.Err;
    ErrorGlobalWater=ErrorGlobalWater+Nodesf(i).Nodes.ErrW;
end
for i=1:length(S2)
    if S2(i).Streams.Stream.mark ~= 0
        S2(i).Streams.Stream.mark =0;
    end
end
SumIn=0;
SumOut=0;
SumOutW=0;
SumInW=0;
for i=1:length(S2)
    for j=1:length(Nodesf)
      if length(Nodesf(j).Nodes.Si) > 1 
          for u=1:length(Nodesf(j).Nodes.Si)
              if iscell(Nodesf(j).Nodes.Si)
                  if S2(i).Streams.Stream.weigth == Nodesf(j).Nodes.Si{u}.Stream.weigth               
                    S2(i).Streams.Stream.EntradaMark=1; %% Si no tiene ese valor en mark, es una salida
                end
              else
                if S2(i).Streams.Stream.weigth == Nodesf(j).Nodes.Si(u).Stream.Stream.weigth               
                    S2(i).Streams.Stream.EntradaMark=1; %% Si no tiene ese valor en mark, es una salida
                end
              end
          end
      elseif length(Nodesf(j).Nodes.Si) == 1 
          if S2(i).Streams.Stream.weigth == Nodesf(j).Nodes.Si{1}.Stream.weigth               
                S2(i).Streams.Stream.EntradaMark=1; %% Si no tiene ese valor en mark, es una salida
          end
      end     
      if length(Nodesf(j).Nodes.So) > 1 
          for u=1:length(Nodesf(j).Nodes.So)
            if S2(i).Streams.Stream.weigth == Nodesf(j).Nodes.So(u).Stream.weigth               
                S2(i).Streams.Stream.SalidaMark=1; %% Si no tiene ese valor en mark, es una salida
            end
          end
      elseif length(Nodesf(j).Nodes.So) == 1 
          if S2(i).Streams.Stream.weigth == Nodesf(j).Nodes.So.Stream.weigth               
                S2(i).Streams.Stream.SalidaMark=1; %% Si no tiene ese valor en mark, es una salida
          end
      end   
   end
end
for i=1:length(S2)
    if isempty(S2(i).Streams.Stream.EntradaMark)
        SumOut=SumOut+S2(i).Streams.Stream.Value;
        SumOutW=SumOutW+S2(i).Streams.Stream.WaterFlow;
    end
    if isempty(S2(i).Streams.Stream.SalidaMark) 
        SumIn=SumIn+S2(i).Streams.Stream.Value;
        SumInW=SumInW+S2(i).Streams.Stream.WaterFlow;
    end
end
ErrorEntradasSalidasMasa=sum(SumIn-SumOut);
ErrorEntradasSalidasW=SumInW-SumOutW;
ErrorEntradasSalidasPorcentajeMasa=ErrorEntradasSalidasMasa/sum(SumIn)*100;
ErrorEntradasSalidasPorcentajeW=ErrorEntradasSalidasW/SumInW*100;
for i=1:length(Nodesf)
    for j=1:length(Info)
        if Nodesf(i).Nodes.Index == Info(j).k
            Info(j).Node=Nodesf(i).Nodes;
        end
    end
end
ErrorGlobalPorcentual=ErrorEntradasSalidasPorcentajeMasa+ErrorEntradasSalidasPorcentajeW;
ErrorGlobal=ErrorGlobalMasa+ErrorGlobalWater;
% 
% 
% for i=1:s
%     for j=1:s
%         if length(Nodesf(i).Nodes.Si) == 1 && length(Nodesf(j).Nodes.Si) == 1
%           if isprop(Nodesf(i).Nodes.Si,'Stream') == 1 && isprop(Nodesf(j).Nodes.Si,'Stream') == 1
%             if Nodesf(i).Nodes.Si.Stream.weigth == Nodesf(j).Nodes.Si.Stream.weigth
%                 if isequal(Nodesf(i).Nodes.Ecuacion,@Nageswararao_) && isequal(Nodesf(j).Nodes.Ecuacion,@Nageswararao)        
%                     Nodesf(j).Nodes.Rebalse=Nodesf(j).Nodes.So.Stream;
%                     Nodesf(j).Nodes.Descarga=Nodesf(j).Nodes.So.Stream;
%                     Nodesf(j).Nodes.FlujoIn=Nodesf(j).Nodes.Si.Stream.Value;
%                     Nodesf(j).Nodes.FlujoInW=Nodesf(j).Nodes.Si.Stream.WaterFlow;
%                     Nodesf(j).Nodes.So(1)=StreamHandle(Nodesf(j).Nodes.So.Stream);
%                     Nodesf(j).Nodes.So(2)=StreamHandle(Nodesf(j).Nodes.So.Stream);
%                     Nodesf(j).Nodes.FlujoOut=Nodesf(j).Nodes.So(1).Stream.Value+Nodesf(i).Nodes.So(2).Stream.Value;
%                     Nodesf(j).Nodes.FlujoOutW=Nodesf(j).Nodes.So(1).Stream.Value+Nodesf(i).Nodes.So(2).Stream.Value;
% %                     Nodesf(j).Nodes=Node(0,S0,0,S0I);
%                 end
%             end
%           end
%         end
%     end
% end
    Nodesf_=Nodesf;
end
