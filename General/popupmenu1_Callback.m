function results=popupmenu1_Callback(hObject, eventdata)

 % Get value of popup
      selectedIndex = get(hObject, 'Value');
 % Take action based upon selection
    
    if selectedIndex == 1
        results= uicontrol('style','toggle','string','Introducir par�metros1','Callback',@molc_1,...
                 'position',[234,50,120,20]);
    elseif selectedIndex == 2;
        molc_togg= uicontrol('style','toggle','string','Introducir par�metros2','Callback',@molc_2,...
                 'position',[234,50,120,20]);
    elseif selectedIndex == 3;
        molc_togg= uicontrol('style','toggle','string','Introducir par�metros3','Callback',@molc_3,...
                 'position',[234,50,120,20]);
    end