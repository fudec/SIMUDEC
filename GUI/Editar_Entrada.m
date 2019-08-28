function Editar_Entrada(source,~)
global Info cu m
k = get_index(source);
state = 1;
m = Info(k).Stream.Value;

w = sum(m(1:end-1))/sum(m)*100;
FW = m(end);

rrr=figure;
set(rrr,'name','Input Stream','numbertitle','off','Position', [200, 350, 200, 150],'Units','pixels','menubar','none','units','normalized','Resize','off','CloseRequestFcn',@cerrare)

function cerrare(~,~)
    data = rrr.Children(3).UserData;
    
    if isempty(data)
        choice = questdlg('Not saved anythin yet. Continue?', 'Warning', 'Yes','No','No');
        switch choice
            case 'Yes'
            delete(rrr)
            state = 0;
             case 'No'
             return      
        end
    else
        delete(rrr)
        return
    end
end

bg = uibuttongroup(rrr);
set(bg,'Visible','on',...
                  'Position',[0 0 1 1],...
                  'SelectionChangedFcn',@bselection);
r1 = uicontrol(bg,'Style',...
                  'radiobutton',...
                  'String','w/w%',...
                  'Position',[10 120 20 30],...
                  'HandleVisibility','off');
              
r2 = uicontrol(bg,'Style','radiobutton',...
                  'String','Water',...
                  'Position',[10 80 20 30],...
                  'HandleVisibility','off');
              
 Agregar_Button= uicontrol('style','push','string','Size distribution','Callback',@AgregarEntrada_Edit,...
                 'position',[30,40,150,20]);
             Agregar_Button.UserData.cu = cu;
             Agregar_Button.UserData.m = m;

 w_Text=uicontrol('Parent',bg,...
           'Style','text',...
           'Position',[80 120 25 25],...
           'String','%w');
 Water_Text=uicontrol('Parent',bg,...
           'Style','text',...
           'Position',[70 80 50 25],...
           'String','Water [m3/h]');
 
 Water_Edit= uicontrol('Parent',rrr,...
           'Style','edit',...
           'Position',[130 80 50 25],...
           'String','0'); 

 w_Edit = uicontrol('Parent',rrr,...
           'Style','edit',...
           'Position',[130 120 50 25],...
           'String','0');
       
 set(w_Edit,'Enable','on');
 set(Water_Edit,'Enable','off');
 
function bselection(~,event)   
        selec=get(event.NewValue,'String');
       if isequal(selec,'Water') 
               set(Water_Edit,'Enable','on')
               set(w_Edit,'Enable','off')              
       else
               set(Water_Edit,'Enable','off')
               set(w_Edit,'Enable','on')             
       end
 end
Cerrar = uicontrol('Parent',rrr,'style','push','string','Close','Callback',@cerrare,...
      'position',[2,2,100,22]);
Water_Edit.UserData=cu;
aceptar=uicontrol;           
aceptar.UserData.Edit=[Water_Edit w_Edit];
aceptar.UserData.m = m;
SaveB= aceptar;
set(aceptar,'Parent',rrr,...
           'Style','push',...
           'Position',[103 2 100 22],...
           'String','Save',...
           'Callback',@getPEN_Edit);

waitfor(rrr)
if state == 0
    return
end
Info(k).Stream.Value = m;
m=[];

end