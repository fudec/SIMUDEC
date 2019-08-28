global h a b Colora r  TagIdentifier RC_text Resultados_Flujos G cumsag cuscr  Colorf wcunt cuch

addpath('General')
addpath('Preprocess')
addpath('Postprocess')
addpath('Classes')
addpath('Solver')
addpath(genpath('GUI'))
addpath(genpath('Models'))

clf
%%%%%% Figura
h=figure(1);
a=1366;
b=1280;
Colorf=[231 237 240];
Colorf=Colorf./255;
set(h,'name','Comminution Simulator','numbertitle','off','Units','Normalized','Position', [0,0,1,1],'menubar','none','units','normalized',...
    'Color',Colorf)

global  axesgnu
Colora=[246 243 243];
Colora=Colora./255;

%%%%%%%%%% Ejes
%[0.043,0.03,0.95,0.95]
axesgnu=axes(h,'Position',[0.043,0.03,0.95,0.95],'XGrid','on','YGrid','on','Box','on','Color','White');

set(axesgnu,'xtick',[],'ytick',[])
set(h,'CurrentAxes',axesgnu)
%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%% Buttons %%%%%%%%%%%%%%%%5

Flujos_Group_Group_image=imread('Flujo.jpg');
Flujos_Group_image=imresize(Flujos_Group_Group_image, [40 40]);
Flujos_Group_B=uicontrol(h,'style','push','Callback',@Flujos_Group,...
                 'position',[10,430,40,40],'TooltipString','Streams','CData',Flujos_Group_image,'BackgroundColor','white');

Chancado_Group_image=imread('Chancador_ico.png');
Chancado_Group_image=imresize(Chancado_Group_image, [40 40]);
Chancado_Group_B=uicontrol(h,'style','push','Callback',@Chancado_Group,...
                 'position',[10,530,40,40],'TooltipString','Crushing','CData',Chancado_Group_image,'BackgroundColor','white');             

Molienda_Group_image=imread('Molinoc_ico.jpg');     
Molienda_Group_image=imresize(Molienda_Group_image, [40 40]);
Molienda_Group_B=uicontrol(h,'style','push','Callback',@Molienda_Group,...
                 'position',[10,480,40,40],'TooltipString','Grinding','CData',Molienda_Group_image,'BackgroundColor','white');

Clasificacion_Group_image=imread('HidroI_ico.jpg');    
Clasificacion_Group_image=imresize(Clasificacion_Group_image, [40 40]);
Clasificacion_Group_B=uicontrol(h,'style','push','Callback',@Clasificacion_Group,...
                 'position',[10,580,40,40],'TooltipString','Classification','CData',Clasificacion_Group_image,'BackgroundColor','white');
             
Run_Group_image=imread('Run_ico.jpg');    
Run_Group_image=imresize(Run_Group_image, [40 40]);
Run_Group_B=uicontrol(h,'style','push','Callback',@Run_Simulation,...
                 'position',[10,70,40,40],'TooltipString','Run simulation','CData',Run_Group_image,'BackgroundColor','white');


% Variables globales get nodes information
global k  cu cu2 Info     ec  cuf A ch X   Molinoc_container Hidrociclon_container cumc cuh  RC cump cuff S cumR MaxIt Tol SolverData state...
    Tromm Potencia_vector d50_vector cx cy TOP
state= 0;
S=[];
cuff=0;
Info=[];
TagIdentifier=0;
k=1;
%%% Contadores
cu=1;     %General
cuscr=1;  %Screnner
cumsag=1; %SAG
cumc=1;   %Convencional
cumR=1;   %Rodillos
cump=1;   %No se
cuch=1;   %Chancador
cuh=1;    %Hidrocicl�n
cu2=0;
cuf=1;    %Flujos
ec=1;
ch=0;
Tromm = 0;
cx=[0.1 0.1];
cy=[0.1 0.1];
A= struct;
Molinoc_container = struct;
Hidrociclon_container = struct;
RC=struct;
RC_text=text(0,0,'');
Resultados_Flujos=struct;
G=0;
X=struct;
X.Length=[];
wcunt=1;
Tol=1e-5;
MaxIt=300;
SolverData=[];
Potencia_vector = [];
d50_vector = [];
TOP = [];


%%%%%%%%%%% Par�metros de entrada
global v ros rol
v=[]; %%% sizes vector
ros=2; %%% solid density
rol=1; %%% liquid density
%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%% Menu %%%%%%%%%%


t=uitoolbar(h);

New_ico=imread('New_ico.png');
New_ico=imBackGround(New_ico,Colorf);
New_ico=imresize(New_ico,[20 20]);
New_push = uipushtool(t,'cdata',New_ico,'tooltip','New Project', 'ClickedCallback',@NewP);
           
Open_ico=imread('Open_ico.png');
Open_ico=imresize(Open_ico,[20 20]);
Open_ico=imBackGround(Open_ico,Colorf);
Open_push = uipushtool(t,'cdata',Open_ico,'tooltip','Open Project', 'ClickedCallback',@cargar_proyect);

Save_ico=imread('Save_ico.png');
Save_ico=imBackGround(Save_ico,Colorf);
Save_ico=imresize(Save_ico,[20 20]);
Save_push = uipushtool(t,'cdata',Save_ico,'tooltip','Save Project', 'ClickedCallback',@guardar2);

Parameters_ico=imread('Parameters.ico');
Parameters_ico=imBackGround(Parameters_ico,Colorf);
Parameters_ico=imresize(Parameters_ico,[20 20]);
Parameters_push = uipushtool(t,'cdata',Parameters_ico,'tooltip','Parameters', 'ClickedCallback',@parametros);
Parameters_push.Separator='on';

Solver_ico=imread('Solver_ico.png');
Solver_ico=imBackGround(Solver_ico,Colorf);
Solver_ico=imresize(Solver_ico,[20 20]);
Solver_push = uipushtool(t,'cdata',Solver_ico,'tooltip','Solver Configuration', 'ClickedCallback',@Solver_Config);

Resultados_ico=imread('Results_ico.png');
Resultados_ico=imBackGround(Resultados_ico,Colorf);
Resultados_ico=imresize(Resultados_ico,[20 20]);
Resultados_push = uipushtool(t,'cdata',Resultados_ico,'tooltip','Results', 'ClickedCallback',@Results);
Resultados_push.Separator='on';

Exportar_ico=imread('Export_ico.png');
Exportar_ico=imBackGround(Exportar_ico,Colorf);
Exportar_ico=imresize(Exportar_ico,[20 20]);
Exportar_push = uipushtool(t,'cdata',Exportar_ico,'tooltip','Export', 'ClickedCallback',@exportar);

p = uimenu('Label','Project');
    uimenu(p,'Label','New Project','Callback',@NuevoP);
    uimenu(p,'Label','Save Project','Callback',@guardar2);
    uimenu(p,'Label','Open Project','Callback',@cargar_proyect);

c = uimenu('Label','Configuration');
    uimenu(c,'Label','Parameters','Callback',@parametros);
    uimenu(c,'Label','Solver Configuration','Callback',@Solver_Config);

    
r=  uimenu('Label','Results','Enable','on');
    uimenu(r,'Label','Exportar Results','Callback',@exportar);
    uimenu(r,'Label','View Results','Callback',@Resultados);
    uimenu(r,'Label','Solver Data','Callback',@Solver_Result);
    
    
    axis(axesgnu,[0 a 0 b])
    set(axesgnu,'xtick',[],'ytick',[])
    %%%%%%%%%%%%%%%%%%%
    set(h,'SelectionType','extend'); 
    set(h,'WindowButtonDownFcn',@Mousecall)
    
   
    axesgnu.XTickLabel={''};
    axesgnu.YTickLabel={''};
    
drawnow;
evalin('base','JavaContainer_toolB=get(t,''JavaContainer'');');
evalin('base','JTool=get(JavaContainer_toolB,''ComponentPeer'');');
JTool.setBackground(java.awt.Color(Colorf(1),Colorf(2),Colorf(3)));
JTool.setSize(java.awt.Dimension(1366,35));


robot = java.awt.Robot; 
robot.keyPress(java.awt.event.KeyEvent.VK_ALT);      %// send ALT
robot.keyPress(java.awt.event.KeyEvent.VK_SPACE);    %// send SPACE
robot.keyRelease(java.awt.event.KeyEvent.VK_SPACE);  %// release SPACE
robot.keyRelease(java.awt.event.KeyEvent.VK_ALT);    %// release ALT
robot.keyPress(java.awt.event.KeyEvent.VK_X);        %// send X
robot.keyRelease(java.awt.event.KeyEvent.VK_X);   
clear robot JTool JavaContainer_toolB


