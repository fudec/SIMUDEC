function getSCR1(source,~)
global Info 

% aceptar_mo1.UserData=[Dc_edit Di_edit Do_edit  Du_edit...
    % Lc_edit theta_edit N_edit KQ0_edit Kd0_edit Kw1_edit Kv1_edit];

        Handles=get(source,'UserData');
        Index=get(Handles(1),'UserData');

        Rf=get(Handles(1),'String');
        alfa=get(Handles(2),'String');
        d50=get(Handles(3),'String');
        beta=get(Handles(4),'String');
        beta_=get(Handles(5),'String');
    
                
        x=get(Handles(1),'UserData');
        
        Rf=str2double(Rf);
        alfa=str2double(alfa);        
        d50=str2double(d50);
        beta=str2double(beta);        
        beta_=str2double(beta_);
  
        
        Container.Rf=Rf;
        Container.alfa=alfa;       
        Container.d50=d50;
        Container.beta=beta;       
        Container.Lc=beta_;
    
        Container.Index=Info(Index).Index;
Info(Index).Container=Container;
msgbox('Saved','');
end