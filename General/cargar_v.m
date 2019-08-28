function cargar_v(~,~)
global v

[File,Path] = uigetfile( ...
{  '*.xlsx;*.xls','Excel (*.xlsx,*.xls)'; ...
   '*.csv','CSV (*.csv)'; ...
   '*.txt','Texto (*.txt)'; ...
   '*.dat','DAT (*.dat)'; ...
   '*.mat','MAT-files (*.mat)'}, ...
   'Seleccionar archivo');
if Path == 0
    return
end

[~,~,ext]=fileparts(File);
wb = waitbar(0, 'Cargando');
wbch = allchild(wb);
jp = wbch(1).JavaPeer;
jp.setIndeterminate(1)


 if strcmp(ext,'.xlsx') || strcmp(ext,'.xls')
    try
    v=xlsread([Path,File]);
    catch
        errordlg('Archivo incompatible')
    end
elseif strcmp(ext,'.txt') || strcmp(ext,'.mat') || strcmp(ext,'.dat')
    try
        v=load([Path,File]);
    catch
        errordlg('Archivo incompatible')
    end
elseif strcmp(ext,'.csv') 
    try
        v=csvread([Path,File]);
    catch
        errordlg('Archivo incompatible')
        return
    end
end

[m,n]= size(v);
if n > m
    v=v';
end
delete(wb)
Message='Carga exitosa';
msgbox(Message);

end