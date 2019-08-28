function exportar(~,~)
global X v h
if isempty(X(1).Length)
    Message='There are not results';
    exito = warndlg(Message);
    return
end

[file,path] = uiputfile('*.xlsx','Save Project');
if file == 0
    return
end
fExt='.xls';
fName = strrep(file,'.xlsx','');

if exist(file, 'file')
  % Get number of files:
      fDir     = dir(fullfile(path, [fName, '*', fExt]));
      fStr     = lower(sprintf('%s*', fDir.name));
      fNum     = sscanf(fStr, [fName, '%d', fExt, '*']);
      newNum   = max(fNum) + 1;
      file = fullfile(path, [fName, sprintf('%d', newNum), fExt]);

end

n=length(X);
m=length(X(1).Streams.Stream.Value);
Value_Matrix=zeros(m,n);
for i=1:n
    for j=1:m
        Value_Matrix(j,i)=X(i).Streams.Stream.Value(j);
    end
end
vk=[v;0];
Value_Matrix=[Value_Matrix vk];

Value_Matrix=[zeros(1,n+1); Value_Matrix;zeros(1,n+1);zeros(1,n+1);zeros(1,n+1);zeros(1,n+1)];
for i=1:m+5
    pos1(i)=1;
end
for i=1:n+1
    pos2(i)=1;
end

 c = mat2cell(Value_Matrix,pos1,pos2);
 
 for i=1:n
     c{1+(m+5)*(i-1)}=X(i).Streams.Stream.Name;
 end
     c{1+(m+5)*n}='Size [mm]';
     
 for i=1:n
     c{(m+5)*(i-1)+(m+2)}=X(i).Mass; %% Masa Total
 end
 for i=1:n
     c{(m+5)*(i-1)+(m+3)}=X(i).ro; %% Densidad
 end
 for i=1:n
     c{(m+5)*(i-1)+(m+4)}=X(i).ps; %% %S�lido
 end
 
 for i=1:n
     c{(m+5)*(i-1)+(m+5)}=X(i).P80; %% P80
 end
 
wb = waitbar(0, 'Generating Report');
wbch = allchild(wb);
jp = wbch(1).JavaPeer;
jp.setIndeterminate(1)
file=[path file];
global cd
cd = c;
xlswrite(file,c,1,'D2');

    Excel = actxserver('excel.application');
    WB = Excel.Workbooks.Open(file,0,false);
    WB.Sheets.Item(1).Name='BM';
    Alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'; %%% Alfabeto
    rgb = [245 245 245];
    clr = rgb * [1 256 256^2]'; 

    RangesHeader=sprintf('$D$2:$%s$2',Alphabet(length(X)+4));
    Sheet=WB.Sheets.Item(1);
    rng = Sheet.Range(RangesHeader);
    rng.Border.Weight=3;
    rng.Interior.Color = clr;
    
    RangesBody=sprintf('D3:%s%d',Alphabet(length(X)+4),length(v)+7);
    rng = Sheet.Range(RangesBody);
    rng.Border.Weight=2;
    
    RangesCol=sprintf('A2:%s%d',Alphabet(length(X)+4),length(v)+7);
    rng = Sheet.Range(RangesCol);
    cols=rng.Columns(1);
    cols.ColumnWidth = 18;
    
    rng = Sheet.Range('A2');
    rng.Value='Project';
    rng.Interior.Color=clr;
    
    rng = Sheet.Range('$A$2:$B$2');
    rng.Border.Weight=3;
    
    RangesBody=sprintf('C3:C%d',length(v)+7);
    rng = Sheet.Range(RangesBody);
    rng.Border.Weight=2;
    
    rng = Sheet.Range('C3');
    rng.Value='Solid Mass [ton]';
    rng.Interior.Color=clr;
    
    rng = Sheet.Range(sprintf('C%d',length(v)+3));
    rng.Value='Liquid Mass [ton]';
    
    rng = Sheet.Range(sprintf('C%d',length(v)+4));
    rng.Value='Total Mass [ton]';
    
    rng = Sheet.Range(sprintf('C%d',length(v)+5));
    rng.Value='Density [ton/m3]';
    
    rng = Sheet.Range(sprintf('C%d',length(v)+6));
    rng.Value='Solid w/w%';
    
    rng = Sheet.Range(sprintf('C%d',length(v)+7));
    rng.Value='P80 [mm]';
    
    rng=Sheet.Range(sprintf('C%d:C%d',length(v)+3,length(v)+7));
    rng.Interior.Color=clr;
    
    F = getframe(h.CurrentAxes);
    Image = frame2im(F);
    fig=figure;
    AX=axes(fig);
    ZZ=image(AX,Image);
    AX.YTick = [];
    AX.XTick = [];
    set(fig,'Visible','off','Units','Normalized','Position', [0 0 1 1]);
    hgexport(fig,'-clipboard')
    
    Sheet2 = WB.Worksheets.Add();
    Sheet2.Name = 'Flowsheet';
    Sheet2.Activate;
    ActiveWindow.Zoom = 50;
    invoke(Sheet2, 'Activate');
    Paste(Sheet2,get(Sheet2,'Range','B2','B2'))
    close(fig)
    
    %%%%%% Usar Cellssssssss
    %%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      
    WB.Save();
    WB.Close();
    Excel.Quit();
% catch
%     Message='Error Formato';
%     delete(wb)
%     exito = msgbox(Message);
%     return
% end
    
    Message='Data exported';
    delete(wb)
    exito = msgbox(Message);
end