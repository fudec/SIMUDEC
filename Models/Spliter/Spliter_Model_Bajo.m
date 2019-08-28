function Out = Spliter_Model_Bajo(X,In)
F = str2double(In.Container);
x=X(1:end-1);
win=X(end);
p=(1-F)*x;
win_out=(1-F)*win;
Out =[p;win_out];

end
