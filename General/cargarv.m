function cargar_v(hObject,eventdata)
global v

[File,PathName] = uigetfile('*.xlsx','Seleccionar archivo');
cd(PathName);

v=xlsread(File);

end