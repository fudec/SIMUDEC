function getPEN_Edit(source,~)
global v m
        Handles=get(source,'UserData');
        m=Handles.m;
        Handles=Handles.Edit;
        FW=get(Handles(1),'String');
        w=get(Handles(2),'String');
        
        x=get(Handles(1),'UserData');
        
        FW=str2double(FW);
        w=str2double(w);
        
   
      if FW == 0 && w == 0
          msgbox('Input Water stream or %w','');
          return
      elseif FW ~= 0 && w == 0

      elseif FW == 0 && w ~= 0
            FW=sum(m)*(1-w/100)/(w/100);
      end
    if sum(m) == 0
            choice = questdlg('Solid mass is zero. Continue?', ...
            'Selection', ...
            'Yes','No','Yes');
            switch choice
                case 'No'
                    return
                case 'Yes'
            m(end)=FW;
            msgbox('Saved','');

            end
    elseif length(m) ~= length(v)+1 || ~isa(m,'double')
        msgbox('Invalid mass','');
        return
    else
            msgbox('Saved','');
            FW
            m(end)=FW;

    end
      source.Parent.Children(3).UserData = 1;

end