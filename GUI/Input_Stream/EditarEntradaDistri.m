function EditarEntradaDistri(Object,~)
global v  Info 
n=length(v);
f4=figure;
set(f4,'name','Agregar entrada','numbertitle','off','Position', [500,520-20*n,400,20*n+90],'Units','pixels','menubar','none','units','normalized')
k=Object.UserData;
Info(k).val
kk=num2cell(Info(k).val);
%%%%%%%%%%%%%%%%% Agregar visor de entradas %%%
t = uitable('Parent',f4,...
                'Position', [2 85 125 20*n], ... 
                'Data',kk,...
                'ColumnEditable',  true, ...
                'CellEditCallback',@converttonum);
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
                'ColumnEditable',false);
 t2.Position(3) = t2.Extent(3);
 t2.Position(4) = t2.Extent(4);
     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


Cerrar= uicontrol('Parent',f4,'style','push','string','Cerrar','Callback',@cerrar,...
                  'position',[2,2,125,22]); 
Guardar = uicontrol('Parent',f4,'style','push','string','Guardar','Callback',@data,...
                  'position',[2,22,125,25]); 

  function data(hObject,callbackdata)
    data = get(t,'Data');
    m=cell2mat(data);
    if length(m) ~= length(v)
        wrnbox=warndlg('Vector de flujos incorrecto','Advertencia');
    return
    end
    msgbox('Guardado con éxito','');
  end

waitfor(f4)
mexist=exist('m');
if mexist ~=  1
        return       
end
if sum(m) == 0
        return       
end
k=Object.UserData;
Info(k).val=k;
end