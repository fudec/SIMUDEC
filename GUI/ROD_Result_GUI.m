function ROD_Result_GUI(hObject,eventdata)
global v Info
k=hObject.UserData.c;
ROD_Result_F=figure;
set(ROD_Result_F,'numbertitle','off','menubar','none','name',Info(k).h.Tag);
set(ROD_Result_F,'units','normalized');
ROD_Result_F.Position=[0.2 0.2 0.6 0.6];
AX_ROD=axes(ROD_Result_F,'units','normalized');
AX_ROD.Position=[0.1 0.1 0.65 0.8];
box(AX_ROD,'on');
semilogx(v,Info(k).PasanteA,v,Info(k).PasanteP);
xlabel('Tamaño [um] (log)');
ylabel('Porcentaje Pasante [%]');
axis([0 v(1) 0 101]);
grid on
Pxe=710;
Pxt=650;
We=uicontrol(ROD_Result_F,'style','text','String',sprintf('%.2f',Info(k).W),'FontSize',9);
We.Position = [Pxe 380 60 20];

Wt=uicontrol(ROD_Result_F,'style','text','string','% Sólido','FontSize',9);
Wt.Position = [Pxt 380 70 20];

roe=uicontrol(ROD_Result_F,'style','text','string',sprintf('%.2f',Info(k).ro),'FontSize',9);
roe.Position = [Pxe 360 60 20];

rot=uicontrol(ROD_Result_F,'style','text','string','Densidad','FontSize',9);
rot.Position = [Pxt 360 60 20];

TPHe=uicontrol(ROD_Result_F,'style','text','string',sprintf('%.2f',Info(k).TPH),'FontSize',9);
TPHe.Position = [Pxe 340 60 20];

TPHt=uicontrol(ROD_Result_F,'style','text','string','TPH','FontSize',9);
TPHt.Position = [Pxt 340 60 20];

F80e=uicontrol(ROD_Result_F,'style','text','string',sprintf('%.2f',Info(k).F80),'FontSize',9);
F80e.Position = [Pxe 320 60 20];

F80t=uicontrol(ROD_Result_F,'style','text','string','F80','FontSize',9);
F80t.Position = [Pxt 320 60 20];

P80e=uicontrol(ROD_Result_F,'style','text','string',sprintf('%.2f',Info(k).P80),'FontSize',9);
P80e.Position = [Pxe 300 60 20];

P80t=uicontrol(ROD_Result_F,'style','text','string','P80','FontSize',9);
P80t.Position = [Pxt 300 60 20];

FWe=uicontrol(ROD_Result_F,'style','text','string',sprintf('%.2f',Info(k).FW),'FontSize',9);
FWe.Position = [Pxe 280 60 20];

FWt=uicontrol(ROD_Result_F,'style','text','string','Flujo W','FontSize',9);
FWt.Position = [Pxt 280 60 20];

Pe=uicontrol(ROD_Result_F,'style','text','string',sprintf('%.2f',Info(k).FW),'FontSize',9);
Pe.Position = [Pxe 260 60 20];

Pt=uicontrol(ROD_Result_F,'style','text','string','Potencia','FontSize',9);
Pt.Position = [Pxt 260 60 20];
end