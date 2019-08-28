function guardar(hObject,eventdata)
global h k  cu cu2 Info   cx cy e ec B n cuf A ch  v cuff

[file,path] = uiputfile('*.mat','Guardar Proyecto')

if file == 0 
    return
end

% figext = '.fig';
figname = strrep(file,'.mat','.fig')
% figname=sprintf('%s.fig',file)
% save(h,[path figname])
save(sprintf('%s%s',path,figname))
filename=sprintf('%s',file)
% save([path file])
save(filename)
end
