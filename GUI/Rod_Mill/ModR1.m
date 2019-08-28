function ModR1(x)
global Info

figure_modelo_rod=figure;
figure_modelo_rod.Position=[400 150 550 450];
set(figure_modelo_rod,'numbertitle','off','menubar','none','name',Info(x).tag2)
set(figure_modelo_rod,'resize','off')

              %%%%%% Scale %%%%%%
            
scale_bg= uibuttongroup(figure_modelo_rod,...
                  'Title','Escalamiento',...
                  'Position', [0.1 0.5 0.8 0.35]);

scale_bgI= uibuttongroup(scale_bg,...
                  'Title','Original',...
                  'Position', [0 0 0.5 1]);
              
scale_bgD= uibuttongroup(scale_bg,...
                  'Title','Simulado',...
                  'Position', [0.5 0 1 1]);
Px=95;
%%%%%%%%%% 90% Pasante &%%%%%%%%%%

Pay=25;
PaxT=6;

Pa_textI=uicontrol(scale_bgI,'style','text','string','90% Pasante');
Pa_textI.Position = [PaxT Pay 80 15];

editbox_Pa_ori=uicontrol(scale_bgI,'style','edit');
editbox_Pa_ori.Position = [Px Pay 30 15];
%%%%%% Mill constant %%%%%
MCy=10;
MCxT=1;

MC_textI=uicontrol(scale_bgI,'style','text','string','MC');
MC_textI.Position = [MCxT MCy 42 15];

editbox_MC_ori=uicontrol(scale_bgI,'style','edit');
editbox_MC_ori.Position = [Px MCy 30 15];

              %%%% Di�metro %%%%%%%%%%
Diametroy=100;
DiametroxT=10;
editbox_D_sim=uicontrol(scale_bgD,'style','edit');
editbox_D_sim.Position = [Px Diametroy 30 15];

editbox_D_ori=uicontrol(scale_bgI,'style','edit');
editbox_D_ori.Position = [Px Diametroy 30 15];

Diametro_textI=uicontrol(scale_bgI,'style','text','string','Di�metro');
Diametro_textI.Position = [DiametroxT Diametroy 50 15];

Diametro_textD=uicontrol(scale_bgD,'style','text','string','Di�metro');
Diametro_textD.Position = [DiametroxT Diametroy 50 15];

% %%%%%%%%%%%% Largo %%%%%%%%%%%%%%%%%%

Largoy=85;
LargoxT=1;

editbox_Largo_sim=uicontrol(scale_bgD,'style','edit');
editbox_Largo_sim.Position = [Px Largoy 30 15];

editbox_Largo_ori=uicontrol(scale_bgI,'style','edit');
editbox_Largo_ori.Position = [Px Largoy 30 15];

Largo_textI=uicontrol(scale_bgI,'style','text','string','Largo');
Largo_textI.Position = [LargoxT Largoy 55 15];

Largo_textD=uicontrol(scale_bgD,'style','text','string','Largo');
Largo_textD.Position = [LargoxT Largoy 55 15];

% %%%%%%%%%%%% Cs %%%%%%%%%%%%%%%%%%

CSy=70;
CSxT=4;
editbox_CS_sim=uicontrol(scale_bgD,'style','edit');
editbox_CS_sim.Position = [Px CSy 30 15];

editbox_CS_ori=uicontrol(scale_bgI,'style','edit');
editbox_CS_ori.Position = [Px CSy 30 15];

CS_textI=uicontrol(scale_bgI,'style','text','string','Fracci�n VC');
CS_textI.Position = [CSxT CSy 80 15];

CS_textD=uicontrol(scale_bgD,'style','text','string','Fracci�n VC');
CS_textD.Position = [CSxT CSy 80 15];

%%%%%%%%%%%%% FL %%%%%%%%%%%%%%%%%%

FLy=55;
FLxT=1;
editbox_FL_sim=uicontrol(scale_bgD,'style','edit');
editbox_FL_sim.Position = [Px FLy 30 15];

editbox_FL_ori=uicontrol(scale_bgI,'style','edit');
editbox_FL_ori.Position = [Px FLy 30 15];

FL_textI=uicontrol(scale_bgI,'style','text','string','Fracci�n Ll');
FL_textI.Position = [FLxT FLy 80 15];

FL_textD=uicontrol(scale_bgD,'style','text','string','Fracci�n Ll');
FL_textD.Position = [FLxT FLy 80 15];

%%%%%%%%%%%%% WI %%%%%%%%%%%%%%%%%%

WIy=40;
WIxT=1;
editbox_WI_sim=uicontrol(scale_bgD,'style','edit');
editbox_WI_sim.Position = [Px WIy 30 15];

editbox_WI_ori=uicontrol(scale_bgI,'style','edit');
editbox_WI_ori.Position = [Px WIy 30 15];

WI_textI=uicontrol(scale_bgI,'style','text','string','WI');
WI_textI.Position = [WIxT WIy 40 15];

WI_textD=uicontrol(scale_bgD,'style','text','string','WI');
WI_textD.Position = [WIxT WIy 40 15];
%%%%%%%%%% Selection %%%%%%%%%5
si_bg= uibuttongroup(figure_modelo_rod,...
                  'Title','Selection',...
                  'Position', [0.1 0.2 0.4 0.25]);
%%%%%%%%%%%%%%% XC %%%%%%%%%%%%%%%%%%%
XCy=75;
XCxT=10;

XC_textI=uicontrol(si_bg,'style','text','string','XC');
XC_textI.Position = [XCxT XCy 80 15];

editbox_XC=uicontrol(si_bg,'style','edit');
editbox_XC.Position = [Px XCy 30 15];

%%%%%%%%%%%%%%%%% SI %%%%%%%%%%%%%
SIy=60;
SIxT=10;

SI_textI=uicontrol(si_bg,'style','text','string','SI');
SI_textI.Position = [SIxT SIy 80 15];

editbox_SI=uicontrol(si_bg,'style','edit');
editbox_SI.Position = [Px SIy 30 15];
%%%%%%%%%%%%% IN %%%%%%%%%%%%5
INy=45;
INxT=10;

IN_textI=uicontrol(si_bg,'style','text','string','IN');
IN_textI.Position = [INxT INy 80 15];

editbox_IN=uicontrol(si_bg,'style','edit');
editbox_IN.Position = [Px INy 30 15];

%%%%%%%%%%%%%%% Potencia %%%%%%%%%%%%
P_bg= uibuttongroup(figure_modelo_rod,...
                  'Title','Potencia',...
                  'Position', [0.5 0.2 0.4 0.25]);
%%%%%%%%%%%%%% Vr %%%%%%%%%%%%%

Vry=75;
VrxT=10;

Vr_textI=uicontrol(P_bg,'style','text','string','Vr');
Vr_textI.Position = [VrxT Vry 80 15];

editbox_Vr=uicontrol(P_bg,'style','edit','string','0');
editbox_Vr.Position = [Px Vry 30 15];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
cerrar_mo1 = uicontrol('Parent',figure_modelo_rod,...
           'Style','push',...
           'Position',[150 10 100 25],...
           'String','Cerrar',...
           'Callback',@cerrar);
       
aceptar_mo1=uicontrol;
Index=x;
aceptar_mo1.UserData=[Index editbox_Pa_ori editbox_MC_ori editbox_D_sim editbox_D_ori editbox_Largo_sim editbox_Largo_ori... %%%Mover +1
    editbox_CS_sim editbox_CS_ori editbox_FL_sim editbox_FL_ori editbox_WI_sim editbox_WI_ori editbox_XC editbox_SI editbox_IN editbox_Vr];

 set(aceptar_mo1,'Parent',figure_modelo_rod,...
           'Style','push',...
           'Position',[5 10 100 25],...
           'String','Guardar',...
           'Callback',@getPMR1);
     
waitfor(figure_modelo_rod)
end