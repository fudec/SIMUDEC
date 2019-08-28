function Molinoc_modelos_edit(source,~)

global popup_mo v


x = get_index(source);
 k=figure;
 set(k,'name','Model Selection','numbertitle','off','Position', [500,500,200,200],'Units','pixels','menubar','none','units','normalized')
 
 popup_mo=uicontrol('Parent',k,...
           'Style','popup',...
           'Position',[25 150 100 25],...
           'String',{'Modelo 1'},'Value',1);
 
 Aceptar = uicontrol('Parent',k,...
           'Style','push',...
           'Position',[25 90 100 25],...
           'String','Accept',...
           'Callback',@popup_callbackmo);
 cerrar2 = uicontrol('Parent',k,...
           'Style','push',...
           'Position',[25 40 100 25],...
           'String','Closed',...
           'Callback',@cerrar);
  x=source.UserData;
  function popup_callbackmo(hObject,callbackdata)
          elec=get(popup_mo,'Value');      
    if elec ==1
      edit_modelo1_mol(x)
    end
    
  end
end