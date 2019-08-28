function cerrar_entrada(hObject,~)
choice = questdlg('Ready to close?', ...
	'Warning', ...
	'Yes','No','No');
switch choice
    case 'Yes'
        delete(hObject.Parent)
    case 'No'
        return
end
end