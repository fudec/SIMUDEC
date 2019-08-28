function ModSAG1(x)
global Info



figure_modelo_c=figure;
figure_modelo_c.Position=[400 150 550 450];
set(figure_modelo_c,'numbertitle','off','menubar','none','name',Info(x).tag2)
set(figure_modelo_c,'resize','off')
              %%%%%% Scale %%%%%%
            

scale_bgI= uibuttongroup(figure_modelo_c,...
                  'Title','Original',...
                  'Position', [0 0 0.5 1]);
              
      %%%%%%%% Diametro
Px=95;
Diametroy=100;
DiametroxT=10;

editbox_D_ori=uicontrol(scale_bgI,'style','edit');
editbox_D_ori.Position = [Px Diametroy 30 15];

Diametro_textI=uicontrol(scale_bgI,'style','text','string','Di�metro');
Diametro_textI.Position = [DiametroxT Diametroy 50 15];            
              
   %%%%%%%%%% Largo
              
Largoy=85;
LargoxT=1;

editbox_Largo_ori=uicontrol(scale_bgI,'style','edit');
editbox_Largo_ori.Position = [Px Largoy 30 15];

Largo_textI=uicontrol(scale_bgI,'style','text','string','Largo');
Largo_textI.Position = [LargoxT Largoy 55 15];


%%%%%%%%%%%% CS

CSy=70;
CSxT=4;

editbox_CS_ori=uicontrol(scale_bgI,'style','edit');
editbox_CS_ori.Position = [Px CSy 30 15];

CS_textI=uicontrol(scale_bgI,'style','text','string','Fracci�n VC');
CS_textI.Position = [CSxT CSy 80 15];

%%%%%%%%%%%%% FL

FLy=55;
FLxT=1;

editbox_FL_ori=uicontrol(scale_bgI,'style','edit');
editbox_FL_ori.Position = [Px FLy 30 15];

FL_textI=uicontrol(scale_bgI,'style','text','string','Fracci�n Ll');
FL_textI.Position = [FLxT FLy 80 15];

%%%%%%%%%%%%%% WI

WIy=40;
WIxT=1;

editbox_WI_ori=uicontrol(scale_bgI,'style','edit');
editbox_WI_ori.Position = [Px WIy 30 15];

WI_textI=uicontrol(scale_bgI,'style','text','string','WI');
WI_textI.Position = [WIxT WIy 40 15];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

scale_bgD= uibuttongroup(figure_modelo_c,...
                  'Title','Simulado',...
                  'Position', [0.5 0 1 1]);

              %%%% Di�metro %%%%%%%%%%

editbox_D_sim=uicontrol(scale_bgD,'style','edit');
editbox_D_sim.Position = [Px Diametroy 30 15];

Diametro_textD=uicontrol(scale_bgD,'style','text','string','Di�metro');
Diametro_textD.Position = [DiametroxT Diametroy 50 15];

% %%%%%%%%%%%% Largo %%%%%%%%%%%%%%%%%%



editbox_Largo_sim=uicontrol(scale_bgD,'style','edit');
editbox_Largo_sim.Position = [Px Largoy 30 15];


Largo_textD=uicontrol(scale_bgD,'style','text','string','Largo');
Largo_textD.Position = [LargoxT Largoy 55 15];

% %%%%%%%%%%%% Cs %%%%%%%%%%%%%%%%%%


editbox_CS_sim=uicontrol(scale_bgD,'style','edit');
editbox_CS_sim.Position = [Px CSy 30 15];

CS_textD=uicontrol(scale_bgD,'style','text','string','Fracci�n VC');
CS_textD.Position = [CSxT CSy 80 15];

%%%%%%%%%%%%% FL %%%%%%%%%%%%%%%%%%


editbox_FL_sim=uicontrol(scale_bgD,'style','edit');
editbox_FL_sim.Position = [Px FLy 30 15];

FL_textD=uicontrol(scale_bgD,'style','text','string','Fracci�n Ll');
FL_textD.Position = [FLxT FLy 80 15];

%%%%%%%%%%%%% WI %%%%%%%%%%%%%%%%%%


editbox_WI_sim=uicontrol(scale_bgD,'style','edit');
editbox_WI_sim.Position = [Px WIy 30 15];

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

Kn1_edit=uicontrol(si_bg,'style','edit');
Kn1_edit.Position = [Px-PxKn Kn1y 30 15];

Kn1_textD=uicontrol(si_bg,'style','text','string','Ln R/D*');
Kn1_textD.Position = [Kn1x+Knx Kn1y 80 15];

Kn1_editD=uicontrol(si_bg,'style','edit');
Kn1_editD.Position = [Px+PxKn2 Kn1y 30 15];
%%%%%%%%%%%%%%%%% Kn 2 %%%%%%%%%%%%%
Kn2y=60;
Kn2x=1;

Kn2_text=uicontrol(si_bg,'style','text','string','Kn#2');
Kn2_text.Position = [Kn2x Kn2y 80 15];

Kn2_edit=uicontrol(si_bg,'style','edit');
Kn2_edit.Position = [Px-PxKn Kn2y 30 15];

Kn2_textD=uicontrol(si_bg,'style','text','string','Ln R/D*');
Kn2_textD.Position = [Kn2x+Knx Kn2y 80 15];

Kn2_editD=uicontrol(si_bg,'style','edit');
Kn2_editD.Position = [Px+PxKn2 Kn2y 30 15];
%%%%%%%%%%%%% Kn 3 %%%%%%%%%%%%5
Kn3y=45;
Kn3x=1;

Kn3_text=uicontrol(si_bg,'style','text','string','Kn#3');
Kn3_text.Position = [Kn3x Kn3y 80 15];

Kn3_edit=uicontrol(si_bg,'style','edit');
Kn3_edit.Position = [Px-PxKn Kn3y 30 15];

Kn3_textD=uicontrol(si_bg,'style','text','string','Ln R/D*');
Kn3_textD.Position = [Kn3x+Knx Kn3y 80 15];

Kn3_editD=uicontrol(si_bg,'style','edit');
Kn3_editD.Position = [Px+PxKn2 Kn3y 30 15];

%%%%%%%%%%%%% Kn 4 %%%%%%%%%%%%5
Kn4y=30;
Kn4x=1;

Kn4_text=uicontrol(si_bg,'style','text','string','Kn#4');
Kn4_text.Position = [Kn4x Kn4y 80 15];

Kn4_edit=uicontrol(si_bg,'style','edit');
Kn4_edit.Position = [Px-PxKn Kn4y 30 15];

Kn4_textD=uicontrol(si_bg,'style','text','string','Ln R/D*');
Kn4_textD.Position = [Kn4x+Knx Kn4y 80 15];

Kn4_editD=uicontrol(si_bg,'style','edit');
Kn4_editD.Position = [Px+PxKn2 Kn4y 30 15];
%%%%%%%%%% EScalamiento bolas %%%%%%%%%5

si_bg= uibuttongroup(figure_modelo_c,...
                  'Title','Escalamiento Bolas',...
                  'Position', [0.1 0.15 0.4 0.2]);
 
%%%%%%%%%%%%%%% Ball top Ori %%%%%%%%%%%%%%%%%%%%%%
BtOx=5;
BtOy=45;

Balltop_text=uicontrol(si_bg,'style','text','string','Ball Top Ori.');
Balltop_text.Position = [BtOx BtOy 75 15];

Balltop_edit=uicontrol(si_bg,'style','edit');
Balltop_edit.Position = [Px BtOy 30 15];

%%%%%%%%%%%%%%% Ball top Sim %%%%%%%%%%%%%%%%%%%%%%
BtSx=4;
BtSy=30;

Balltop_text=uicontrol(si_bg,'style','text','string','Ball Top Sim.');
Balltop_text.Position = [BtSx BtSy 80 15];

Balltop_edit=uicontrol(si_bg,'style','edit');
Balltop_edit.Position = [Px BtSy 30 15];

%%%%%%%%%%%%%%% Breakage Factor %%%%%%%%%%%%%%%%%%%%%%
BRx=6;
BRy=15;

Balltop_text=uicontrol(si_bg,'style','text','string','Breakage Fac.');
Balltop_text.Position = [BRx BRy 85 15];

Balltop_edit=uicontrol(si_bg,'style','edit');
Balltop_edit.Position = [Px BRy 30 15];

%%%%%%%%%%%%%%% Appereance %%%%%%%%%%%%
P_bg= uibuttongroup(figure_modelo_c,...
                  'Title','Funci�n Distribuci�n Fractura',...
                  'Position', [0.5 0.35 0.4 0.25]);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
cerrar_mo1 = uicontrol('Parent',figure_modelo_c,...
           'Style','push',...
           'Position',[150 10 100 25],...
           'String','Cerrar',...
           'Callback',@cerrar);
aceptar_mo1=uicontrol;
editbox_Pa_ori.UserData=x;
% aceptar_mo1.UserData=[editbox_Pa_ori editbox_D_sim editbox_D_ori editbox_Largo_sim editbox_Largo_ori...
%     editbox_CS_sim editbox_CS_ori editbox_FL_sim editbox_FL_ori editbox_WI_sim editbox_WI_ori Kn1_edit Kn2_edit Kn3_edit];

 set(aceptar_mo1,'Parent',figure_modelo_c,...
           'Style','push',...
           'Position',[5 10 100 25],...
           'String','Guardar',...
           'Callback',@getPMC1);
     
waitfor(figure_modelo_c)
end