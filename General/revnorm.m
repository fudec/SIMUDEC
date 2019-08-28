function revnorm(B)

n=length(B(:,1));
normi=zeros(n,1);
for i=1:n
    normi(i)=sum(B(:,i));
end

normi