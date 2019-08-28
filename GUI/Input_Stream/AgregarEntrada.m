
function AgregarEntrada(Object,~)
global v  

n=length(v);
f4=figure;
set(f4,'name','Add Distribution','numbertitle','off','Position', [520,550-20*n,220,20*n+90],'Units','pixels','menubar','none','units','normalized','CloseRequestFcn',@cerrarx,'Resize','off')
kk=num2cell(zeros(length(v),1));
F1=[0.00 5.00 16.60 14.07 10.33 8.34 6.84 5.41 5.10 3.90 3.54 3.01 2.59 2.21 1.88 1.62 1.38 1.18 0.85 6.15]';

kk = num2cell(F1);
%%%%%%%%%%%%%%%%% Agregar visor de entradas %%%
t = uitable('Parent',f4,...
                'Position', [2 85 125 20*n], ... 
                'Data',kk,...
                'ColumnEditable',  true, ...
                'CellEditCallback',@converttonum,...
                'ColumnName',{'Masa'});
     t.Position(3) = t.Extent(3);
     t.Position(4) = t.Extent(4);
     function converttonum(hObject,callbackdata)
             numval = eval(callbackdata.EditData);
             r = callbackdata.Indices(1);
             c = callbackdata.Indices(2);
             hObject.Data{r,c} = numval; 
        end
 %%%%%%%%%%%%%%%%%
 t2 = uitable('Parent',f4,...
                'Position', [110 85 220 20*n], ...
                'Data',v,...
                'ColumnEditable',false,...
                'ColumnName',{'Top = 200'});
 t2.Position(3) = t2.Extent(3);
 t2.Position(4) = t2.Extent(4);
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Cerrar= uicontrol('Parent',f4,'style','push','string','Close','Callback',@cerrar,...
                  'position',[55,2,125,25]); 
Guardar = uicontrol('Parent',f4,'style','push','string','Save','Callback',@data,...
                  'position',[55,25,125,25]); 
Cargar = uicontrol('Parent',f4,'style','push','string','Load Distribution','Callback',@cargarEntrada,...
                  'position',[55,48,125,25]); 
  function data(~,~)
    data = get(t,'Data');
    m=cell2mat(data);
    if length(m) ~= length(v)
        wrnbox=warndlg('Vector de flujos incorrecto','Advertencia');
    return
    elseif sum(m) == 0
        wrnbox=warndlg('Mass is zero','Warning');
    else
        msgbox('Saved','');

    end
  end

waitfor(f4)
mexist=exist('m');
if mexist ~=  1
        return       
end

Object.UserData = m;
end