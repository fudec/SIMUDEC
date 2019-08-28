function cerrarxP(hObject,~)

choice = questdlg('¿Seguro que desea cerrar?', ...
	'Advertencia', ...
	'Si','No','No');
switch choice
    case 'Si'
        delete(hObject)
    case 'No'
        return
end
clear all
close all

end