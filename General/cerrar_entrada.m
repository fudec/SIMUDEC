function cerrar_entrada(hObject,~)
hObject.UserData.flag  = 1;
choice = questdlg('�Seguro que desea cerrar?', ...
	'Advertencia', ...
	'Si','No','No');
switch choice
    case 'Si'
        delete(hObject.Parent)
    case 'No'
        return
end
    
end