function Crusher_modelos(source,~)

global popup_mo 

answer=[];

answer = questdlg('This will delete previous models. Continue?', ...
	'Warning', ...
	'Yes','No','No');

if strcmp(answer,'No') || isempty(answer)
    return
end

 x = source.UserData.c;
 k=figure;
 set(k,'name','Model Selection','numbertitle','off','Position', [500,500,200,200],'Units','pixels','menubar','none','units','normalized')
 set(k,'resize','off')
 popup_mo=uicontrol('Parent',k,...
           'Style','popup',...
           'Position',[25 150 100 25],...
           'String',{'Whiten'},'Value',1);
 
 Aceptar = uicontrol('Parent',k,...
           'Style','push',...
           'Position',[25 90 100 25],...
           'String','Acept',...
           'Callback',@popup_callbackmo);
 cerrar2 = uicontrol('Parent',k,...
           'Style','push',...
           'Position',[25 40 100 25],...
           'String','Close',...
           'Callback',@cerrar);
  
  
  function popup_callbackmo(hObject,~)
    
    elec=get(popup_mo,'Value');      
    if elec ==1
      close(hObject.Parent);
      Crusher1(x)
    end
  end
  
end