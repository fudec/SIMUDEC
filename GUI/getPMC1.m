function getPMC1(source,~)

global Info 
% aceptar_mo1.UserData=[editbox_D_sim editbox_D_ori editbox_Largo_sim editbox_Largo_ori...
%     editbox_CS_sim editbox_CS_ori editbox_FL_sim editbox_FL_ori editbox_WI_sim editbox_WI_ori...
%     Kn1_edit Kn1_editD Kn2_edit Kn2_editD Kn3_edit Kn3_editD Kn4_edit Kn4_editD Balltop_edit_sim Balltop_edit_ori Breakage_factor_edit];
        
    
        Handles=get(source,'UserData');
        
        Index=get(Handles(1),'UserData');
        
        D_sim=get(Handles(1),'String');
        D_ori=get(Handles(2),'String');
        
        L_sim=get(Handles(3),'String');
        L_ori=get(Handles(4),'String');
        
        CS_sim=get(Handles(5),'String');
        CS_ori=get(Handles(6),'String');
       
        FL_sim=get(Handles(7),'String');
        FL_ori=get(Handles(8),'String');
        
        WI_sim=get(Handles(9),'String');
        WI_ori=get(Handles(10),'String');
        
        Kn1=get(Handles(11),'String');
        Kn1v=get(Handles(12),'String');
        
        Kn2=get(Handles(13),'String');
        Kn2v=get(Handles(14),'String');
        
        Kn3=get(Handles(15),'String');
        Kn3v=get(Handles(16),'String');
        
        Kn4=get(Handles(17),'String');
        Kn4v=get(Handles(18),'String');
        
        Db_sim=get(Handles(19),'String');
        Db_ori=get(Handles(20),'String');
        
        Breakage_factor=get(Handles(21),'String');
              
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
        
        Kn1=str2double(Kn1);
        Kn1v=str2double(Kn1v);
        
        Kn2=str2double(Kn2);
        Kn2v=str2double(Kn2v);
        
        Kn3=str2double(Kn3);
        Kn3v=str2double(Kn3v);
        
        Kn4=str2double(Kn4);
        Kn4v=str2double(Kn4v);
        
        Db_sim=str2double(Db_sim);
        Db_ori=str2double(Db_ori);
        
        Breakage_factor=str2double(Breakage_factor);
        
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
        
        Container.Kn1=Kn1;
        Container.Kn1v=Kn1v;
        
        Container.Kn2=Kn2;
        Container.Kn2v=Kn2v;
        
        Container.Kn3=Kn3;
        Container.Kn3v=Kn3v;  
        
        Container.Kn4=Kn4;
        Container.Kn4v=Kn4v;
        
        Container.Db_sim=Db_sim;
        Container.Db_ori=Db_ori;
        
        Container.Breakage_factor=Breakage_factor;
        
        Container.Potencia=0;
        
        Container.Index=Info(Index).Index;
        
        fields=fieldnames(Container);

        for i=1:length(fields)
            if isnan(Container.(fields{i}))             
                warndlg(sprintf('Falta %s',fields{i}));
                return
            end
        end
        
Info(Index).Container=Container;
msgbox('Saved','');
end