function MolinoR_modelos(source,callbackdata)

global popup_mo coso

answer = questdlg('Esto eliminar� valores agregados (Si los hay).Continuar?', ...
	'Advertencia', ...
	'Si','Cake','No');

if strcmp(answer,'No')
    return
end



 x=getappdata(source,'Index');
 k=figure;
 set(k,'name','Selecci�n modelo','numbertitle','off','Position', [500,500,200,200],'Units','pixels','menubar','none','units','normalized')
 set(k,'resize','off')
 
 popup_mo=uicontrol('Parent',k,...
           'Style','popup',...
           'Position',[25 150 100 25],...
           'String',{'Whiten'},'Value',1);
 
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
  
  
  function popup_callbackmo(hObject,callbackdata)
    
    elec=get(popup_mo,'Value');      
    if elec ==1
      close(hObject.Parent)
      ModR1(x)
    end
  end
  
end
