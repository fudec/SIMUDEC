function Out = Spliter_Model_Sobre(X,In)
F = str2double(In.Container);
x=X(1:end-1);
win=X(end);
p=F*x;
win_out=F*win;
Out =[p;win_out];

end
