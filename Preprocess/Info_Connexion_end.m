function Info_Connexion_end(Nodes)
global cu Info
    for i = 1:cu-1
        for j = 1:length(Nodes)
            if ~strcmp(Info(i).tag,'Flujo') && ~strcmp(Info(i).tag,'Entrada')
                
                if Info(i).Node.Siweigth == Nodes(j).Nodes.Siweigth
                    Info(i).Nodes = Nodes(j).Nodes;
                end
            end
        end
    end
end
