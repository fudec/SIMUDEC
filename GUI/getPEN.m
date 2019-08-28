function getPEN(source,~)
global v m
        
        Handles=get(source,'UserData');
        Handles = Handles.Edit;
        FW=get(Handles(1),'String');
        w=get(Handles(2),'String');
        
        x=get(Handles(1),'UserData');
        
        FW=str2double(FW);
        w=str2double(w);
        m=source.Parent.Children(5).UserData;
      if isempty(m)
        m=zeros(length(v,1));
      end
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
            m=[m;FW];
            msgbox('Saved','');

            end
    elseif length(m) ~= length(v) || ~isa(m,'double')
        msgbox('Invalid mass','');
        return
    else
            msgbox('Saved','');
            m=[m;FW];

    end
      source.Parent.Children(3).UserData = 1;

end