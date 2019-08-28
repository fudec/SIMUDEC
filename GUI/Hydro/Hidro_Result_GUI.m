function Hidro_Result_GUI(source,~)
global v Info X

if isempty(X(1).Length)
    Message='There are not results';
    exito = warndlg(Message);
    return
end

k = get_index(source);

getappdata(source,'Index')
HIDRO_Result_F=figure;
set(HIDRO_Result_F,'numbertitle','off','menubar','none','name',Info(k).h.Tag);
set(HIDRO_Result_F,'units','normalized');
HIDRO_Result_F.Position=[0.2 0.2 0.6 0.6];
AX_ROD=axes(HIDRO_Result_F,'units','normalized');
AX_ROD.Position=[0.1 0.1 0.65 0.8];
box(AX_ROD,'on');

PasanteIn = Pasante(Info(k).Node.Si{1}.Stream.Value(1:end-1));
PasanteDescarga = Pasante(Info(k).Node.So(1).Stream.Value(1:end-1));
PasanteRebalse  = Pasante(Info(k).Node.So(2).Stream.Value(1:end-1));


semilogx(v,PasanteIn,v,PasanteRebalse,v,PasanteDescarga);
legend('Input','Overflow','Discharge');
xlabel('Size [um] (log)');
ylabel('Cumulative Passing [%]');
axis([0 v(1) 0 101]);
grid on
Pxe=710;
Pxt=650;

d50=uicontrol(HIDRO_Result_F,'style','text','String',sprintf('%.2f',Info(k).Container.d50),'FontSize',9);
d50.Position = [Pxe 380 60 20];

d50=uicontrol(HIDRO_Result_F,'style','text','string','% S�lido','FontSize',9);
d50.Position = [Pxt 380 70 20];

roe=uicontrol(HIDRO_Result_F,'style','text','string',sprintf('%.2f',Info(k).ro),'FontSize',9);
roe.Position = [Pxe 360 60 20];

rot=uicontrol(HIDRO_Result_F,'style','text','string','Densidad','FontSize',9);
rot.Position = [Pxt 360 60 20];

TPHe=uicontrol(HIDRO_Result_F,'style','text','string',sprintf('%.2f',Info(k).TPH),'FontSize',9);
TPHe.Position = [Pxe 340 60 20];

TPHt=uicontrol(HIDRO_Result_F,'style','text','string','TPH','FontSize',9);
TPHt.Position = [Pxt 340 60 20];

F80e=uicontrol(HIDRO_Result_F,'style','text','string',sprintf('%.2f',Info(k).F80),'FontSize',9);
F80e.Position = [Pxe 320 60 20];

F80t=uicontrol(HIDRO_Result_F,'style','text','string','F80','FontSize',9);
F80t.Position = [Pxt 320 60 20];

P80e=uicontrol(HIDRO_Result_F,'style','text','string',sprintf('%.2f',Info(k).P80),'FontSize',9);
P80e.Position = [Pxe 300 60 20];

P80t=uicontrol(HIDRO_Result_F,'style','text','string','P80','FontSize',9);
P80t.Position = [Pxt 300 60 20];

FWe=uicontrol(HIDRO_Result_F,'style','text','string',sprintf('%.2f',Info(k).FW),'FontSize',9);
FWe.Position = [Pxe 280 60 20];

FWt=uicontrol(HIDRO_Result_F,'style','text','string','Flujo W','FontSize',9);
FWt.Position = [Pxt 280 60 20];

d50e=uicontrol(HIDRO_Result_F,'style','text','string',Info(k).Container.d50,'FontSize',9);
d50e.Position = [Pxe 260 60 20];

d50t=uicontrol(HIDRO_Result_F,'style','text','string','d50 [mm]','FontSize',9);
d50t.Position = [Pxt 260 60 20];

end