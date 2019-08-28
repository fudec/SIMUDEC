function cargar_proyect(~,~)

[File,Path] = uigetfile('*.mat','Select Project');

if File == 0
    return
end

try
        evalin( 'base', 'clearvars -except h' )
        evalin('base','delete(h)')
        evalin( 'base', 'clearvars h' )
        evalin('base', ['load(''', [Path File] ''')']);
catch
    return
end

end