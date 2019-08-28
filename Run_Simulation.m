%  function Run_Simulation(~,~)
global v  X  cu S2 SolverData MaxIt Tol state Info OrderGroup

MassTol=1e-5;

[B,S,M,A,Adj,Inc,Ms,flag]=PREPROCESO(cu);

if flag == 1
    return
end

[OrderGroup,S2,TYPTime]=AlDefV2(B,S,M);
[OrderGroup,flag]=Info_Connexion2(OrderGroup);
if flag == 1
    return
end

wb = waitbar(0, 'Iterando');
wbch = allchild(wb);
jp = wbch(1).JavaPeer;
jp.setIndeterminate(1)
[X,NumIt,It_V,Error_V,Errorf,NodesF,SolverTime]=SOLVER2(OrderGroup,S2,Tol,MaxIt,Inc,MassTol);

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
 SolverData.SolverTime=SolverTime;
% end
[m,n]=size(v);
if m < n
    v=v';
end
delete(wb)
msgbox('Simulación terminada');
state= 1;
% end
