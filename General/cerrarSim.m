function cerrarSim(~,~)

choice = questdlg('¿Guardar proyecto antes de cerrar?', ...
	'Advertencia', ...
	'Si','No','Cancelar','Si');
switch choice
    case 'Si'
        guardar2
    case 'No'
        
    case 'Cancelar'
        return
end

evalin( 'base', 'clearvars -except h' )
evalin('base','delete(h)')
evalin( 'base', 'clearvars h' )
evalin( 'base', 'close all' )
end