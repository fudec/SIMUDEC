function cerrarx(hObject,~)
choice = questdlg('Close window?', ...
	'Warning', ...
	'Yes','No','No');
switch choice
    case 'Yes'
        delete(hObject)
    case 'No'
        return
end
end