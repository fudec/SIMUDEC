function edit_modelo1_h(x)

global Info
x = get_index_info(x.Index);


if  isempty(Info(4).Container)
    wrndl=warndlg('There is no data for this model','Warning');
    return
end

        Dc=Info(x).Container.Dc;
        Di=Info(x).Container.Di;        
        Do=Info(x).Container.Do;
        Du=Info(x).Container.Du;        
        Lc=Info(x).Container.Lc;
        theta=Info(x).Container.theta;        
        N=Info(x).Container.N;
        
        KQ0=Info(4).Container.KQ0;
        Kd0=Info(4).Container.Kd0;
        Kw1=Info(4).Container.Kw1;        
        Kv1=Info(4).Container.Kv1;
        
        alfa=Info(4).Container.alfa;
        beta=Info(4).Container.beta;        
        beta_=Info(4).Container.beta_;
 
figure_modelo_hidro=figure;
figure_modelo_hidro.Position=[600 190 205 450];
set(figure_modelo_hidro,'numbertitle','off','menubar','none','name',Info(x).tag2)
set(figure_modelo_hidro,'Resize','off');

dimen_bg= uibuttongroup(figure_modelo_hidro,...
                  'Title','Dimensions',...
                  'Position', [0.1 0.55 0.8 0.40]);
              
Info_image=imread('Info.ico');
Info_image=imresize(Info_image, [15 15]);
Info_button=uicontrol(figure_modelo_hidro,'style','push','CData',Info_image,'Position', [170 295 15 15],'BackgroundColor','white',...
    'tooltipstring','Meters');             

Px=95;

%%% Di�metro %%%%%%%%%%
Dcy=150;
Dcx=20;

Dc_edit=uicontrol(dimen_bg,'style','edit','string',Dc);
Dc_edit.Position = [Px Dcy 40 15];

Dc_text=uicontrol(dimen_bg,'style','text','string','Diameter');
Dc_text.Position = [Dcx Dcy 60 15];

% %%%%%%%%%%%% Inlet %%%%%%%%%%%%%%%%%%

Diy=135;
Dix=6;

Di_edit=uicontrol(dimen_bg,'style','edit','string',Di);
Di_edit.Position = [Px Diy 40 15];

Di_text=uicontrol(dimen_bg,'style','text','string','Inlet');
Di_text.Position = [Dix Diy 60 15];

% %%%%%%%%%%%% Vortex %%%%%%%%%%%%%%%%%%

Doy=120;
Dox=9;

Do_edit=uicontrol(dimen_bg,'style','edit','string',Do);
Do_edit.Position = [Px Doy 40 15];

Do_text=uicontrol(dimen_bg,'style','text','string','Vortex');
Do_text.Position = [Dox Doy 60 15];

%%%%%%%%%%%%% Apex %%%%%%%%%%%%%%%%%%

Duy=105;
Dux=8;


Du_edit=uicontrol(dimen_bg,'style','edit','string',Du);
Du_edit.Position = [Px Duy 40 15];

Du_text=uicontrol(dimen_bg,'style','text','string','Apex');
Du_text.Position = [Dux Duy 60 15];

%%%%%%%%%%%%% Lc %%%%%%%%%%%%%%%%%%

Lcy=90;
Lcx=14;

Lc_edit=uicontrol(dimen_bg,'style','edit','string',Lc);
Lc_edit.Position = [Px Lcy 40 15];

Lc_text=uicontrol(dimen_bg,'style','text','string','Lc','TooltipString','Cilindric size');
Lc_text.Position = [Lcx Lcy 40 15];
%%%%%%%%% theta &%%%%%%%%%%

thetay=75;
PaxT=0;

theta_edit=uicontrol(dimen_bg,'style','edit','string',theta);
theta_edit.Position = [Px thetay 40 15];

theta_text=uicontrol(dimen_bg,'style','text','string','theta','TooltipString','Angle');
theta_text.Position = [PaxT thetay 80 15];

%%%%%% Numero %%%%%
Ny=60;
Nx=12;

N_text=uicontrol(dimen_bg,'style','text','string','N','TooltipString','Number oo Cyclones');
N_text.Position = [Nx Ny 42 15];

N_edit=uicontrol(dimen_bg,'style','edit','string',N);
N_edit.Position = [Px Ny 40 15];

%%%%%%%%% Par�metros %%%%%%%%%5
Pa_bg= uibuttongroup(figure_modelo_hidro,...
                  'Title','Parameters',...
                  'Position', [0.1 0.2 0.8 0.3]);
%%%%%%%%%%%%%%% KQ0 %%%%%%%%%%%%%%%%%%%
KQ0y=100;
KQ0x=10;

KQ0_text=uicontrol(Pa_bg,'style','text','string','KQ0');
KQ0_text.Position = [KQ0x KQ0y 80 15];

KQ0_edit=uicontrol(Pa_bg,'style','edit','string',KQ0);
KQ0_edit.Position = [Px KQ0y 40 15];

%%%%%%%%%%%%%%%%% Kd0 %%%%%%%%%%%%%
Kd0y=85;
Kd0x=10;

Kd0_text=uicontrol(Pa_bg,'style','text','string','Kd0');
Kd0_text.Position = [Kd0x Kd0y 80 15];

Kd0_edit=uicontrol(Pa_bg,'style','edit','string',Kd0);
Kd0_edit.Position = [Px Kd0y 40 15];
%%%%%%%%%%%%% Kw1 %%%%%%%%%%%%5
Kw1y=70;
Kw1x=10;

Kw1_text=uicontrol(Pa_bg,'style','text','string','Kw1');
Kw1_text.Position = [Kw1x Kw1y 80 15];

Kw1_edit=uicontrol(Pa_bg,'style','edit','string',Kw1);
Kw1_edit.Position = [Px Kw1y 40 15];

%%%%%%%%%%%%% Kv1 %%%%%%%%%%%%5
Kv1y=55;
Kv1x=10;

Kv1_text=uicontrol(Pa_bg,'style','text','string','Kv1');
Kv1_text.Position = [Kv1x Kv1y 80 15];

Kv1_edit=uicontrol(Pa_bg,'style','edit','string',Kv1);
Kv1_edit.Position = [Px Kv1y 40 15];

%%%%%%%%%%%%% alfa %%%%%%%%%%%%5
alfay=40;
alfax=10;

alfa_text=uicontrol(Pa_bg,'style','text','string','alfa');
alfa_text.Position = [alfax alfay 80 15];

alfa_edit=uicontrol(Pa_bg,'style','edit','string',alfa);
alfa_edit.Position = [Px alfay 40 15];


%%%%%%%%%%%%% beta %%%%%%%%%%%%5
betay=25;
betax=10;

beta_text=uicontrol(Pa_bg,'style','text','string','beta');
beta_text.Position = [betax betay 80 15];

beta_edit=uicontrol(Pa_bg,'style','edit','string',beta);
beta_edit.Position = [Px betay 40 15];

%%%%%%%%%%%%% beta* %%%%%%%%%%%%5
beta_y=10;
beta_x=10;

beta__text=uicontrol(Pa_bg,'style','text','string','beta*');
beta__text.Position = [beta_x beta_y 80 15];

beta__edit=uicontrol(Pa_bg,'style','edit','string',beta_);
beta__edit.Position = [Px beta_y 40 15];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
cerrar_mo1 = uicontrol('Parent',figure_modelo_hidro,...
           'Style','push',...
           'Position',[115 10 70 25],...
           'String','Close',...
           'Callback',@cerrar);
aceptar_mo1=uicontrol;
Dc_edit.UserData=x;

aceptar_mo1.UserData=[Dc_edit Di_edit Do_edit  Du_edit...
     Lc_edit theta_edit N_edit KQ0_edit Kd0_edit Kw1_edit Kv1_edit alfa_edit beta_edit beta__edit];

 set(aceptar_mo1,'Parent',figure_modelo_hidro,...
           'Style','push',...
           'Position',[20 10 70 25],...
           'String','Save',...
           'Callback',@getHPM1);
     
waitfor(figure_modelo_hidro)
end