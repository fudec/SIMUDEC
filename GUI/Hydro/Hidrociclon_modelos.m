function Hidrociclon_modelos(source,~)

global popup_mo

answer=[];

answer = questdlg('This will delete previous models. Continue?', ...
	'Warning', ...
	'Yes','No','No');

if strcmp(answer,'No') || isempty(answer)
    return
end


x = get_index(source);
 k=figure;
 set(k,'name','Selecci�n modelo','numbertitle','off','Position', [500,500,200,200],'Units','pixels','menubar','none','units','normalized')
 
 popup_mo=uicontrol('Parent',k,...
           'Style','popup',...
           'Position',[25 150 100 25],...
           'String',{'Modelo 1'},'Value',1);
 
 Aceptar = uicontrol('Parent',k,...
           'Style','push',...
           'Position',[25 90 100 25],...
           'String','Aceptar',...
           'Callback',@popup_callbackmo);
 cerrar2 = uicontrol('Parent',k,...
           'Style','push',...
           'Position',[25 40 100 25],...
           'String','Cerrar',...
           'Callback',@cerrar);
  
  function popup_callbackmo(hObject,~)
          elec=get(popup_mo,'Value'); 
          close(hObject.Parent);
    if elec ==1
      Modelo_1_h(x)
    end
    
  end
  
end
