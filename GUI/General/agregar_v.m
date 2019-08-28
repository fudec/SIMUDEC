function agregar_v(~,~)

global v

defaultValue = 18;
titleBar = '';
userPrompt = 'Número intervalos';
caUserInput = inputdlg(userPrompt, titleBar, 1, {num2str(defaultValue)});
if isempty(caUserInput)
    return
end
n = round(str2double(cell2mat(caUserInput)));

f3=figure;
set(f3,'name','Intervalos','numbertitle','off','Position', [500,520-20*n,125,20*n+90],'Units','pixels','menubar','none','units','normalized',...
    'Resize','off')   
%     if isempty(v) == 1
        myData=num2cell(zeros(n,1));
%     else
%         myData=mat2cell(v,length(v),1);
%     end
    t = uitable('Parent',f3,...
                'Position', [0 80 125 20*n], ...
                'Data',myData,...
                'ColumnEditable', [true true], ...
                'CellEditCallback',@converttonum);
     t.Position(3) = t.Extent(3);
     t.Position(4) = t.Extent(4);
        function converttonum(hObject,callbackdata)
             numval = eval(callbackdata.EditData);
             r = callbackdata.Indices(1);
             c = callbackdata.Indices(2);
             hObject.Data{r,c} = numval; 
        end
Cerrar= uicontrol('Parent',f3,'style','push','string','Cerrar','Callback',@cerrar,...
                  'position',[2,2,125,22]); 
Guardar = uicontrol('Parent',f3,'style','push','string','Guardar','Callback',@data,...
                  'position',[2,22,125,25]); 

  function data(hObject,callbackdata)
    data = get(t,'Data');
   v=cell2mat(data);
   msgbox('Guardado con éxito','');
  end
waitfor(f3)
vexist=exist('v');
if vexist ~=  1
        return       
end
if sum(v) == 0
        return       
end
end