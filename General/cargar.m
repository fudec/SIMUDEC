function cargar(hObject,eventdata)
global h
clear all


% uiopen('*.mat') 
[File,PathName] = uigetfile('*.mat','Seleccionar proyecto');
FileName   = File;
FolderName = PathName;
File       = fullfile(FolderName, FileName);
load(File);   % not: load('File')

figext = '.fig';
figname = strrep(file,'.mat', figext);
Figure      = fullfile(FolderName, figname);
close all
h=openfig(Figure);
set(gcf,'outerposition',[0 0 1 1])
for i=1:length(h.Children)
    if strcmp(h.Children(i),'Axes') == 1
        k=1;
    end
end

for i=1:length(h.Children(k).Children)
    if strcmp('image',h.Children(k).Children(i)) == 1
        if strcmp(Info(i).tag2,h.Children(k).Children(i)) == 1;
            Info(i).h=h.Children(k).Children(i);
        end
    end
end

end