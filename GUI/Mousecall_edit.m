function y=Mousecall_edit(hObject, eventdata, handles)
global cu Info v

if isempty(v) == 1
    wrnbox=warndlg('No se tiene vector de tamaños','Advertencia');
    return     
end

if strcmp(get(hObject,'SelectionType'),'open') == 1
    currentPoint = get(hObject, 'CurrentPoint');
    
   for t=1:cu
       if (Info(t).h.XData/1000-currentPoint(1))^2+(Info(t).h.YData/1000-currentPoint(2))^2 <= 25
           if strcmp(Info(t).tag,'Molino Convencional') == 1
               Molinoc_modelos_edit(t)
           elseif strcmp(Info(t).tag,'Hidrociclón') == 1
           end    
       end
   end
end

end