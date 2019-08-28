function getpar_Solver(source,~)
global Tol MaxIt
handles=source.UserData;
Tol=str2double(get(handles(1),'String'));
MaxIt=str2double(get(handles(2),'String'));
msgbox('Guardado con éxito','');
end