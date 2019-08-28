function [B,S,M,A,Adj,Inc,Ms,flag]=PREPROCESO(cu)
Sexist=exist('S');
S2exist=exist('S2');
flag = 0;
if Sexist == 1   
    clear S 
end

if S2exist == 1   
    clear S2
end

global Info ch  e v1 scr Tromm sp
cu=cu-1;
Delta=1.6e1;
DeltaSumidero=15;
Exponent=0.29;
S=Stream_group;
v1=0; %%% Contadpr Flujos
v2=0; %%% Contador Modulos
ck=0;
cnsep = 0;
for i=1:cu
    if strcmp(Info(i).tag,'Stream')
        v1=v1+1;
    elseif ~strcmp(Info(i).tag,'Stream') && ~strcmp(Info(i).tag,'Input')
        v2=v2+1;
    end
end

for i=1:cu
    if strcmp(Info(i).tag,'Hydrocyclone')
           ck=ck+1;
    end
end

for i=1:cu
    if ~strcmp(Info(i).tag,'Stream') && ~strcmp(Info(i).tag,'Input') && ~strcmp(Info(i).tag,'Hydrocyclone') 
            cnsep = cnsep + 1;
    end
end

%%%% DOF an�lisis %%%%%%%5
DOF  = (cnsep+2*ck)-v1;
if e < DOF
    warndlg('Add more inputs');
    flag = 1;
end

A = struct;  %%% Estructura Matriz Principal
% 
% for i=1:cu  %%% Revision Modelos V�lidos
%     if strcmp(Info(i).tag,'Flujo')~= 1 && strcmp(Info(i).tag,'Entrada')~= 1 && strcmp(Info(i).tag,'Sumador')~= 1
%         if isfield(Info(i),'Container') == 0
%             wrnbox=warndlg(sprintf('M�dulo %s no tiene modelo v�lido ',Info(i).M),'Advertencia');
%             return
%         end
%         if isfield(Info(i),'Container') == 1
%                 if isempty(Info(i).Container) == 1
%                     wrnbox=warndlg(sprintf('M�dulo %s no tiene modelo v�lido ',Info(i).M),'Advertencia');
%                     return
%                 end
%         end
%     end
% end
f=0;  % Contador modulos, indexar
c=0;  % Contador flujos, indexar
e=0;  % Contador entradas, indexar
%%%%% Transferir informacion desde Archivo principal a fields del archivo
%%%%% principal
for i=1:cu
    if ~strcmp(Info(i).tag,'Stream') && ~strcmp(Info(i).tag,'Input')
            f=f+1;
            Info(f).n.k=f;
            Info(f).n.tag=Info(i).tag;
            Info(f).n.ioc=Info(i).ioc;
%             Info(f).n.val=Info(i).val;
%             Info(f).n.m=Info(i).m;
    end
    if strcmp(Info(i).tag,'Stream') || strcmp(Info(i).tag,'Input')
            c=c+1;
            Info(c).v.k=c;
            Info(c).v.tag=Info(i).tag;
            Info(c).v.ioc=Info(i).ioc;
            if isfield(Info(c),'val') 
                Info(c).v.val=Info(i).val;
            end
            Info(c).v.Stream=Info(i).Stream;
            
            if isfield(Info(c).v,'Name') 
                Info(c).v.Name=Info(i).Name;
            end
            if isfield(Info(i),'FW') 
                Info(c).v.FW=Info(i).FW;
            end
    end
    if strcmp(Info(i).tag,'Input')
            e=e+1;
            Info(e).en.k=e;
            Info(e).en.tag=Info(i).tag;
            Info(e).en.ioc=Info(i).ioc;
            Info(e).en.val=Info(i).en.val;
    end

end
%%% DOF analisys %%%%%
% DOF=c-f;
% if e ~= DOF
%     wrnbox=warndlg(sprintf('Es necesario especificar %d Entradas al sistema',DOF),'Advertencia');
%     return
% end

for i=1:cu
        if strcmp(Info(i).tag,'Stream')== 1  || strcmp(Info(i).tag,'Input')%%%% Aqui
              if  isfield(Info(i),'val')
                if isempty(Info(i).val) == 1
                    if isfield(Info(i),'v') == 1
                        if isfield(Info(i).v,'val') == 1
                        Info(i).v.Stream.Value=Info(i).v.val;
                        end
                    end
                end
              end
       end
end

if e == 0  %% Revisi�n entradas
    warninge = warndlg('System does not have inputs','');
    return
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%% Spliter %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
sp=0;
for k=1:f
    if strcmp(Info(k).n.tag,'Spliter')== 1
               sp=sp+1;
         for i=1:c
             if strcmp(Info(i).v.tag,'Stream')== 1 || strcmp(Info(i).v.tag,'Input')   
               if ((Info(i).v.ioc(1,1)-Info(k).n.ioc(1,1))^2+(Info(i).v.ioc(1,2)-Info(k).n.ioc(1,2))^2)^Exponent < Delta %Primer punto, descarga
% A(k,i).c=1; %%% Asignaci�n entradas o salida
                       A(v2+sp,i).F=sprintf('Stream %d',i); % Tag
                       A(v2+sp,i).tn=k; % Index modulo
                       A(v2+sp,i).c=1; % Asigancion entradas salidas, segundo Nodo hidrocicl�n
                       Info(k).RCS='S'; % Calculo de recirculacion
                       Info(k).RCSCount=[k i];
                       S(i).Streams=Info(i).v.Stream;                     
%                      M(k).Ecuacion=Info(k).n.tag;
                       M(v2+sp).Ecuacion=@Spliter_Model_Bajo;
                       A(v2+sp,1).M=Info(k).M;                      
               end
               if ((Info(i).v.ioc(1,1)-Info(k).n.ioc(2,1))^2+(Info(i).v.ioc(1,2)-Info(k).n.ioc(2,2))^2)^Exponent < Delta % Rebalse
                       A(k,i).c=1;
                       A(k,i).F=sprintf('Stream %d',i);
                       A(k,i).tn=k;
                       S(i).Streams=Info(i).v.Stream;
                       M(k).Ecuacion=@Spliter_Model_Sobre;
                       A(k,1).M=Info(k).M;
               end
               if ((Info(i).v.ioc(2,1)-Info(k).n.ioc(3,1))^2+(Info(i).v.ioc(2,2)-Info(k).n.ioc(3,2))^2)^Exponent < Delta % Entrada
                       A(k,i).c=-1;
                       A(k,i).F=sprintf('Stream %d',i);
                       A(k,i).tn=k;
                       A(v2+sp,i).c=-1;
                       Info(k).RCE='I';
                       Info(k).RCECount=[k i];
                       S(i).Streams=Info(i).v.Stream;
                       A(k,1).M=Info(k).M;
               end
             end
               
          end
    end
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Hydrocyclone %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k=1:f
    if strcmp(Info(k).n.tag,'Hydrocyclone')== 1
               sp=sp+1;
         for i=1:c
             if strcmp(Info(i).v.tag,'Stream')== 1 || strcmp(Info(i).v.tag,'Input')   
               if ((Info(i).v.ioc(1,1)-Info(k).n.ioc(1,1))^2+(Info(i).v.ioc(1,2)-Info(k).n.ioc(1,2))^2)^Exponent < Delta %Primer punto, descarga
% A(k,i).c=1; %%% Asignaci�n entradas o salida
                       A(v2+sp,i).F=sprintf('Stream %d',i); % Tag
                       A(v2+sp,i).tn=k; % Index modulo
                       A(v2+sp,i).c=1; % Asigancion entradas salidas, segundo Nodo hidrocicl�n
                       Info(k).RCS='S'; % Calculo de recirculacion
                       Info(k).RCSCount=[k i];
                       S(i).Streams=Info(i).v.Stream;                     
%                      M(k).Ecuacion=Info(k).n.tag;
                       M(v2+sp).Ecuacion=@Nageswararao_Bajo;
                       A(v2+sp,1).M=Info(k).M;                      
               end
               if ((Info(i).v.ioc(1,1)-Info(k).n.ioc(2,1))^2+(Info(i).v.ioc(1,2)-Info(k).n.ioc(2,2))^2)^Exponent < Delta % Rebalse
                   A(k,i).c=1;
                       A(k,i).F=sprintf('Stream %d',i);
                       A(k,i).tn=k;
                       S(i).Streams=Info(i).v.Stream;
                       M(k).Ecuacion=@Nageswararao_Sobre;
                       A(k,1).M=Info(k).M;
               end
               if ((Info(i).v.ioc(2,1)-Info(k).n.ioc(3,1))^2+(Info(i).v.ioc(2,2)-Info(k).n.ioc(3,2))^2)^Exponent < Delta % Entrada
                       A(k,i).c=-1;
                       A(k,i).F=sprintf('Stream %d',i);
                       A(k,i).tn=k;
                       A(v2+sp,i).c=-1;
                       Info(k).RCE='I';
                       Info(k).RCECount=[k i];
                       S(i).Streams=Info(i).v.Stream;
                       A(k,1).M=Info(k).M;
               end
             end
               
          end
    end
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Screener %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for k=1:f
    if strcmp(Info(k).n.tag,'Screener')
               sp=sp+1;
         for i=1:c
             if strcmp(Info(i).v.tag,'Stream')== 1 || strcmp(Info(i).v.tag,'Input')        
               if ((Info(i).v.ioc(1,1)-Info(k).n.ioc(1,1))^2+(Info(i).v.ioc(1,2)-Info(k).n.ioc(1,2))^2)^Exponent < Delta/2 %Primer punto, descarga
%                      A(k,i).c=1; %%% Asignaci�n entradas o salida
                       A(k,i).F=sprintf('Stream %d',i); % Tag
                       A(k,i).tn=k; % Index modulo
                       A(v2+sp,i).c=1; % Asigancion entradas salidas, segundo Nodo hidrocicl�n
                       Info(k).RCS='S'; % Calculo de recirculacion
                       Info(k).RCSCount=[k i];
                       S(i).Streams=Info(i).v.Stream;                     
%                      M(k).Ecuacion=Info(k).n.tag;
                       M(v2+sp).Ecuacion=@SCR_Model_Bajo;
                       A(k,1).M=Info(k).M;
                       
               end
               if ((Info(i).v.ioc(1,1)-Info(k).n.ioc(2,1))^2+(Info(i).v.ioc(1,2)-Info(k).n.ioc(2,2))^2)^Exponent < Delta/2 % Rebalse
                       A(k,i).c=1;
                       A(k,i).F=sprintf('Stream %d',i);
                       A(k,i).tn=k;
                       S(i).Streams=Info(i).v.Stream;
                       M(k).Ecuacion=@SCR_Model_Sobre;
                       A(k,1).M=Info(k).M;
               end
               if ((Info(i).v.ioc(2,1)-Info(k).n.ioc(3,1))^2+(Info(i).v.ioc(2,2)-Info(k).n.ioc(3,2))^2)^Exponent < Delta/2 % Entrada
                       A(k,i).c=-1;
                       A(k,i).F=sprintf('Stream %d',i);
                       A(k,i).tn=k;
                       A(v2+sp,i).c=-1;
                       Info(k).RCE='I';
                       Info(k).RCECount=[k i];
                       S(i).Streams=Info(i).v.Stream;
                       A(k,1).M=Info(k).M;
               end
             end
               
          end
    end
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Trommel %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:f
    if strcmp(Info(k).n.tag,'Trommel')== 1
               sp=sp+1;
         for i=1:c
             if strcmp(Info(i).v.tag,'Stream')== 1 || strcmp(Info(i).v.tag,'Input')   
               if ((Info(i).v.ioc(1,1)-Info(k).n.ioc(1,1))^2+(Info(i).v.ioc(1,2)-Info(k).n.ioc(1,2))^2)^Exponent < Delta/1.4 %Primer punto, descarga
% A(k,i).c=1; %%% Asignaci�n entradas o salida
                       A(v2+sp,i).F=sprintf('Stream %d',i); % Tag
                       A(v2+sp,i).tn=k; % Index modulo
                       A(v2+sp,i).c=1; % Asigancion entradas salidas, segundo Nodo hidrocicl�n
                       Info(k).RCS='S'; % Calculo de recirculacion
                       Info(k).RCSCount=[k i];
                       S(i).Streams=Info(i).v.Stream;                     
%                      M(k).Ecuacion=Info(k).n.tag;
                       M(v2+sp).Ecuacion=@Tromel_Model_Bajo;
                       A(v2+sp,1).M=Info(k).M;                      
               end
               if ((Info(i).v.ioc(1,1)-Info(k).n.ioc(2,1))^2+(Info(i).v.ioc(1,2)-Info(k).n.ioc(2,2))^2)^Exponent < Delta/1.4 % Rebalse
                       A(k,i).c=1;
                       A(k,i).F=sprintf('Stream %d',i);
                       A(k,i).tn=k;
                       S(i).Streams=Info(i).v.Stream;
                       M(k).Ecuacion=@Tromel_Model_Sobre;
                       A(k,1).M=Info(k).M;
               end
               if ((Info(i).v.ioc(2,1)-Info(k).n.ioc(3,1))^2+(Info(i).v.ioc(2,2)-Info(k).n.ioc(3,2))^2)^Exponent < Delta/1.4 % Entrada
                       A(k,i).c=-1;
                       A(k,i).F=sprintf('Stream %d',i);
                       A(k,i).tn=k;
                       A(v2+sp,i).c=-1;
                       Info(k).RCE='I';
                       Info(k).RCECount=[k i];
                       S(i).Streams=Info(i).v.Stream;
                       A(k,1).M=Info(k).M;
               end
             end
               
          end
    end
    
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Sumador %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:f
     for i=1:c
        if strcmp(Info(k).n.tag,'Sum')
            Info(k).n.ioc
           if length(Info(k).n.ioc(:,1)) == 2
                if strcmp(Info(i).v.tag,'Stream')== 1 || strcmp(Info(i).v.tag,'Input')
                      
                    if ((Info(i).v.ioc(2,1)-Info(k).n.ioc(1,1))^2+(Info(i).v.ioc(2,2)-Info(k).n.ioc(1,2))^2)^Exponent < Delta*1.1
                            A(k,i).c=-1;
                            A(k,i).F=sprintf('Stream %d',i);
                            A(k,i).tn=k;
                            S(i).Streams=Info(i).v.Stream;
                            M(k).Ecuacion=@Modulo_SUM;
                            A(k,i).M=Info(k).M;

                    end
                    if ((Info(i).v.ioc(2,1)-Info(k).n.ioc(2,1))^2+(Info(i).v.ioc(2,2)-Info(k).n.ioc(2,2))^2)^Exponent < Delta*1.1
                            A(k,i).c=-1;
                            A(k,i).F=sprintf('Stream %d',i);
                            A(k,i).tn=k;
                            S(i).Streams=Info(i).v.Stream;
                            M(k).Ecuacion=@Modulo_SUM;
                            A(k,1).M=Info(k).M;
                    end
                    
                    if ((Info(i).v.ioc(1,1)-Info(k).n.ioc(2,1))^2+(Info(i).v.ioc(1,2)-Info(k).n.ioc(2,2))^2)^Exponent < Delta*1.1
                            A(k,i).c=1;
                            S(i).Streams=Info(i).v.Stream;
                            M(k).Ecuacion=@Modulo_SUM;
                            A(k,1).M=Info(k).M;
                    end
                    
                end
    
                
           elseif length(Info(k).n.ioc(:,1))-1 == 3
               
               if strcmp(Info(i).v.tag,'Stream') || strcmp(Info(i).v.tag,'Input')
                      
                    if ((Info(i).v.ioc(2,1)-Info(k).n.ioc(1,1))^2+(Info(i).v.ioc(2,2)-Info(k).n.ioc(1,2))^2 )^Exponent< Delta
                            A(k,i).c=-1;
                            A(k,i).F=sprintf('Stream %d',i);
                            A(k,i).tn=k;
                            S(i).Streams=Info(i).v.Stream;
                            M(k).Ecuacion=@Modulo_SUM;
                    end
                    if ((Info(i).v.ioc(2,1)-Info(k).n.ioc(2,1))^2+(Info(i).v.ioc(2,2)-Info(k).n.ioc(2,2))^2)^Exponent < Delta
                            A(k,i).c=-1;
                            A(k,i).F=sprintf('Stream %d',i);
                            A(k,i).tn=k;
                            S(i).Streams=Info(i).v.Stream;
                            M(k).Ecuacion=@Modulo_SUM;
                    end
                    if ((Info(i).v.ioc(2,1)-Info(k).n.ioc(3,1))^2+(Info(i).v.ioc(2,2)-Info(k).n.ioc(3,2))^2)^Exponent < Delta
                            A(k,i).c=-1;
                            A(k,i).F=sprintf('Stream %d',i);
                            A(k,i).tn=k;
                            M(k).Ecuacion=@Modulo_SUM;
                    end
                    
                    if ((Info(i).v.ioc(1,1)-Info(k).n.ioc(4,1))^2+(Info(i).v.ioc(1,2)-Info(k).n.ioc(4,2))^2)^Exponent < Delta
                            A(k,i).c=1;
                            S(i).Streams=Info(i).v.Stream;
                            M(k).Ecuacion=@Modulo_SUM;
                    end
                    
               end
                
           elseif length(Info(k).n.ioc(:,1))-1 == 4
               
               if strcmp(Info(i).v.tag,'Stream') || strcmp(Info(i).v.tag,'Input')
                      
                    if ((Info(i).v.ioc(2,1)-Info(k).n.ioc(1,1))^2+(Info(i).v.ioc(2,2)-Info(k).n.ioc(1,2))^2)^Exponent < Delta
                            A(k,i).c=-1;
                            A(k,i).F=sprintf('Stream %d',i);
                            A(k,i).tn=k;
                            S(i).Streams=Info(i).v.Stream;
                            M(k).Ecuacion=Info(k).n.tag;
                            A(k,i).M=Info(k).M;
                    end
                    if ((Info(i).v.ioc(2,1)-Info(k).n.ioc(2,1))^2+(Info(i).v.ioc(2,2)-Info(k).n.ioc(2,2))^2)^Exponent < Delta
                            A(k,i).c=-1;
                            A(k,i).F=sprintf('Stream %d',i);
                            A(k,i).tn=k;
                            S(i).Streams=Info(i).v.Stream;
                            M(k).Ecuacion=Info(k).n.tag;
                    end
                    if ((Info(i).v.ioc(2,1)-Info(k).n.ioc(3,1))^2+(Info(i).v.ioc(2,2)-Info(k).n.ioc(3,2))^2)^Exponent < Delta
                            A(k,i).c=-1;
                            A(k,i).F=sprintf('Stream %d',i);
                            A(k,i).tn=k;
                            S(i).Streams=Info(i).v.Stream;
                            M(k).Ecuacion=Info(k).n.tag;
                    end
                    if ((Info(i).v.ioc(2,1)-Info(k).n.ioc(4,1))^2+(Info(i).v.ioc(2,2)-Info(k).n.ioc(4,2))^2)^Exponent < Delta
                            A(k,i).c=-1;
                            A(k,i).F=sprintf('Stream %d',i);
                            A(k,i).tn=k;
                            S(i).Streams=Info(i).v.Stream;
                            M(k).Ecuacion=Info(k).n.tag;
                    end
                                        
                    if ((Info(i).v.ioc(1,1)-Info(k).n.ioc(5,1))^2+(Info(i).v.ioc(1,2)-Info(k).n.ioc(5,2))^2)^Exponent < Delta
                            A(k,i).c=1;
                            S(i).Streams=Info(i).v.Stream;
                            M(k).Ecuacion=Info(k).n.tag;
                    end
                    
               end
                
           end
        end
     end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Molino Convencional %%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:f
    for i=1:c
           if strcmp(Info(k).n.tag,'Ball Mill')             
                if strcmp(Info(i).v.tag,'Stream') || strcmp(Info(i).v.tag,'Input')     
                   if ((Info(i).v.ioc(2,1)-Info(k).n.ioc(1,1))^2+(Info(i).v.ioc(2,2)-Info(k).n.ioc(1,2))^2)^Exponent < Delta*1.31                       
                       A(k,i).c=-1;
                       A(k,i).F=sprintf('Stream %d',i);
                       A(k,i).tn=k;
                       S(i).Streams=Info(i).v.Stream;
                       M(k).Ecuacion=@New_MSM;
                       A(k,1).M=Info(k).M;
                   end
                   if ((Info(i).v.ioc(1,1)-Info(k).n.ioc(2,1))^2+(Info(i).v.ioc(1,2)-Info(k).n.ioc(2,2))^2)^Exponent < Delta                      
                  
                       A(k,i).c=1;
                       S(i).Streams=Info(i).v.Stream;
                       M(k).Ecuacion=@New_MSM;
                       A(k,1).M=Info(k).M;
                   end
                end
           end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Molino SAG %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:f
    for i=1:c
           if strcmp(Info(k).n.tag,'SAG Mill')         
                if strcmp(Info(i).v.tag,'Stream') || strcmp(Info(i).v.tag,'Input')                   
                   if ((Info(i).v.ioc(2,1)-Info(k).n.ioc(1,1))^2+(Info(i).v.ioc(2,2)-Info(k).n.ioc(1,2))^2)^Exponent < Delta                       
                       A(k,i).c=-1;
                       A(k,i).F=sprintf('Stream %d',i);
                       A(k,i).tn=k;
                       S(i).Streams=Info(i).v.Stream;
                       M(k).Ecuacion=@SAG_Model;
                       A(k,1).M=Info(k).M;
                   end
                   if ((Info(i).v.ioc(1,1)-Info(k).n.ioc(2,1))^2+(Info(i).v.ioc(1,2)-Info(k).n.ioc(2,2))^2)^Exponent < Delta                      
                       A(k,i).c=1;
                       S(i).Streams=Info(i).v.Stream;
                       M(k).Ecuacion=@SAG_Model;
                       A(k,1).M=Info(k).M;
                   end
                end
           end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Chancador %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:f
    for i=1:c
           if strcmp(Info(k).n.tag,'Crusher')  
                if strcmp(Info(i).v.tag,'Stream') || strcmp(Info(i).v.tag,'Input')     
                   if ((Info(i).v.ioc(2,1)-Info(k).n.ioc(1,1))^2+(Info(i).v.ioc(2,2)-Info(k).n.ioc(1,2))^2)^1.2 < Delta*6000            
                       A(k,i).c=-1;
                       A(k,i).F=sprintf('Stream %d',i);
                       A(k,i).tn=k;
                       S(i).Streams=Info(i).v.Stream;
                       M(k).Ecuacion=@Chancador_Model;
                       A(k,1).M=Info(k).M;
                   end
                   if ((Info(i).v.ioc(1,1)-Info(k).n.ioc(2,1))^2+(Info(i).v.ioc(1,2)-Info(k).n.ioc(2,2))^2)^1.2 < Delta*6000    
                       A(k,i).c=1;
                       S(i).Streams=Info(i).v.Stream;
                       M(k).Ecuacion=@Chancador_Model;
                       A(k,1).M=Info(k).M;
                   end
                end
           end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Molino Rodillo %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:f
    for i=1:c
           if strcmp(Info(k).n.tag,'Rod Mill')           
                if strcmp(Info(i).v.tag,'Stream')  || strcmp(Info(i).v.tag,'Input')                 
                   if ((Info(i).v.ioc(2,1)-Info(k).n.ioc(1,1))^2+(Info(i).v.ioc(2,2)-Info(k).n.ioc(1,2))^2)^Exponent < Delta                       
                       A(k,i).c=-1;
                       A(k,i).F=sprintf('Stream %d',i);
                       A(k,i).tn=k;
                       S(i).Streams=Info(i).v.Stream;
                       M(k).Ecuacion=@RSM;
                       A(k,1).M=Info(k).M;
                   end
                   if ((Info(i).v.ioc(1,1)-Info(k).n.ioc(2,1))^2+(Info(i).v.ioc(1,2)-Info(k).n.ioc(2,2))^2)^Exponent < Delta                      
                       A(k,i).c=1;
                       S(i).Streams=Info(i).v.Stream;
                       M(k).Ecuacion=@RSM;
                       A(k,1).M=Info(k).M;
                   end
                end
           end
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%% Sumidero %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for k=1:f
    for i=1:c
           if strcmp(Info(k).n.tag,'Sumidero')              
                if strcmp(Info(i).v.tag,'Stream')  || strcmp(Info(i).v.tag,'Input')                   
                   if abs(Info(i).v.ioc(2,2)-Info(k).n.ioc(1,2)) < DeltaSumidero                       
                       A(k,i).c=-1;
                       A(k,i).F=sprintf('Stream %d',i);
                       A(k,i).tn=k;
                       S(i).Streams=Info(i).v.Stream;
                       M(k).Ecuacion=@Modulo_Sumidero;
                       A(k,1).M=Info(k).M;
                   end
                   if ((Info(i).v.ioc(1,1)-Info(k).n.ioc(2,1))^2+(Info(i).v.ioc(1,2)-Info(k).n.ioc(2,2))^2)^Exponent < Delta                      
                       A(k,i).c=1;
                       S(i).Streams=Info(i).v.Stream;
                       M(k).Ecuacion=@Modulo_Sumidero;
                       A(k,1).M=Info(k).M;
                   end
                end
           end
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Ms=size(A);
for i=1:Ms(1)
    for j=1:Ms(2)
        if isempty(A(i,j).c)
            A(i,j).c = 0;
        end
    end
end
Ms=size(A);
B=zeros(Ms(1),Ms(2));
for i=1:Ms(1)
    for j=1:Ms(2)
        B(i,j)=A(i,j).c;
    end
end

for i=1:length(S)
    for j=1:length(Info)
            if isfield(Info(j),'Stream') 
                if isprop(Info(j).Stream,'weigth')
                    if ~isempty(Info(j).Stream.weigth)
                        if Info(j).Stream.weigth == S(i).Streams.weigth
                            if isfield(Info(j),'en')
                                if strcmp(Info(j).tag,'Input')
                                    S(i).Streams.Value = Info(j).en.val
                                end
                            end
                        end
                    end
                end
            end
    end
end
Matrix=zeros(f+sp,c);
[m,n]=size(A);
for i=1:m
    for j=1:n
        Matrix(i,j)=A(i,j).c;
    end
end

Inc=Matrix';
[m,n]=size(Inc);
Adj=zeros(m,m);
for j=1:n
        IdxIn=find(Inc(:,j)==1);
        IdxOut=find(Inc(:,j)==-1);      
        Adj(IdxIn,IdxOut)=1;
end
Power = zeros(length(Adj(:,1)));
for k = 1:length(Adj(:,1))
    
    Power = Power + Adj^k;
end
 Power
if v2 > 1
    for i=1:length(Power)
        for j=1:length(Power)
%             if Power(i,j) == 0
%                 warndlg('System is no connected')
%                 flag = 1;F
%                 return
%             end
        end
    end
end
end