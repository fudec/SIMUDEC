function [y,T2,time]=AlDefV2(B,S,M)
global v
tic 
S00=Stream(0);
S0=StreamsOut(1,S00);
S0I=StreamsIn(1,S00);
Node0=Node(0,S0,0,S0I);
V=Node_group;
n=length(B(:,1));
m=length(B(1,:));

for i=1:n
    NumEn=contarNrep(B(i,:),-1);
        Si=cell(NumEn,1);
        for j=1:m        
            if B(i,j) == 1
                So=StreamsOut(1,S(j).Streams);
            end
             co=1;
            for L=1:m
                if B(i,L) == -1
                    Si{co}=S(L).Streams;
                    co=co+1;
                end
            end
        end
    Si_=StreamsIn(NumEn,Si);
    V(i).Nodes=Node(i,So,M(i).Ecuacion,Si_);
end
U=Node_group0(length(V));
T=Stream_group0(length(S));
scu=1;
Orcu=1;
k=-1;
Min1000=1; % Step 1
StrengthW=zeros(n);
while k ~= n
W=resta(V,U); % Step 2
%%%%%%%%%%%%%%%%%
        Index_WMin0=zeros(n);
        Minv=zeros(1,n); % Step 3
        Min0cu=1;
        for i=1:n
                if W(i).Nodes.Index == 0
                    Minv(i)=100000; %%% Cambiar condicion de pesos quiz�s
                else
                    Minv(i)=W(i).Nodes.SumWIn;
                end
                
                if Minv(i) == 0
                    Index_WMin0(Min0cu)=i;
                    Min0cu=Min0cu+1;
                end
        end
        
            Min=min(Minv);
            if Min == 100000
                Min1000=Min1000+1;
                if Min1000 == n
                    break
                end
            end
        for i=1:n
            if W(i).Nodes.SumWIn > Min
                W(i).Nodes = Node0;
            end            
        end
        
      if Min == 0
          J = 0;
      elseif Min > 0
          J = 1;
      end     
           switch J          
                    case  0                   
                               % Step 4
                                U=suma(U,W);
                                           for i=1:length(W)
                                               for j=1:length(U)
                                                   if W(i).Nodes.Index ~= 0
                                                       if W(i).Nodes.Index == U(j).Nodes.Index                                      
                                                           U(j).Nodes.Order=Orcu;
                                                           Orcu=Orcu+1;
                                                       end
                                                   end
                                               end
                                           end
                                    for i=1:length(W)
                                            W(i).Nodes.Somark=1;
                                            W(i).Nodes.SumWOut=W(i).Nodes.SumWOut-W(i).Nodes.Soweigth;
                                        if isequal(W(i).Nodes.Index,V(i).Nodes.Index)==1
                                            W(i).Nodes.Somark=1;
                                            W(i).Nodes.SumWOut=W(i).Nodes.SumWOut-W(i).Nodes.Soweigth;
                                            V(i).Nodes.Somark=1;
                                            V(i).Nodes.SumWOut=V(i).Nodes.SumWOut-V(i).Nodes.Soweigth;                       
                                        end                       
                                        for j=1:n
                                            l=length(V(j).Nodes.Si);
                                            if l > 1
                                                for l=1:l
                                                    if isequal(W(i).Nodes.Soweigth,V(j).Nodes.Siweigth(l)) 
                                                        V(j).Nodes.Simark(l)=1;
                                                        W(i).Nodes.Somark=1;
                                                        W(i).Nodes.SumWOut=W(i).Nodes.SumWOut-W(i).Nodes.Soweigth;
                                                        V(j).Nodes.SumWIn=V(j).Nodes.SumWIn-V(j).Nodes.Siweigth(l);
                                                    end
                                                end
                                            elseif l == 1
                                                if isequal(W(i).Nodes.Soweigth,V(j).Nodes.Siweigth) 
                                                    V(j).Nodes.Simark=1;
                                                    V(j).Nodes.SumWIn=V(j).Nodes.SumWIn-V(j).Nodes.Siweigth;
                                                    W(i).Nodes.Somark=1;
                                                    W(i).Nodes.SumWOut=W(i).Nodes.SumWOut-W(i).Nodes.Soweigth;
                                                end
                                            end
                                        end
                                    end
                                    k=SumaWFun(U);
                                    continue
                    case 1
                                sumaW=SumaWFun(W);
                                if sumaW ~= 1
                                    L=2;                
                                elseif sumaW == 1
                                    L=3;                
                                end 
                      switch L
                                    case 2                   
                                 % Step 5                                    
                                    for i=1:length(W)
                                        Strength=0;
                                        for j=1:length(V)
                                            if length(V(j).Nodes.Si) == 1
                                            if iscell(V(j).Nodes.Si)
                                                if W(i).Nodes.So.weigth == V(j).Nodes.Si{1}.weigth
                                                    if W(i).Nodes.So.weigth ~= 0
                                                        Strength=Strength+1;
                                                    end
                                                end
                                            else
                                                if W(i).Nodes.So.weigth == V(j).Nodes.Si.weigth
                                                    if W(i).Nodes.So.weigth ~= 0
                                                        Strength=Strength+1;
                                                    end
                                                end
                                            end
                                            if iscell(W(j).Nodes.Si)
                                                if isequal(W(i).Nodes.So.weigth,W(j).Nodes.Si{1}.weigth) 
                                                    if W(i).Nodes.So.weigth ~= 0
                                                        W(j).Nodes=Node0;
                                                    end
                                                end
                                            else
                                                if isequal(W(i).Nodes.So.weigth,W(j).Nodes.Si.weigth) 
                                                    if W(i).Nodes.So.weigth ~= 0
                                                        W(j).Nodes=Node0;
                                                    end
                                                end
                                            end
                                            elseif length(V(j).Nodes.Si) == 2
                                                for l=1:2
                                                    if W(i).Nodes.So.weigth == V(j).Nodes.Si{l}.weigth
                                                        if W(i).Nodes.So.weigth == V(j).Nodes.Siweigth
                                                            Strength=Strength+1;
                                                            break
                                                        end
                                                    end
                                                end
                                            end
                                        end
                                        StrengthW(i)=Strength;
                                    end
                                    Max=max(StrengthW);
                                    for i=1:n
                                        if StrengthW(i) < Max
                                            W(i).Nodes=Node0;
                                        end
                                    end
                                    sumaW=SumaWFun(W);
                                               if sumaW ~= 1 % Step 6   
                                                    N=[];
                                                    for i=1:n
                                                        if W(i).Nodes.Index ~= 0
                                                            N=i;
                                                        end
                                                        if isempty(N) == 0
                                                            if i ~= N
                                                                W(i).Nodes=Node0;
                                                            end
                                                        end
                                                    end
                                               end
                                          % Step 7
                                          U=suma(U,W);
                                           for i=1:length(W)
                                               for j=1:length(U)
                                                   if W(i).Nodes.Index ~= 0
                                                       if W(i).Nodes.Index == U(j).Nodes.Index                                      
                                                           U(j).Nodes.Order=Orcu;
                                                           Orcu=Orcu+1;
                                                       end
                                                   end
                                               end
                                           end

                                            for i=1:n
                                                m=length(W(i).Nodes.Si);
                                                if W(i).Nodes.Index ~= 0
                                                    if m > 1
                                                       for j=1:m
                                                        if W(i).Nodes.Simark(j) == 0
                                                            T(scu).Streams=W(i).Nodes.Si{j};
                                                            scu=scu+1;
                                                        end 
                                                       end
                                                    elseif m == 1
                                                        if W(i).Nodes.Simark == 0
                                                            T(scu).Streams=W(i).Nodes.Si;
                                                            scu=scu+1;
                                                        end
                                                    end
                                                end
                                                    if isequal(W(i).Nodes.Index,V(i).Nodes.Index)
                                                        W(i).Nodes.Somark=1;
                                                        W(i).Nodes.SumWOut=W(i).Nodes.SumWOut-W(i).Nodes.Soweigth;
                                                        V(i).Nodes.Somark=1;
                                                        V(i).Nodes.SumWOut=V(i).Nodes.SumWOut-V(i).Nodes.Soweigth;                       
                                                    end
                                                for j=1:n
                                                    l=length(V(j).Nodes.Si);
                                                    if l > 1
                                                        for l=1:l
                                                            if isequal(W(i).Nodes.Soweigth,V(j).Nodes.Siweigth(l)) 
                                                                V(j).Nodes.Simark(l)=1;
                                                                W(i).Nodes.Somark=1;
                                                                W(i).Nodes.SumWOut=W(i).Nodes.SumWOut-W(i).Nodes.Soweigth;
                                                                V(j).Nodes.SumWIn=V(j).Nodes.SumWIn-V(j).Nodes.Siweigth(l);
                                                            end
                                                        end
                                                    else
                                                        if isequal(W(i).Nodes.Soweigth,V(j).Nodes.Siweigth)
                                                            V(j).Nodes.Simark=1;
                                                            V(j).Nodes.SumWIn=V(j).Nodes.SumWIn-V(j).Nodes.Siweigth;
                                                            W(i).Nodes.Somark=1;
                                                            W(i).Nodes.SumWOut=W(i).Nodes.SumWOut-W(i).Nodes.Soweigth;
                                                        end
                                                    end
                                                end
                                            end
                                            
                                            k=SumaWFun(U);
                                            continue

                                    case 3
                                          % Step 7
                                          U=suma(U,W);                                                              
                                           for i=1:length(W)
                                               for j=1:length(U)
                                                   if W(i).Nodes.Index ~= 0
                                                       if W(i).Nodes.Index == U(j).Nodes.Index                                      
                                                           U(j).Nodes.Order=Orcu;
                                                           Orcu=Orcu+1;
                                                       end
                                                   end
                                               end
                                           end                        
                                           for i=1:n
                                                m=length(W(i).Nodes.Si);
                                                if W(i).Nodes.Index ~= 0
                                                    if m > 1
                                                       for j=1:m
                                                        if W(i).Nodes.Simark(j) == 0
                                                            T(scu).Streams=W(i).Nodes.Si{j};
                                                            scu=scu+1;
                                                        end 
                                                       end
                                                    elseif m == 1
                                                        if W(i).Nodes.Simark == 0
                                                            T(scu).Streams=W(i).Nodes.Si;
                                                            scu=scu+1;
                                                        end
                                                    end
                                                end
                                                if isequal(W(i).Nodes.Index,V(i).Nodes.Index)
                                                    W(i).Nodes.Somark=1;
                                                    W(i).Nodes.SumWOut=W(i).Nodes.SumWOut-W(i).Nodes.Soweigth;
                                                    V(i).Nodes.Somark=1;
                                                    V(i).Nodes.SumWOut=V(i).Nodes.SumWOut-V(i).Nodes.Soweigth;                       
                                                end

                                                for j=1:n
                                                    l=length(V(j).Nodes.Si);
                                                    if l > 1
                                                        for l=1:l
                                                            if isequal(W(i).Nodes.Soweigth,V(j).Nodes.Siweigth(l))
                                                                V(j).Nodes.Simark(l)=1;
                                                                W(i).Nodes.Somark=1;
                                                                W(i).Nodes.SumWOut=W(i).Nodes.SumWOut-W(i).Nodes.Soweigth;
                                                                V(j).Nodes.SumWIn=V(j).Nodes.SumWIn-V(j).Nodes.Siweigth(l);
                                                            end
                                                        end
                                                    else
                                                        if isequal(W(i).Nodes.Soweigth,V(j).Nodes.Siweigth)
                                                            V(j).Nodes.Simark=1;
                                                            V(j).Nodes.SumWIn=V(j).Nodes.SumWIn-V(j).Nodes.Siweigth;
                                                            W(i).Nodes.Somark=1;
                                                            W(i).Nodes.SumWOut=W(i).Nodes.SumWOut-W(i).Nodes.Soweigth;
                                                        end
                                                    end
                                                end

                                            end
                                           k=SumaWFun(U);                                      
                                           continue
                      end
           end                  
end                                           


OrderGroup=Node_group;
n=length(U);
for i=1:n
    for j=1:n
        if U(j).Nodes.Order == i
           OrderGroup(i).Nodes=U(j).Nodes;
        end
    end
end

%%% Segunda Fase
m=length(T);
FG=1*ones(length(v),1);
FW=200;


% for i=1:m
%     for j=1:m
%         if iscell(T(i).Streams)
%             if isequal(T(i).Streams{1}.weigth,S(j).Streams.weigth)
%                 if isempty(S(j).Streams.Value) 
%                     S(j).Streams.Value=[FG;FW];
%                     S(j).Streams.WaterFlow=FW;
%                 end
%             end
%         else
%             if isequal(T(i).Streams.weigth,S(j).Streams.weigth) 
%                 if isempty(S(j).Streams.Value) 
%                     S(j).Streams.Value=[FG;FW];
%                     S(j).Streams.WaterFlow=FW;
%                 end
%             end
%         end
%     end
% end
for j =1:m
    if isempty(S(j).Streams.Value) 
        S(j).Streams.Value=[FG;FW];        
    end

end
for i=1:m
    S(i).Streams=StreamHandle(S(i).Streams);
end

m=length(T);
n=length(OrderGroup);
%%%% Entradas
% for i=1:n
%     for j=1:length(OrderGroup(i).Nodes.Si)
%         OrderGroup(i).Nodes.Si{j}=StreamHandle(OrderGroup(i).Nodes.Si{j});
%     end
%         OrderGroup(i).Nodes.So=StreamHandle(OrderGroup(i).Nodes.So);
% end

for i=1:n   
    for j=1:m
        for L=1:length(OrderGroup(i).Nodes.Si)
            if iscell(OrderGroup(i).Nodes.Si)
                if OrderGroup(i).Nodes.Si{L}.weigth == S(j).Streams.Stream.weigth
                        OrderGroup(i).Nodes.Si{L}=S(j).Streams;
                end
            else
                if OrderGroup(i).Nodes.Si{L}.weigth == S(j).Streams.Stream.weigth
                        OrderGroup(i).Nodes.Si{L}=S(j).Streams;
                end
            end
        end
        if iscell(S(j).Streams)
            if OrderGroup(i).Nodes.So.Stream.weigth == S(j).Streams.Stream.weigth
                    OrderGroup(i).Nodes.So=S(j).Streams;
            end
        else
            if OrderGroup(i).Nodes.So.weigth == S(j).Streams.Stream.weigth
                    OrderGroup(i).Nodes.So=S(j).Streams;
            end
        end
    end
end
% for i=1:m   
%     for j=1:n
%         r=length(OrderGroup(j).Nodes.Si);
%         if r > 1
%             for h=1:r
%                 if isprop(OrderGroup(j).Nodes.Si{h},'weigth') == 1
%                     if isequal(S(i).Streams.Stream.weigth,OrderGroup(j).Nodes.Si{h}.weigth) == 1
%                         OrderGroup(j).Nodes.Si{h}=S(i).Streams;
% %                         OrderGroup(j).Nodes.Si
% %                         S(i).Streams
%                     end
%                 elseif isprop(OrderGroup(j).Nodes.Si{h},'Stream')
%                     if isprop(OrderGroup(j).Nodes.Si{h}.Stream,'weigth')
%                         if isequal(S(i).Streams.Stream.weigth,OrderGroup(j).Nodes.Si{h}.Stream.weigth) == 1
%                             OrderGroup(j).Nodes.Si{h}=S(i).Streams;
%                         end    
%                     end
%                 end
%             end
%         end
%         if r == 1
%             if isprop(OrderGroup(j).Nodes.Si,'weigth') == 1
%                 if isequal(S(i).Streams.Stream.weigth,OrderGroup(j).Nodes.Si.weigth) == 1
%                         OrderGroup(j).Nodes.Si=S(i).Streams;
%                 end
%             elseif iscell(OrderGroup(j).Nodes.Si)
%                     if isprop(OrderGroup(j).Nodes.Si{1}.Stream,'weigth')
%                         if isequal(S(i).Streams.Stream.weigth,OrderGroup(j).Nodes.Si{1}.Stream.weigth) == 1
%                             OrderGroup(j).Nodes.Si{1}=S(i).Streams;
%                         end    
%                     end
%             end
%         end
%        
%     end
% end


% %%%%% Salidas
% for i=1:m
%     for j=1:n
%         if isprop(OrderGroup(j).Nodes.So,'weigth') == 1
%             
%             if isequal(S(i).Streams.Stream.weigth,OrderGroup(j).Nodes.So.weigth) == 1
%                 OrderGroup(j).Nodes.So=S(i).Streams;
%             end
%         end
%     end
% end
T2=S;
y=OrderGroup;
time=toc;
end
