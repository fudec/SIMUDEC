function Solver_Result(hObject,~)
global v Info SolverData

if isempty(SolverData)
    wrnbox=warndlg('Missing Solver Data','Warning');
    return
end

ErrorVector=SolverData.Error_V;
ItVector=SolverData.It_V;
It=max(ItVector);

Solver_Resultf=figure;
set(Solver_Resultf,'numbertitle','off','menubar','none','name','Solver Results');
set(Solver_Resultf,'units','normalized');
Solver_Resultf.Position=[0.2 0.2 0.6 0.6];
AX_Solver=axes(Solver_Resultf,'units','normalized');
AX_Solver.Position=[0.1 0.1 0.65 0.8];
box(AX_Solver,'on');
if It == 2
    It = 1;
    plot(ItVector,ErrorVector,'-r');
elseif It > 2
    semilogy(ItVector,ErrorVector,'-r');
end
xlabel('Iteration');
ylabel('Error');
grid on
Pxv=710;
Pxt=650;

Iteracionest=uicontrol(Solver_Resultf,'style','text','string','Iterations','FontSize',9);
Iteracionest.Position = [Pxt 380 90 20];

Iteracionesv=uicontrol(Solver_Resultf,'style','text','string',sprintf('%d',It),'FontSize',9);
Iteracionesv.Position = [Pxv 380 70 20];
end