function kk=Modelo_1(x)

global v 
    
Mo1=figure(3);
 set(Mo1,'name','Modelo 1','numbertitle','off','Position', [600,200,300,300],'Units','pixels','menubar','none','units','normalized')
 
 
 Breakage_Tex=uicontrol('Parent',Mo1,...
           'Style','text',...
           'Position',[5 250 100 25],...
           'String','Breakage Function');
 
 Phi_Text=uicontrol('Parent',Mo1,...
           'Style','text',...
           'Position',[5 90 50 25],...
           'String','\phi');
 Upsilon_Text=uicontrol('Parent',Mo1,...
           'Style','text',...
           'Position',[5 140 50 25],...
           'String','\Upsilon');
 Beta_Text=uicontrol('Parent',Mo1,...
           'Style','text',...
           'Position',[5 190 50 25],...
           'String','\beta');
 
 Phi_Edit = uicontrol('Parent',Mo1,...
           'Style','edit',...
           'Position',[80 90 50 25],...
           'String','1');
 Upsilon_Edit = uicontrol('Parent',Mo1,...
           'Style','edit',...
           'Position',[80 140 50 25],...
           'String','1');
       
 Beta_Edit= uicontrol('Parent',Mo1,...
           'Style','edit',...
           'Position',[80 190 50 25],...
           'String','1');
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%      
       
Selection_Text=uicontrol('Parent',Mo1,...
           'Style','text',...
           'Position',[150 250 100 25],...
           'String','Selection Function');
 
 Mu_Text=uicontrol('Parent',Mo1,...
           'Style','text',...
           'Position',[150 190 50 25],...
           'String','\mu');
 Lambda_Text=uicontrol('Parent',Mo1,...
           'Style','text',...
           'Position',[150 140 50 25],...
           'String','\Lambda');
 alfa_Text=uicontrol('Parent',Mo1,...
           'Style','text',...
           'Position',[150 90 50 25],...
           'String','\alfa');
 a_Text=uicontrol('Parent',Mo1,...
           'Style','text',...
           'Position',[150 40 50 25],...
           'String','a');
       
 
 Mu_Edit = uicontrol('Parent',Mo1,...
           'Style','edit',...
           'Position',[200 190 50 25],...
           'String','1');
 Lambda_Edit = uicontrol('Parent',Mo1,...
           'Style','edit',...
           'Position',[200 140 50 25],...
           'String','1');
 alfa_Edit = uicontrol('Parent',Mo1,...
           'Style','edit',...
           'Position',[200 90 50 25],...
           'String','1');
 a_Edit = uicontrol('Parent',Mo1,...
           'Style','edit',...
           'Position',[200 40 50 25],...
           'String','1');
       
       
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
 cerrar_mo1 = uicontrol('Parent',Mo1,...
           'Style','push',...
           'Position',[150 10 100 25],...
           'String','Cerrar',...
           'Callback',@cerrar);
aceptar_mo1=uicontrol;
Phi_Edit.UserData=x;
aceptar_mo1.UserData=[Phi_Edit Upsilon_Edit Beta_Edit alfa_Edit a_Edit Mu_Edit Lambda_Edit];

 set(aceptar_mo1,'Parent',Mo1,...
           'Style','push',...
           'Position',[5 10 100 25],...
           'String','Aceptar',...
           'Callback',@create_matrixmoc1);
     
waitfor(Mo1)
end