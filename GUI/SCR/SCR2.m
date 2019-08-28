function SCR2(x)
global Info

figure_modelo_c=figure;
figure_modelo_c.Position=[400 150 550 450];

k = x;
set(figure_modelo_c,'numbertitle','off','menubar','none','name',Info(k).tag2)
set(figure_modelo_c,'resize','off')
              %%%%%% Scale %%%%%%
            
scale_bg= uibuttongroup(figure_modelo_c,...
                  'Title','Escalamiento',...
                  'Position', [0.1 0.6 0.8 0.35]);

scale_bgI= uibuttongroup(scale_bg,...
                  'Title','Original',...
                  'Position', [0 0 0.5 1]);
              
scale_bgD= uibuttongroup(scale_bg,...
                  'Title','Simulado',...
                  'Position', [0.5 0 1 1]);
Px=95;

              %%%% Di�metro %%%%%%%%%%
Diametroy=100;
DiametroxT=10;

editbox_D_sim=uicontrol(scale_bgD,'style','edit','string',3.23);
editbox_D_sim.Position = [Px Diametroy 30 15];

editbox_D_ori=uicontrol(scale_bgI,'style','edit','string',3.23);
editbox_D_ori.Position = [Px Diametroy 30 15];

Diametro_textI=uicontrol(scale_bgI,'style','text','string','Diámetro');
Diametro_textI.Position = [DiametroxT Diametroy 50 15];

Diametro_textD=uicontrol(scale_bgD,'style','text','string','Diámetro');
Diametro_textD.Position = [DiametroxT Diametroy 50 15];

% %%%%%%%%%%%% Largo %%%%%%%%%%%%%%%%%%

Largoy=85;
LargoxT=1;

editbox_Largo_sim=uicontrol(scale_bgD,'style','edit','string',4.57);
editbox_Largo_sim.Position = [Px Largoy 30 15];

editbox_Largo_ori=uicontrol(scale_bgI,'style','edit','string',4.57);
editbox_Largo_ori.Position = [Px Largoy 30 15];

Largo_textI=uicontrol(scale_bgI,'style','text','string','Largo');
Largo_textI.Position = [LargoxT Largoy 55 15];

Largo_textD=uicontrol(scale_bgD,'style','text','string','Largo');
Largo_textD.Position = [LargoxT Largoy 55 15];

% %%%%%%%%%%%% Cs %%%%%%%%%%%%%%%%%%

CSy=70;
CSxT=4;
editbox_CS_sim=uicontrol(scale_bgD,'style','edit','string',0.75);
editbox_CS_sim.Position = [Px CSy 30 15];

editbox_CS_ori=uicontrol(scale_bgI,'style','edit','string',0.75);
editbox_CS_ori.Position = [Px CSy 30 15];

CS_textI=uicontrol(scale_bgI,'style','text','string','Fracción VC');
CS_textI.Position = [CSxT CSy 80 15];

CS_textD=uicontrol(scale_bgD,'style','text','string','Fracción VC');
CS_textD.Position = [CSxT CSy 80 15];

%%%%%%%%%%%%% FL %%%%%%%%%%%%%%%%%%

FLy=55;
FLxT=1;

editbox_FL_sim=uicontrol(scale_bgD,'style','edit','string',0.336);
editbox_FL_sim.Position = [Px FLy 30 15];

editbox_FL_ori=uicontrol(scale_bgI,'style','edit','string',0.336);
editbox_FL_ori.Position = [Px FLy 30 15];

FL_textI=uicontrol(scale_bgI,'style','text','string','Fracción Ll');
FL_textI.Position = [FLxT FLy 80 15];

FL_textD=uicontrol(scale_bgD,'style','text','string','Fracción Ll');
FL_textD.Position = [FLxT FLy 80 15];

%%%%%%%%%%%%% WI %%%%%%%%%%%%%%%%%%

WIy=40;
WIxT=1;
editbox_WI_sim=uicontrol(scale_bgD,'style','edit','string',20);
editbox_WI_sim.Position = [Px WIy 30 15];

editbox_WI_ori=uicontrol(scale_bgI,'style','edit','string',20);
editbox_WI_ori.Position = [Px WIy 30 15];

WI_textI=uicontrol(scale_bgI,'style','text','string','WI');
WI_textI.Position = [WIxT WIy 40 15];

WI_textD=uicontrol(scale_bgD,'style','text','string','WI');
WI_textD.Position = [WIxT WIy 40 15];
%%%%%%%%%% Selection %%%%%%%%%5
si_bg= uibuttongroup(figure_modelo_c,...
                  'Title','R/D',...
                  'Position', [0.1 0.35 0.4 0.25]);
%%%%%%%%%%%%%%% Kn 1 %%%%%%%%%%%%%%%%%%%
Kn1y=75;
Kn1x=1;
PxKn=35;

Knx=90;
PxKn2=70;

Kn1_text=uicontrol(si_bg,'style','text','string','Kn#1');
Kn1_text.Position = [Kn1x Kn1y 80 15];

Kn1_edit=uicontrol(si_bg,'style','edit','string',0.09);
Kn1_edit.Position = [Px-PxKn Kn1y 30 15];

Kn1_textD=uicontrol(si_bg,'style','text','string','Ln R/D*');
Kn1_textD.Position = [Kn1x+Knx Kn1y 80 15];

Kn1_editD=uicontrol(si_bg,'style','edit','string',0.827);
Kn1_editD.Position = [Px+PxKn2 Kn1y 30 15];
%%%%%%%%%%%%%%%%% Kn 2 %%%%%%%%%%%%%
Kn2y=60;
Kn2x=1;

Kn2_text=uicontrol(si_bg,'style','text','string','Kn#2');
Kn2_text.Position = [Kn2x Kn2y 80 15];

Kn2_edit=uicontrol(si_bg,'style','edit','string',0.45);
Kn2_edit.Position = [Px-PxKn Kn2y 30 15];

Kn2_textD=uicontrol(si_bg,'style','text','string','Ln R/D*');
Kn2_textD.Position = [Kn2x+Knx Kn2y 80 15];

Kn2_editD=uicontrol(si_bg,'style','edit','string',1.5);
Kn2_editD.Position = [Px+PxKn2 Kn2y 30 15];
%%%%%%%%%%%%% Kn 3 %%%%%%%%%%%%5
Kn3y=45;
Kn3x=1;

Kn3_text=uicontrol(si_bg,'style','text','string','Kn#3');
Kn3_text.Position = [Kn3x Kn3y 80 15];

Kn3_edit=uicontrol(si_bg,'style','edit','string',2.5);
Kn3_edit.Position = [Px-PxKn Kn3y 30 15];

Kn3_textD=uicontrol(si_bg,'style','text','string','Ln R/D*');
Kn3_textD.Position = [Kn3x+Knx Kn3y 80 15];

Kn3_editD=uicontrol(si_bg,'style','edit','string',3.41);
Kn3_editD.Position = [Px+PxKn2 Kn3y 30 15];

%%%%%%%%%%%%% Kn 4 %%%%%%%%%%%%5
Kn4y=30;
Kn4x=1;

Kn4_text=uicontrol(si_bg,'style','text','string','Kn#4');
Kn4_text.Position = [Kn4x Kn4y 80 15];

Kn4_edit=uicontrol(si_bg,'style','edit','string',12);
Kn4_edit.Position = [Px-PxKn Kn4y 30 15];

Kn4_textD=uicontrol(si_bg,'style','text','string','Ln R/D*');
Kn4_textD.Position = [Kn4x+Knx Kn4y 80 15];

Kn4_editD=uicontrol(si_bg,'style','edit','string',1);
Kn4_editD.Position = [Px+PxKn2 Kn4y 30 15];
%%%%%%%%%% EScalamiento bolas %%%%%%%%%5

si_bg= uibuttongroup(figure_modelo_c,...
                  'Title','Escalamiento Bolas',...
                  'Position', [0.1 0.15 0.4 0.2]);
 
%%%%%%%%%%%%%%% Ball top Ori %%%%%%%%%%%%%%%%%%%%%%
BtOx=5;
BtOy=45;

Balltop_text_ori=uicontrol(si_bg,'style','text','string','Ball Top Ori.');
Balltop_text_ori.Position = [BtOx BtOy 75 15];

Balltop_edit_ori=uicontrol(si_bg,'style','edit','string',75);
Balltop_edit_ori.Position = [Px BtOy 30 15];

%%%%%%%%%%%%%%% Ball top Sim %%%%%%%%%%%%%%%%%%%%%%
BtSx=4;
BtSy=30;

Balltop_text_sim=uicontrol(si_bg,'style','text','string','Ball Top Sim.');
Balltop_text_sim.Position = [BtSx BtSy 80 15];

Balltop_edit_sim=uicontrol(si_bg,'style','edit','string',75);
Balltop_edit_sim.Position = [Px BtSy 30 15];

%%%%%%%%%%%%%%% Breakage Factor %%%%%%%%%%%%%%%%%%%%%%
BRx=6;
BRy=15;

Breakage_factor_text=uicontrol(si_bg,'style','text','string','Breakage Fac.');
Breakage_factor_text.Position = [BRx BRy 80 15];

Breakage_factor_edit=uicontrol(si_bg,'style','edit','string',4.4e-4);
Breakage_factor_edit.Position = [Px BRy 100 15];

%%%%%%%%%%%%%%% Appereance %%%%%%%%%%%%
P_bg= uibuttongroup(figure_modelo_c,...
                  'Title','Función Distribución Fractura',...
                  'Position', [0.5 0.35 0.4 0.25]);

t10_text=uicontrol(P_bg,'style','text','string','t10');
t10_text.Position = [10 70 50 15];

editbox_t10=uicontrol(P_bg,'style','edit','string',13);
editbox_t10.Position = [95 70 30 15];

gamma_text=uicontrol(P_bg,'style','text','string','gamma');
gamma_text.Position = [20 55 50 15];

editbox_gamma=uicontrol(P_bg,'style','edit','string',0);
editbox_gamma.Position = [95 55 30 15];

beta_text=uicontrol(P_bg,'style','text','string','beta');
beta_text.Position = [10 40 50 15];

editbox_beta=uicontrol(P_bg,'style','edit','string',0);
editbox_beta.Position = [95 40 30 15];

phi_text=uicontrol(P_bg,'style','text','string','phi');
phi_text.Position = [10 25 50 15];

editbox_phi=uicontrol(P_bg,'style','edit','string',0);
editbox_phi.Position = [95 25 30 15];

load_matrix_Button=uicontrol(P_bg,'style','push','string','Cargar Matriz Fractura','Callback',@cargar_v,...
                 'position',[25,1,150,20]);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
cerrar_mo1 = uicontrol('Parent',figure_modelo_c,...
           'Style','push',...
           'Position',[150 10 100 25],...
           'String','Cerrar',...
           'Callback',@cerrar);
       
    aceptar_mo1=uicontrol;
    editbox_D_sim.UserData=k;
    aceptar_mo1.UserData=[editbox_D_sim editbox_D_ori editbox_Largo_sim editbox_Largo_ori...
    editbox_CS_sim editbox_CS_ori editbox_FL_sim editbox_FL_ori editbox_WI_sim editbox_WI_ori...
    Kn1_edit Kn1_editD Kn2_edit Kn2_editD Kn3_edit Kn3_editD Kn4_edit Kn4_editD Balltop_edit_sim Balltop_edit_ori Breakage_factor_edit];

set(aceptar_mo1,'Parent',figure_modelo_c,...
           'Style','push',...
           'Position',[5 10 100 25],...
           'String','Guardar',...
           'Callback',@getPMC1);
     
waitfor(figure_modelo_c)
end