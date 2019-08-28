function Split_modelos(source,~)
  global cx cy k ck Info cu v a b axesgnu  cumc elec
    
   

     axis([0 a 0 b])
     f_split=figure;
     set(f_split,'name','Split','numbertitle','off','Position', [500,200,150,200],'Units','pixels','menubar','none','units','normalized','closereq',@Cancelar_callback)
        
     bg = uibuttongroup(f_split);
set(bg,'Visible','on',...
                  'Position',[0 0 1 1],...
                  'SelectionChangedFcn',@callback);

tagtxt = uicontrol(bg,'Style','text',...
                  'String','Upper Fraction',...
                  'Position',[35 135 80 30],...
                  'HandleVisibility','off');     

edit = uicontrol(bg,'Style','edit',...
                  'String','',...
                  'Position',[35 105 80 30],...
                  'HandleVisibility','off');          
Aceptar = uicontrol('Parent',bg,...
           'Style','push',...
           'String','Accept',...
           'Position',[15 40 120 25],...           
           'Callback',@Aceptar_callback);
Cancelar = uicontrol('Parent',bg,...
           'Style','push',...
           'Position',[15 15 120 25],...
           'String','Cancel',...
           'Callback',@Cancelar_callback);
       
 waitfor(f_split)
    
    function Cancelar_callback(~,~)
          state=0;
          delete(f_split)
    end
    function Aceptar_callback(~,~)
         fract=[];
         fract=edit.String;
        if isempty(fract)
             warndlg('Add Split Upper Fraction');
        elseif str2double(fract) > 1 || str2double(fract) < 0 
            warndlg('Invalid Value');
        else
            k=source.UserData.c;
            Info(k).Container=fract;
            delete(f_split)
        end 
       
    end


    
     waitfor(f_split)
end