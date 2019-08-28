function y=T10interCH(s)

% s=[47 25 23 19 17 16];

sizet=[0 10 20 30];
t=['t2' 't4' 't25' 't50' '75'];
M=[0 51.4 80.8 93;0 22.2 43.4 60.7;0 10 30 50;0 5.5 10.7 16.4;0 4 7.2 11.3;0 2.8 5.6 8.9];
s_I=[];
for i=1:length(s)
    s_I(:,i)=spline(sizet,M,s(i));
end
st=100*ones(1,length(s));
s_I=vertcat(st,s_I);
s_I=s_I/100;

s_Ts=[];
for i=1:length(s)
   s_Ts(:,i)=[s(i) s(i)/2 s(i)/4 s(i)/10 s(i)/25 s(i)/50 s(i)/75];
end
s_Tinter=[];
for i=1:length(s)
    s_Tinter(:,i)=[zeros(i-1,1);interp1(s_Ts(:,i),s_I(:,i),s(i+1:end)','linear')];    
end
s_Tinter=vertcat(zeros(1,length(s)),s_Tinter);
for j=1:length(s)
        s_Tinter(j,j)=1;
end
for j=1:length(s)
    for i=1:length(s)-1
        if i>=j
            s_Tinter(i,j)=s_Tinter(i,j)-s_Tinter(i+1,j);
        end
    end
end
y=s_Tinter;
end