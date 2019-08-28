function NewP(~,~)

choice = questdlg('Save project before leave?', ...
	'Warning', ...
	'Yes','No','Cancel','Yes');
switch choice
    case 'Si'
        guardar2
        evalin( 'base', 'clearvars -except h' )
        evalin('base','delete(h)')
        evalin( 'base', 'clearvars h' )
    case 'No'
        evalin( 'base', 'clearvars -except h' )
        evalin('base','delete(h)')
        evalin( 'base', 'clearvars h' )
    case 'Cancelar'
        return
end

try
        evalin('base','Simulator');
catch
    return
end

end