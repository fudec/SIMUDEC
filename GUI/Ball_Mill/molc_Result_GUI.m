function molc_Result_GUI(source,~)
global v Info OrderGroup X

if isempty(X(1).Length)
    Message='There are not results';
    exito = warndlg(Message);
    return
end

k = get_index(source);


for i = 1:length(OrderGroup)
        if Info(k).Node.Siweigth == OrderGroup(i).Nodes.Siweigth
            t = i;
        end
end

molc_Result_F=figure;

set(molc_Result_F,'numbertitle','off','menubar','none','name',Info(k).h.Tag);
set(molc_Result_F,'units','normalized');
molc_Result_F.Position=[0.2 0.2 0.6 0.6];
AX_ROD=axes(molc_Result_F,'units','normalized');
AX_ROD.Position=[0.1 0.1 0.7 0.8];
box(AX_ROD,'on');

PasanteIn = Pasante(OrderGroup(t).Nodes.Si{1}.Stream.Value(1:end-1));
PasanteOut = Pasante(OrderGroup(t).Nodes.So.Stream.Value(1:end-1));
semilogx(v,PasanteIn,v,PasanteOut);
legend('Input','Output')
xlabel('Size [um] (log)');
ylabel('Cumulative Passing [%]');
grid on

if ~isempty(v) 
    axis([0 v(1) 0 101]);
end
 
TPH = sum(OrderGroup(t).Nodes.Si{1}.Stream.Value(1:end));
F80_ = F80(OrderGroup(t).Nodes.Si{1}.Stream.Value(1:end-1),v);
P80 = F80(OrderGroup(t).Nodes.So.Stream.Value(1:end-1),v);
FW = OrderGroup(t).Nodes.So.Stream.Value(end);
grid on
Pxe=780;
Pxt=720;

TPHe=uicontrol(molc_Result_F,'style','text','string',TPH);
TPHe.Position = [Pxe 340 60 20];

TPHt=uicontrol(molc_Result_F,'style','text','string','TPH','FontSize',9);
TPHt.Position = [Pxt 340 60 20];

F80e=uicontrol(molc_Result_F,'style','text','string',F80_,'FontSize',9);
F80e.Position = [Pxe 320 60 20];

F80t=uicontrol(molc_Result_F,'style','text','string','F80','FontSize',9);
F80t.Position = [Pxt 320 60 20];

P80e=uicontrol(molc_Result_F,'style','text','string',P80,'FontSize',9);
P80e.Position = [Pxe 300 60 20];

P80t=uicontrol(molc_Result_F,'style','text','string','P80','FontSize',9);
P80t.Position = [Pxt 300 60 20];

FWe=uicontrol(molc_Result_F,'style','text','string',FW,'FontSize',9);
FWe.Position = [Pxe 280 60 20];

FWt=uicontrol(molc_Result_F,'style','text','string','Flujo W','FontSize',9);
FWt.Position = [Pxt 280 60 20];

Pe=uicontrol(molc_Result_F,'style','text','string',Info(k).Container.Potencia,'FontSize',9);
Pe.Position = [Pxe 260 60 20];

Pt=uicontrol(molc_Result_F,'style','text','string','Potencia','FontSize',9);
Pt.Position = [Pxt 260 60 20];
end