function getPMR1(source,eventdata)

global Info 

% [editbox_Pa_ori editbox_MC_ori editbox_D_sim editbox_D_ori editbox_Largo_sim editbox_Largo_ori...
%     editbox_CS_sim editbox_CS_ori editbox_FL_sim editbox_FL_ori editbox_WI_sim editbox_WI_ori editbox_XC editbox_SI editbox_IN]

        Handles=get(source,'UserData');
        Pa=get(Handles(1),'String');
        MC=get(Handles(2),'String');
        
        D_sim=get(Handles(3),'String');
        D_ori=get(Handles(4),'String');
        
        L_sim=get(Handles(5),'String');
        L_ori=get(Handles(6),'String');
        
        CS_sim=get(Handles(7),'String');
        CS_ori=get(Handles(8),'String');
       
        FL_sim=get(Handles(9),'String');
        FL_ori=get(Handles(10),'String');
        
        WI_sim=get(Handles(11),'String');
        WI_ori=get(Handles(12),'String');
        
        XC=get(Handles(13),'String');
        SI=get(Handles(14),'String');
        IN=get(Handles(15),'String');
        
        Vr=get(Handles(16),'String');
        
        x=get(Handles(1),'UserData');
        
        Pa=str2double(Pa);
        MC=str2double(MC);
        
        D_sim=str2double(D_sim);
        D_ori=str2double(D_ori);
        
        L_sim=str2double(L_sim);
        L_ori=str2double(L_ori);
        
        CS_sim=str2double(CS_sim);
        CS_ori=str2double(CS_ori);
        
        FL_sim=str2double(FL_sim);
        FL_ori=str2double(FL_ori);
        
        WI_sim=str2double(WI_sim);
        WI_ori=str2double(WI_ori);
        
        XC=str2double(XC);
        SI=str2double(SI);
        IN=str2double(IN);
         
        Vr=str2double(Vr);
        
        Container.Pa=Pa;
        Container.MC=MC;
        
        Container.D_sim=D_sim;
        Container.D_ori=D_ori;
        
        Container.L_sim=L_sim;
        Container.L_ori=L_ori;
        
        Container.CS_sim=CS_sim;
        Container.CS_ori=CS_ori;
        
        Container.FL_sim=FL_sim;
        Container.FL_ori=FL_ori;
        
        Container.WI_sim=WI_sim;
        Container.WI_ori=WI_ori;
        
        Container.XC=XC;
        Container.SI=SI;
        Container.IN=IN;
        
        Container.Vr=Vr;

Info(x).Container=Container;
msgbox('Guardado con éxito','');
end