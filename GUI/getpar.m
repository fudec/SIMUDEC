function getpar(source,~)
global ros rol
handles=source.UserData;
ros=get(handles(1),'String');
rol=get(handles(2),'String');
msgbox('Guardado con éxito','');
end