function Hidro_modelos(source,~)

global popup_mo Info
 
answer=[];
source
answer = questdlg('This will delete previous models. Continue?', ...
	'Warning', ...
	'Yes','No','No');

if strcmp(answer,'No') || isempty(answer)
    return
end


x = get_index(source);
 k=figure;
 set(k,'name','Selecci�n modelo','numbertitle','off','Position', [500,500,200,200],'Units','pixels','menubar','none','units','normalized')
 set(k,'resize','off')

 popup_mo=uicontrol('Parent',k,...
           'Style','popup',...
           'Position',[25 150 100 25],...
           'String',{'Nageswararao'},'Value',1);
 
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
      ModH1(x)
    end
  end
  
end
