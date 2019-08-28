function cargar2(hObject,eventdata)

global h Info a b Resultados_push axesgnu


figext = '.fig';
figname = strrep(file,'.mat', figext);
Figure= fullfile(FolderName, figname);
close all
h=openfig(Figure); %Figura abierta desde archivo .fig
axesgnu=findobj('Type','axes');
for i=1:length(h.Children)
    if strcmp(h.Children(i).Type,'uimenu') == 1
        if strcmp(h.Children(i).Label,'Resultados') == 1
            Resultados_push=h.Children(i);
        end
    end
end
n=length(h.Children); %Longitud vector hijos figura h
 
Object=findobj(h.Children,'Type','axes');

    for k=1:cu %cu, contador global, flujos, módulos
        
        if strcmp(Info(k).tag,'Flujo') == 1 %Identificación Tag archivo Info, por igualadad de identificador objeto h.Children(x).Children(y) es del mismo tipo
            for j=1:length(Object.Children) %Tamaño vector hijos del objeto axes encontrado
                if strcmp(get(Object.Children(j),'Type'),'text') == 1 %Busqueda objetos tipo texto
                    if isequal(getappdata(Object.Children(j),'TagIdentifier'),Info(k).k) == 1 % Se obtiene información de app de los objetos del axes y se comparan con los distintos identificadores del archivo Info    
                        for g=1:n
                            if strcmp(get(h.Children(g),'Type'),'uicontextmenu') == 1
                                if (getappdata(h.Children(g),'TagIdentifier')) == Info(k).k                                    
                                    Object.Children(j).UIContextMenu=h.Children(g);
                                    Object.Children(j).UIContextMenu.Children(1).UserData=k;
                                    ck=0;
                                    for l=1:length(Object.Children)                                        
                                        ck=ck+1;
                                        if isequal(getappdata(Object.Children(l),'TagIdentifier'),Info(k).k) == 1 && strcmp(get(Object.Children(l),'Type'),'text') == 0
                                            Object.Children(j).UserData.points(ck)=Object.Children(l);
                                            Object.Children(j).UserData.image=1;
                                            Info(k).h=Object.Children(j);
                                        end
                                    end  
                                end                            
                            end
                        end
                    end                
                end                
            end
        end
        
        if strcmp(Info(k).tag,'Molino Convencional') == 1 %Identificación Tag archivo Info, por igualadad de identificador objeto h.Children(x).Children(y) es del mismo tipo
            for j=1:length(Object.Children) %Tamaño vector hijos del objeto axes encontrado
                if strcmp(get(Object.Children(j),'Type'),'image') == 1 %Busqueda objetos tipo texto
                    if isequal(getappdata(Object.Children(j),'TagIdentifier'),Info(k).k) == 1 % Se obtiene información de app de los objetos del axes y se comparan con los distintos identificadores del archivo Info    
                        for g=1:n
                            if strcmp(get(h.Children(g),'Type'),'uicontextmenu') == 1
                                if (getappdata(h.Children(g),'TagIdentifier')) == Info(k).k                                    
                                    Object.Children(j).UIContextMenu=h.Children(g);
                                    Object.Children(j).UIContextMenu.Children(1).UserData=k;
                                    Object.Children(j).UIContextMenu.Children(2).UserData=k;
                                    Object.Children(j).UIContextMenu.Children(3).UserData=k;
                                    ck=0;
                                    for l=1:length(Object.Children)                                        
                                        ck=ck+1;
                                        if isequal(getappdata(Object.Children(l),'TagIdentifier'),Info(k).k) == 1 && strcmp(get(Object.Children(l),'Type'),'image') == 0
                                            Object.Children(j).UserData.points(ck)=Object.Children(l);
                                            Info(k).h=Object.Children(j);
                                        end
                                    end  
                                end                            
                            end
                        end
                    end                
                end                
            end
        end
        
        if strcmp(Info(k).tag,'Hidrociclon') == 1 %Identificación Tag archivo Info, por igualadad de identificador objeto h.Children(x).Children(y) es del mismo tipo
            for j=1:length(Object.Children) %Tamaño vector hijos del objeto axes encontrado
                if strcmp(get(Object.Children(j),'Type'),'image') == 1 %Busqueda objetos tipo texto
                    if isequal(getappdata(Object.Children(j),'TagIdentifier'),Info(k).k) == 1 % Se obtiene información de app de los objetos del axes y se comparan con los distintos identificadores del archivo Info    
                        for g=1:n
                            if strcmp(get(h.Children(g),'Type'),'uicontextmenu') == 1
                                if (getappdata(h.Children(g),'TagIdentifier')) == Info(k).k                                    
                                    Object.Children(j).UIContextMenu=h.Children(g);
                                    Object.Children(j).UIContextMenu.Children(1).UserData=k;
                                    Object.Children(j).UIContextMenu.Children(2).UserData=k;
                                    Object.Children(j).UIContextMenu.Children(3).UserData=k;
                                    ck=0;
                                    for l=1:length(Object.Children)                                        
                                        ck=ck+1;
                                        if isequal(getappdata(Object.Children(l),'TagIdentifier'),Info(k).k) == 1 && strcmp(get(Object.Children(l),'Type'),'image') == 0
                                            Object.Children(j).UserData.points(ck)=Object.Children(l);
                                            Info(k).h=Object.Children(j);
                                        end
                                    end  
                                end                            
                            end
                        end
                    end                
                end                
            end
        end

        if strcmp(Info(k).tag,'Entrada') == 1 %Identificación Tag archivo Info, por igualadad de identificador objeto h.Children(x).Children(y) es del mismo tipo
            for j=1:length(Object.Children) %Tamaño vector hijos del objeto axes encontrado
                if strcmp(get(Object.Children(j),'Type'),'text') == 1 %Busqueda objetos tipo texto
                    if isequal(getappdata(Object.Children(j),'TagIdentifier'),Info(k).k) == 1 % Se obtiene información de app de los objetos del axes y se comparan con los distintos identificadores del archivo Info    
                        for g=1:n
                            if strcmp(get(h.Children(g),'Type'),'uicontextmenu') == 1
                                if (getappdata(h.Children(g),'TagIdentifier')) == Info(k).k                                    
                                    Object.Children(j).UIContextMenu=h.Children(g);
                                    Object.Children(j).UIContextMenu.Children(1).UserData=k;
                                    Object.Children(j).UIContextMenu.Children(2).UserData=k;
                                    ck=0;
                                    for l=1:length(Object.Children)                                        
                                        ck=ck+1;
                                        if isequal(getappdata(Object.Children(l),'TagIdentifier'),Info(k).k) == 1 && strcmp(get(Object.Children(l),'Type'),'text') == 0
                                            Object.Children(j).UserData.points(ck)=Object.Children(l);
                                            Object.Children(j).UserData.image=1;
                                            Info(k).h=Object.Children(j);
                                        end
                                    end  
                                end                            
                            end
                        end
                    end                
                end                
            end
        end
        
         if strcmp(Info(k).tag,'Sumador') == 1 %Identificación Tag archivo Info, por igualadad de identificador objeto h.Children(x).Children(y) es del mismo tipo
            for j=1:length(Object.Children) %Tamaño vector hijos del objeto axes encontrado
                if strcmp(get(Object.Children(j),'Type'),'image') == 1 %Busqueda objetos tipo texto
                    if isequal(getappdata(Object.Children(j),'TagIdentifier'),Info(k).k) == 1 % Se obtiene información de app de los objetos del axes y se comparan con los distintos identificadores del archivo Info    
                        for g=1:n
                            if strcmp(get(h.Children(g),'Type'),'uicontextmenu') == 1
                                if (getappdata(h.Children(g),'TagIdentifier')) == Info(k).k                                    
                                    Object.Children(j).UIContextMenu=h.Children(g);
                                    Object.Children(j).UIContextMenu.Children(1).UserData=k;                                    
                                    ck=0;
                                    for l=1:length(Object.Children)                                        
                                        ck=ck+1;
                                        if isequal(getappdata(Object.Children(l),'TagIdentifier'),Info(k).k) == 1 && strcmp(get(Object.Children(l),'Type'),'image') == 0
                                            Object.Children(j).UserData.points(ck)=Object.Children(l);
                                            Info(k).h=Object.Children(j);
                                        end
                                    end  
                                end                            
                            end
                        end
                    end                
                end                
            end
        end
        
    end

        
        
        
        
        

% set(gcf,'outerposition',[0 0 1 1])
% h.Children=FigData;
% set(h,'Children',FigData)
% for i=1:length(h.Children)
%     if strcmp(get(h.Children(i),'Type'),'axes') == 1
%         k=i;
%         axesgnu=h.Children(i);
%     end
% end
% 
% % h.Children=F.Children;
% for i=1:length(h.Children(k).Children)
%     if strcmp('image',get(h.Children(k).Children(i),'Type')) == 1
%         for j=1:length(Info)
%             if strcmp(Info(j).tag2,get(h.Children(k).Children(i),'Tag')) == 1;
%                 Info(j).h=h.Children(k).Children(i);
%             end
%         end
%     end
% end
drawnow;
a=1366;
b=1280;
end