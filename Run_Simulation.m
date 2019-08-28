%  function Run_Simulation(~,~)
global v  X  cu S2 SolverData MaxIt Tol state Info OrderGroup
% F1=[0.00 17.00 20.60 18.07 12.33 14.34 10.84 5.41 5.10 3.90 3.54 3.01 2.59 2.21 1.88 1.62 1.38 1.18 0.85 0.15]';
% f1=F1';
% F1=[0.00 2.00 2.60 1.07 2.33 3.34 2.84 8.41 10.10 11.90 9.54 14.01 16.59 12 11.88 18.62 10.38 8.18 4.85 4.15]';
% Message='Sistema determinado';
% exito = msgbox(Message);
% S(5).Streams.Value=F1';
% if strcmp(Message,'Sistema determinado') == 1
%     set(Resultados_push,'Enable','on')
%     set(r,'Enable','on')
% else
%     set(Resultados_push,'Enable','off')
%     set(r,'Enable','off')
% end
% S(5).Streams=Stream(5);
% S(8).Streams.Value=Info(8).v.val;

MassTol=1e-5;

[B,S,M,A,Adj,Inc,Ms,flag]=PREPROCESO(cu);

if flag == 1
    return
end
% B = [   -1     1     0     0     0     0     0     0     0     0     0     0     0     0     0     0  0;
%          0    -1     1     0     0     0     0     0     0     0     0     0     0     0     0     0  0;
%          0     0     0     0    -1     0     0     0     1     0     0     0     0     0     0     0  0;
%          0     0     0     0     0     0     0     0     0    -1     0     0     1     0     0     0  0;
%          0     0     0     0     0    -1     1     0     0     0     0     0     0     0     0    -1  0;
%          0     0     0     0     0     0    -1     1     0     0     0     0     0     0     0     0  0;
%          0     0     0     0     0     0     0     0     0     0    -1     1     0     0     0     0  0;
%          0     0     0     0    -1     1     0     0     0     0     0     0     0     0     0     0  0;
%          0     0     0     0     0     0     0     0     0    -1     1     0     0     0     0     0  0;
%          0    -1     0     1     0     0     0     0     0     0     0     0     0     0     0     0  0;
%          0     0     0    -1     1     0     0    -1     0     0     0     0     0     0     0     0  0;
%          0     0     0     0     0     0     0     0    -1     1     0    -1     0     0     0     0 -1;
%          1     0     -1    0     0     0     0     0     0     0     0     0     0    -1    -1     0  0];
     
%  
% S(14).Streams = Info(19).Stream;
% S(15).Streams = Info(20).Stream;
% S(17).Streams = Info(22).Stream;
% M(11) = M(5);
% M(12) = M(5);
% M(13) = M(5);
     
[OrderGroup,S2,TYPTime]=AlDefV2(B,S,M);
[OrderGroup,flag]=Info_Connexion2(OrderGroup);
if flag == 1
    return
end

% S2(17).Streams.Stream.Value=[F1/6*0;200/3];
% S2(16).Streams.Stream.Value=[F1/2*0;200/2];
% S2(14).Streams.Stream.Value=[F1/3*2;300/3*2];
% S2(15).Streams.Stream.Value=[F1/3*2;300/3*2];


% S2(2).Streams.Stream.WaterFlow=500;
% S2(2).Streams.Stream.WaterFlow=200;
% S2(5).Streams.Stream.WaterFlow=200;
% S2(20).Streams.Stream.Value=[F1/10;200/10];
% S2(23).Streams.Stream.Value=[F1/10;200/10];
% % S2(1).Streams.Stream.Value=f1';
% S2(1).Streams.Stream.WaterFlow=100;

% S2(1).Streams.Stream.WaterFlow=200;
% S2(1).Streams.Stream.Value=[F1/4;200/4];
% S2(12).Streams.Stream.Value=[F1/6;200/6];
% S2(16).Streams.Stream.Value=[F1/40;200/40];
wb = waitbar(0, 'Iterando');
wbch = allchild(wb);
jp = wbch(1).JavaPeer;
jp.setIndeterminate(1)
[X,NumIt,It_V,Error_V,Errorf,NodesF,SolverTime]=SOLVER2(OrderGroup,S2,Tol,MaxIt,Inc,MassTol);

% [X,NumIt,It_V,Error_V,Errorf,OrderGroup_]=SOLVERW(OrderGroup,S,Tol,MaxIt)
% [ErrorGlobal,ErrorEntradasSalidas,ErrorEntradasSalidasPorcentaje,Nodesf]=BalanceMasa(NodesF,S2,v);
[ErrorGlobalMasa,ErrorGlobalWater,ErrorEntradasSalidasMasa,ErrorEntradasSalidasW,ErrorEntradasSalidasPorcentajeMasa,ErrorEntradasSalidasPorcentajeW,ErrorGlobalPorcentual,Nodesf_,ErrorGlobal]=BalanceMasaW(NodesF,S2,v);
X=PostX(X);
X(1).Length=Ms(2);
SolverData=struct;
SolverData.NodesFisicos=Nodesf_;
SolverData.NodesMat=NodesF;
SolverData.NumIt=NumIt;
SolverData.Error_V=Error_V;
SolverData.It_V=It_V;
SolverData.Errorf=Errorf;
SolverData.ErrorGlobalMasa=ErrorGlobalMasa;
SolverData.ErrorGlobalWater=ErrorGlobalWater;
SolverData.ErrorEntradasSalidasMasa=ErrorEntradasSalidasMasa;
SolverData.ErrorEntradasSalidasW=ErrorEntradasSalidasW;
SolverData.ErrorEntradasSalidasPorcentajeMasa=ErrorEntradasSalidasPorcentajeMasa;
SolverData.ErrorEntradasSalidasPorcentajeW=ErrorEntradasSalidasPorcentajeW;
SolverData.ErrorGlobal=ErrorGlobal;
SolverData.ErrorGlobalPorcentual=ErrorGlobalPorcentual;
SolverData.Tol=Tol;
SolverData.MaxIt=MaxIt;
SolverData.Flujos=X;
% SolverData.SolverTime=SolverTime;
% end
[m,n]=size(v);
if m < n
    v=v';
end
delete(wb)
msgbox('Simulación terminada');
state= 1;
% end
