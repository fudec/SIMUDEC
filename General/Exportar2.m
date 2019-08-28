
n=length(X);
m=length(X(1).Streams.Stream.Value);
Value_Matrix=zeros(m,n);
for i=1:n
    for j=1:m
        Value_Matrix(j,i)=X(i).Streams.Stream.Value(j);
    end
end
for i=1:n
        P80Vector(i)=X(i).P80;
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
     c{1+(m+5)*n}='Tamaño [mm]';
     
 for i=1:n
     c{(m+5)*(i-1)+(m+2)}=X(i).Mass; %% Masa Total
 end
 for i=1:n
     c{(m+5)*(i-1)+(m+3)}=X(i).ro; %% Densidad
 end
 for i=1:n
     c{(m+5)*(i-1)+(m+4)}=X(i).ps; %% %Sólido
 end
 
 for i=1:n
     c{(m+5)*(i-1)+(m+5)}=X(i).P80; %% P80
 end
 